#!/usr/bin/env python

import numpy as np
import scipy.signal
import render

def conv2(in1, in2):
    return scipy.signal.convolve2d(in1, in2, 'same')

writefile = True
plot = False
datatype = "uint8"

np.random.seed(0)
filestem = 'results/flake_py'

maxiter = 1000 #4000
msize = 504 # THIS IS Y
nsize = 504 # THIS IS X

normreac = 0.1

flakem = np.zeros([msize, nsize], datatype)
flakem[2:-2, 2:-2] = 1
flakem[50, 50:450] = 0
flakem[450, 50:450] = 0
flakem[100:400, 250] = 0

flaket = np.copy(flakem)

if writefile:
    render.writeframe(filestem, 0, 'dat', flakem)

subcat = 2*(flakem == 2).sum()
conv = [flakem.sum() - subcat]

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
    import matplotlib.pyplot as plt
    plt.figure()
    plt.ion()

if writefile:
    import h5py
    framefile = h5py.File('frames.h5', mode='w')
    framedata = framefile.create_dataset('frames',
                                         (maxiter, msize, nsize),
                                         'uint8',
                                         compression='gzip',
                                         chunks=(1,msize,nsize)
                                         )
    
for i in xrange(maxiter):
    print 'i =', i

    flakem = np.copy(flaket)
    
    opensum = conv2(flakem==0, opencross)
    counters = opensum * (flakem==1)
    counts,_ = np.histogram(counters, countvec)
    print counts

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
    react = np.minimum(1, 1-(1-reactivity)**reactc)
    willreact = np.random.rand(msize, nsize) < react
    flaket[willreact] = 0
    
    if plot:
        plt.imshow(flaket)
        plt.draw()

    if writefile:
        framedata[i, :, :] = flaket
        framefile.flush()
        #render.writeframe(filestem, i, 'dat', flaket)
        
    
    subcat = 2*(flakem==2).sum()
    conv.append(flaket.sum()-subcat)
    if conv[-1] <= 1:
        break

    print 'Conversion:', (conv[0] - conv[-1])/conv[0]

if plot:
    plt.show()

if writefile:
    framefile.close()
