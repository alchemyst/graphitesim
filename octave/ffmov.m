function ffmov
iter=128;
msize=504;%24;%1004;   
nsize=504;%1004;   
figure;

map1(1,:)=[1 1 1];
map1(2,:)=[0.5 0.5 0.5];
map1(3,:)=[1 0 0];

for i=1:iter
  flaket = readframe('flake', i, 'dat', msize, nsize);
  imagename = datafilename('flake', i, 'png');
  flaket(msize+1,:)=0;
  flaket(:,nsize+1)=0;
    
  imshow(flaket);    
  colormap(map1);
  print( '-dpng', imagename);
end
