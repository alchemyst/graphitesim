function data = readframe(stem, frame, ext, msize, nsize)
  fid = fopen(datafilename(stem, frame, ext));
  data = fscanf(fid, '%f', [msize, nsize]);
  fclose(fid);
