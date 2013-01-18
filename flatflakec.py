#!/usr/bin/env python

import numpy as np
import scipy.signal
import matplotlib.pyplot as plt

def conv2(in1, in2):
    return scipy.signal.convolve2d(in1, in2, 'same')

writefile = True
plot = True
datatype = "uint8"

np.random.seed(0)
filestem = 'results/flake_py'

maxiter = 700 #4000
msize = 504
nsize = msize

normreac = 0.1

flakem = np.zeros([msize, nsize], datatype)
flakem[2:-2, 2:-2] = 1
flakem[50, 50:450] = 0
flakem[450, 50:450] = 0
flakem[100:400, 250] = 0

flaket = np.copy(flakem)

actives = [(flakem==1).sum()]

# Stencils
opencross = np.array([[0, 1, 0], 
                      [1, 0, 1], 
                      [0, 1, 0]], datatype)
circle = np.ones([3, 3], datatype)
circle[1, 1] = 0

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
    ASA.append(counts.sum() * countvec)
    x = counts/total[-1]
    xs.append(x)
    reactivity=normreac
    problog.append(reactivity)
    allcounts.append(counts)

    #bigcat_att = conv2(flakem, circle)
    # Figure out which graphite particles will react
    reactc = opensum
    reactprob = np.minimum(1, 1-(1-reactivity)**reactc)
    willreact = np.random.rand(msize, nsize) < reactprob
    flaket[willreact] = 0
    
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
        print 'Conversion:', (conv[0] - conv[-1])/conv[0]

if writefile:
    framefile.close()

if plot:
    plt.show()

