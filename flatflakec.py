#!/usr/bin/env python

# Author: Heinrich Badenhorst 2012
# Rewritten in Python by Carl Sandrock Jan 2013

# Issue list :
#              The initial "actives" calculation for catalyst system is wrong, perfect for no cat
#              Video creator not working

import numpy as np
import time

try:
    # Fortran library for convolution
    import sumcalcs
    convopencross = sumcalcs.opencross
    convcircle = sumcalcs.circle

except ImportError:
    # use scipy convolution
    import scipy.signal

    def conv2d(in1, in2):
        return scipy.signal.convolve2d(in1, in2, 'same')

    def convopencross(image):
        return conv2d(image, opencross)

    def convcircle(image):
        return conv2d(image, circle)

# Change these options for visualisation

writefile = False  # Write output to file
plot = True  # Generate an onscreen plot
catalyst = False  # Allow for catalyst
printstats = False  # Print statistics as the run proceeds
writeanimation = False  # Write animation to video file

datatype = "uint8"

np.random.seed(0)

maxiter = 1000 #4000
msize = 504
nsize = msize

normreac = 0.1 # Cannot be higher than 0.25
catprob = 4.0/100 # Probability of catalyst 10000/(504*504)
catreac = 1
scale_ideal = 1.62

# Stencils
opencross = np.array([[0, 1, 0],
                      [1, 0, 1],
                      [0, 1, 0]], datatype)
circle = np.ones([3, 3], datatype)
circle[1, 1] = 0

# Initialise shape
flakem = np.zeros([msize, nsize], datatype)
for xcoord in range(0,msize-1):
    for ycoord in range(0,nsize-1):
        radius = round(msize/2,0)
        positionR = ((xcoord-radius)**2+(ycoord-radius)**2)**0.5
        if positionR <= radius:
            flakem[xcoord,ycoord] = 1

graphite = flakem == 1

if catalyst:
    # Seed catalyst
    # Using 9 for the catalyst allows us to use only one convolution to find the sum of graphite particles and the number of catalyst neighbours
    randoms = np.random.rand(msize, nsize)
    flakem[(randoms < catprob) & graphite] = 9

flaket = np.copy(flakem)

actives = [graphite.sum()]

# Histories
total = []
ASA = []
ASAsc = []
ideal = []
problog = []
allcounts = []
xs = []

countvec = range(1, 6)

if plot:
    import matplotlib.pyplot as plt
    plt.ion()
    plt.subplot(2, 1, 1)
    im = plt.imshow(flakem)
    plt.subplot(2, 1, 2)
    [activeline1] = plt.plot(0, 1)
    [activeline2] = plt.plot(0, 1)
    plt.xlim(0, 1)
    plt.ylim(0, 2.5)

if writefile:
    import h5py
    framefile = h5py.File('frames.h5', mode='w')
    framedata = framefile.create_dataset('frames',
                                         (maxiter, msize, nsize),
                                         'uint8',
                                         compression='gzip',
                                         chunks=(1,msize,nsize))
if writeanimation:
    import cv, cv2
    videowriter = cv2.VideoWriter('frames.avi', cv.FOURCC(*'rle '), 24,
                                  (msize, nsize), True)
    print videowriter

for i in xrange(maxiter):
    flakem = np.copy(flaket)

    opensum = convopencross(flakem==0)
    graphite = flakem == 1
    counters = opensum * graphite
    counts,_ = np.histogram(counters, countvec)

    total.append(counts.sum())
    ASA.append(float((counts * countvec[1:5]).sum()))
    ASAsc.append(ASA[-1]/ASA[0])
    x = (actives[0] - actives[-1])/float(actives[0])
    xs.append(x)
    ideal.append((1-x)**0.5*scale_ideal)
    reactivity=normreac
    problog.append(reactivity)
    allcounts.append(counts)

    randoms = np.random.rand(msize, nsize)
    # Figure out which graphite particles will react
    reactc = opensum
    reactprob = np.minimum(1, reactivity*reactc)
    willreact = randoms < reactprob
    flaket[willreact & graphite] = 0

    if catalyst:
        closedsum = convcircle(flakem)
        catopen = (1 <= closedsum) & (closedsum <= 7) & (flakem == 9)
        for r, c in zip(*np.nonzero(catopen & (randoms < catreac))):
            if 1 < r < nsize and 1 < c < msize:
                whichone = np.random.randint(closedsum[r, c])
                neighbourhood = graphite[r-1:r+2, c-1:c+2]
                roffset, coffset = zip(*np.nonzero(neighbourhood))[whichone]
                flaket[r, c] = 0
                flaket[r+roffset-1, c+coffset-1] = 9


    actives.append((flaket == 1).sum())
    if actives[-1] <= 1:
        break

    if writefile:
        framedata[i, :, :] = flaket
        framefile.flush()

    if writeanimation:
        videowriter.write(cv2.cvtColor(flakem, cv2.COLOR_GRAY2BGR))

    if plot:
        im.set_data(flaket)
        activeline1.set_data(xs, ASAsc)
        activeline2.set_data(xs, ideal)
        plt.draw()
        plt.pause(0.01)

    if printstats:
        print 'i =', i
        print counts
        print 'Conversion:', (actives[0] - actives[-1])/float(actives[0])

if writefile:
    framefile.close()

if plot:
    plt.show()
    
