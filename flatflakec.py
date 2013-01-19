#!/usr/bin/env python

# Author: Heinrich Badenhorst 2012
# Rewritten in Python by Carl Sandrock Jan 2013

import numpy as np
import scipy.signal
import matplotlib.pyplot as plt

def conv2(in1, in2):
    return scipy.signal.convolve2d(in1, in2, 'same')

writefile = True
plot = True
catalyst = True

datatype = "uint8"

np.random.seed(0)

maxiter = 700 #4000
msize = 504
nsize = msize

normreac = 0.1
catprob = 4.0/100 # Probability of catalyst 10000/(504*504) 
catreac = 1

# Initialise shape
flakem = np.zeros([msize, nsize], datatype)
flakem[2:-2, 2:-2] = 1
flakem[50, 50:450] = 0
flakem[450, 50:450] = 0
flakem[100:400, 250] = 0

if catalyst:
    # Seed catalyst
    # Using 9 for the catalyst allows us to use only one convolution to find the sum of graphite particles and the number of catalyst neighbours
    flakem[(np.random.rand(msize, nsize) < catprob)
           & (flakem==1)] = 9 

flaket = np.copy(flakem)

actives = [(flakem==1).sum()]

# Stencils
opencross = np.array([[0, 1, 0], 
                      [1, 0, 1], 
                      [0, 1, 0]], datatype)
circle = np.ones([3, 3], datatype)
circle[1, 1] = 0

# Histories
total = []
ASA = []
problog = []
allcounts = []
xs = []

countvec = range(1,6)

if plot:
    plt.ion()
    plt.subplot(2, 1, 1)
    im = plt.imshow(flakem)
    plt.subplot(2, 1, 2)
    [activeline] = plt.plot(0, actives)
    plt.xlim(0, maxiter)
    plt.ylim(0, flakem.size)

if writefile:
    import h5py
    framefile = h5py.File('frames.h5', mode='w')
    framedata = framefile.create_dataset('frames',
                                         (maxiter, msize, nsize),
                                         'uint8',
                                         compression='gzip',
                                         chunks=(1,msize,nsize))
    
for i in xrange(maxiter):
    flakem = np.copy(flaket)
    
    opensum = conv2(flakem==0, opencross)
    counters = opensum * (flakem==1)
    counts,_ = np.histogram(counters, countvec)

    total.append(counts.sum())
    ASA.append((counts * countvec[1:5]).sum())
    x = counts/total[-1]
    xs.append(x)
    reactivity=normreac
    problog.append(reactivity)
    allcounts.append(counts)

    randoms = np.random.rand(msize, nsize)
    # Figure out which graphite particles will react
    reactc = opensum
    reactprob = np.minimum(1, 1-(1-reactivity)**reactc)
    willreact = randoms < reactprob
    flaket[willreact & (flakem==1)] = 0

    if catalyst:
        closedsum = conv2(flakem, circle)
        catopen = (1 <= closedsum) & (closedsum <= 7) & (flakem == 9)
        for r, c in zip(*np.nonzero(catopen & (randoms < catreac))):
            if 1 < r < nsize and 1 < c < msize:
                whichone = np.random.randint(closedsum[r, c])
                neighbourhood = flakem[r-1:r+2, c-1:c+2]
                roffset, coffset = zip(*np.nonzero(neighbourhood==1))[whichone]
                flaket[r, c] = 0
                flaket[r+roffset-1, c+coffset-1] = 9
        
    if writefile:
        framedata[i, :, :] = flaket
        framefile.flush()
    
    actives.append((flaket==1).sum())
    if actives[-1] <= 1:
        break

    if plot:
        im.set_data(flaket)
        activeline.set_data(np.arange(i+2), actives)
        plt.draw()
    else:
        print 'i =', i
        print counts
        print 'Conversion:', (actives[0] - actives[-1])/float(actives[0])

if writefile:
    framefile.close()

if plot:
    plt.show()

