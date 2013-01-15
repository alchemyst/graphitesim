function writeframe(stem, number, ext, data)
fid = fopen(datafilename(stem, number, ext), 'w');
fprintf(fid, '%2.0f', data);
fclose(fid);
