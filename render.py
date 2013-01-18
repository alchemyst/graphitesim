#!/usr/bin/env python

import sys
import numpy
import matplotlib.pyplot as plt

msize = 504
nsize = 504

def datafilename(stem, number, ext):
    return "%s%04i.%s" % (stem, number, ext)

def writeframe(stem, frame, ext, data):
    numpy.savetxt(datafilename(stem, frame, ext), data, fmt="%i")

def plotframe(plt, f):
    front, ext = f.split('.')
    d = numpy.loadtxt(f, dtype=numpy.uint8).reshape(msize, nsize)
    plt.imshow(d)
    plt.axis('off')
    plt.savefig(front + '_py.png')
    plt.close()

if __name__ == "__main__":
    for f in sys.argv[1:]:
        print f
        plotframe(plt, f)
