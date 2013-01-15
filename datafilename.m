function s = datafilename(stem, number, ext)
  s = sprintf('%s%04i.%s', stem, number, ext);
