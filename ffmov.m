function ffmov
clear
iter=1000;
msize=504;%24;%1004;   
nsize=504;%1004;   
figure;
cd('C:\MATLAB6p5\work\Data')
for i=100:iter
    
%        str1='flake100.m';
    str1=['flake' num2str(i-1) '.m'];
    str2=['flake' num2str(i-1) '.tif'];
	fid1=fopen(str1);
	flaket=fscanf(fid1,'%f',[msize nsize]);
    fclose(fid1);

    flaket(msize+1,:)=0;
    flaket(:,nsize+1)=0;
    
     map1(1,:)=[1 1 1];
     map1(2,:)=[0.5 0.5 0.5];
     map1(3,:)=[1 0 0];
     colormap(map1);
%    surface(flaket);    
     surface(flaket,'EdgeColor','none');    
    
  	set(gca,'Xlim',[0 msize]);
  	set(gca,'Ylim',[0 nsize]);
%   	set(gca,'Xlim',[0 nsize+2]);
%   	set(gca,'Ylim',[0 msize+2]);
  
  	set(gcf, 'Position', [10 10 710 710]);
%	pause(0.1)
%   set(gcf,'InvertHardcopy','off')
%	saveas(gcf,str2,'-r300 -zbuffer');
	print( '-dtiff', '-zbuffer', '-r300', str2);
	clf

end;
