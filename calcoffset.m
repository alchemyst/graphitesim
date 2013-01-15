function [ioffset, joffset] = calcoffset(i, j, index)
ioffset = i(index)-1;
joffset = j(index)-1;
