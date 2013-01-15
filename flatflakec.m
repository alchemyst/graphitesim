function [conv,total,ASA,one,two,three,four,problog]=flatflakec

cd('C:\MATLAB6p5\work\Data')
iter=2000;%4000;
msize=504;%1004; THIS IS Y
nsize=504;%1004; THIS IS X

makerandhole=false;%true;
makerand=false;%true;
% numblocks=1200;
% blocksize=30;
numblocks=1500;
blocksize=45;
makecirc=false;%true;
radius=250;
maketriangle=false;%true;
makerevtriangle=false;%true;
makecross=false;%true;
makecirchole=false;%true;
% radius=20;

cat=false;%true;
catreacstep=1;
catdist=10000;
% msize=1004;%5001;
% nsize=1004;%5001;
% catdist=1000;
normreacT=0.1;%0.0029;%0.05;%0.586569419;%0.7038833;%0.11111;
% normreacT=0.003652;%0.01436;%0.05;%0.586569419;%0.7038833;%0.11111;
% normreac=0.1;
% normreac=0.25;
% catreac=0.64;
% normreac=0.045;
normreact=1;   %for entire edge react sim
% numcat=50;
catreac=1;%;normreac*10;
% catreac=0.208;%0.4731;%1;%;normreac*10;
% normreac=1;
% normreact=10;

flakem=ones(msize,nsize);
% flakem(1:msize,800:nsize)=0;
flakem(1,:)=0;
flakem(2,:)=0;
flakem(:,1)=0;
flakem(:,2)=0;
flakem(msize,:)=0;
flakem(msize-1,:)=0;
flakem(:,nsize)=0;
flakem(:,nsize-1)=0;

% flakem(125,125)=0;
% flakem(125,375)=0;
% flakem(375,125)=0;
% flakem(375,375)=0;
% flakem(167,167)=0;
% flakem(167,333)=0;
% flakem(333,167)=0;
% flakem(333,333)=0;
% flakem(50,50)=0;
% flakem(50,450)=0;
% flakem(450,50)=0;
% flakem(450,450)=0;
flakem(50,50:450)=0;
flakem(450,50:450)=0;
flakem(100:400,250)=0;
% flakem(167,125:375)=0;
% flakem(333,125:375)=0;
% flakem(125:375,167)=0;

% flakem=zeros(msize,nsize);
% flakem(133:266,3:397)=1;
% flakem(3:397,133:266)=1;
% flakem=ones(msize,nsize);

if makecross
	flakem(200:800,499)=0;
	flakem(200:800,500)=0;
	flakem(200:800,501)=0;
	flakem(500,200:800)=0;
	flakem(499,200:800)=0;
	flakem(500,200:800)=0;
end;

% flakem(100:900,249)=0;
% flakem(100:900,250)=0;
% flakem(100:900,251)=0;
% flakem(100:900,749)=0;
% flakem(100:900,750)=0;
% flakem(100:900,751)=0;
% flakem(750:1000,500)=0;
% flakem(750:1000,499)=0;
% flakem(750:1000,501)=0;
% flakem(500,1:250)=0;
% flakem(499,1:250)=0;
% flakem(501,1:250)=0;
% flakem(500,750:1000)=0;
% flakem(499,750:1000)=0;
% flakem(501,750:1000)=0;
% flakem(50:450,250)=0;
% flakem(250,1:150)=0;
% flakem(250,350:500)=0;
% flakem(900:1004,500)=0;
% flakem(1:998,1)=1;
% flakem(1:998,2)=1;
% flakem(1:998,1004)=1;
% flakem(1:998,1003)=1;
% flakem(1,:)=1;
% flakem(2,:)=1;
%  flakem(301,1:400)=0;
%  flakem(301:404,100)=0;
%  flakem(301:404,200)=0;
%  flakem(301:404,300)=0;
%  flakem(400-round(rand*100),round(rand*100))=0;
%  flakem(400-round(rand*100),round(rand*100))=0;
%  flakem(400-round(rand*100),round(rand*100))=0;
%  flakem(400-round(rand*100),round(rand*100))=0;
%  flakem(400-round(rand*100),100+round(rand*100))=0;
%  flakem(400-round(rand*100),100+round(rand*100))=0;
%  flakem(400-round(rand*100),100+round(rand*100))=0;
%  flakem(400-round(rand*100),100+round(rand*100))=0;
%  flakem(400-round(rand*100),200+round(rand*100))=0;
%  flakem(400-round(rand*100),200+round(rand*100))=0;
%  flakem(400-round(rand*100),200+round(rand*100))=0;
%  flakem(400-round(rand*100),200+round(rand*100))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(round(rand*(msize-4)+2),round(rand*(nsize-4)+2))=0;
%  flakem(1:200,250)=0;
%  flakem(300:500,250)=0;
%  flakem(200,1:100)=0;
%  flakem(200,250:450)=0;
%  flakem(200:300,150)=0;
%  flakem(150,1:100)=0;
%  flakem(150,200:300)=0;

if makerand
    flakem=zeros(msize,nsize);
    for randcc=1:numblocks;
        x_coord=round(rand*(msize-4)+3);
        y_coord=round(rand*(nsize-4)+3);
        if x_coord+blocksize>msize-4
            blocksizex=msize-4-x_coord;
        else
            blocksizex=blocksize;
        end;
        if y_coord+blocksize>nsize-4
            blocksizey=nsize-4-y_coord;
        else
            blocksizey=blocksize;
        end;
        for randcc2=x_coord:x_coord+blocksizex
            for randcc3=y_coord:y_coord+blocksizey
                flakem(randcc2,randcc3)=1;
            end;
        end;
    end;
flakem(50:950,50:950)=1;
flakem(1,:)=0;
flakem(2,:)=0;
flakem(:,1)=0;
flakem(:,2)=0;
flakem(msize,:)=0;
flakem(msize-1,:)=0;
flakem(:,nsize)=0;
flakem(:,nsize-1)=0;
% flakem(round(rand*msize),round(rand*nsize))=0;
% flakem(round(rand*msize),round(rand*nsize))=0;
% flakem(round(rand*msize),round(rand*nsize))=0;
% flakem(round(rand*msize),round(rand*nsize))=0;
end;

if makecirc
    for x=-msize/2:msize/2
        for y=-nsize/2:nsize/2
            if (x^2+y^2)>radius^2
                if (x+msize/2~=0)&(y+nsize/2~=0)
                    flakem(x+msize/2,y+nsize/2)=0;
                end;
            end;
        end;
    end;
end;

if makecirchole
    for x=-msize/2:msize/2
        for y=-nsize/2:nsize/2
            if (x^2+y^2)<radius^2
                flakem(x+msize/2,y+nsize/2)=0;
            end;
        end;
    end;
end;

if makerandhole
% 	flakem(round(rand*msize*0.25)+100-10,round(rand*nsize*0.25)+200-10)=0;
% 	flakem(round(rand*msize*0.25)+600-10,round(rand*nsize*0.25)+200-10)=0;
% 	flakem(round(rand*msize*0.25)+600-10,round(rand*nsize*0.25)+700-10)=0;
% 	flakem(round(rand*msize*0.25)+100-10,round(rand*nsize*0.25)+700-10)=0;
	flakem(round(rand*msize),round(rand*nsize))=0;
	flakem(round(rand*msize),round(rand*nsize))=0;
	flakem(round(rand*msize),round(rand*nsize))=0;
	flakem(round(rand*msize),round(rand*nsize))=0;
	flakem(round(rand*msize),round(rand*nsize))=0;
	flakem(round(rand*msize),round(rand*nsize))=0;
	flakem(round(rand*msize),round(rand*nsize))=0;
	flakem(round(rand*msize),round(rand*nsize))=0;
end;

if maketriangle
    for x=-msize/2:msize/2
        for y=-nsize/2:nsize/2
            if x>(2*y+500)
                if (x+msize/2~=0)&(y+nsize/2~=0)
                    flakem(x+msize/2,y+nsize/2)=0;
                end;
            elseif x>(-2*y+500)
                 if (x+msize/2~=0)&(y+nsize/2~=0)
                    flakem(x+msize/2,y+nsize/2)=0;
                end;
%             if x>(y+250)&x>(-y+250)
%                 if (x+msize/2~=0)&(y+nsize/2~=0)
%                     flakem(x+msize/2,y+nsize/2)=0;
%                 end;
            end;
        end;
    end;
flakem(1:800,:)=1;
flakem(800:1004,1:2)=1;
flakem(800:1004,1003:1004)=1;
end;

if makerevtriangle
    for x=1:nsize
        for y=1:msize
            if ((x>(y-1900)/(-2))&(y>(-2*x+1900)))
                if ((x<(y+100)/(2))&(y>(2*x-100)))
                    flakem(y,x)=0;
                end;
            end;
        end;
    end;
flakem(msize,:)=0;
flakem(msize-1,:)=0;
end;

% flakec=zeros(msize,nsize);

if cat
%     for i=3:msize-2
%         if rem(i,numcat)==0
%             flakem(3,i)=2;
%             flakem(i,3)=2;
%             flakem(msize-2,i)=2;
%             flakem(i,nsize-2)=2;
%         end;
%     end;
    for i=1:catdist
%         flakem(round(rand*(msize-7)+4),round(rand*(nsize-7)+4))=2;
        cat_xcoord=round(rand*(msize-5)+3);
        cat_ycoord=round(rand*(nsize-5)+3);
        if flakem(cat_xcoord,cat_ycoord)==1
            flakem(cat_xcoord,cat_ycoord)=2;
        end;
    end;
end;

fid=fopen('flake0.m','w');
fprintf(fid,'%2.0f',flakem);
fclose(fid);
subcat=2*size(find(flakem==2),1);
conv(1)=sum(sum(flakem))-subcat;

% if cat
% 	fid2=fopen('cat0.m','w');
% 	fprintf(fid2,'%2.0f',flakec);
% 	fclose(fid2);
% end;
    h = waitbar(0,'The earth will end in:');
for i=1:iter
    if mod(i,catreacstep)==0
        normreac=normreacT;
    else
        normreac=0;
    end;
	str1=['flake' num2str(i-1) '.m'];
	fid1=fopen(str1);
	flakem=fscanf(fid1,'%f',[msize nsize]);
    fclose(fid1);

    one_count=0;
	two_count=0;
	three_count=0;
	four_count=0;
    
    for j=3:msize-2
        for k=3:nsize-2
            if flakem(j,k)==1
                counter=0;
                if flakem(j+1,k)==0
                    counter=counter+1;
                end;
                if flakem(j-1,k)==0
                    counter=counter+1;
                end;
                if flakem(j,k+1)==0
                    counter=counter+1;
                end;
                if flakem(j,k-1)==0
                    counter=counter+1;
                end;
                if counter==1
                    one_count=one_count+1;
                elseif counter==2
                    two_count=two_count+1;
                elseif counter==3
                    three_count=three_count+1;
                elseif counter==4
                    four_count=four_count+1;
                end;
            end;
        end;
    end;

	total(i)=one_count+two_count+three_count+four_count;
	ASA(i)=one_count+2*two_count+3*three_count+4*four_count;
	xone=one_count/total(i);
	xtwo=two_count/total(i);
	xthree=three_count/total(i);
	xfour=four_count/total(i);
	reactivity=normreac;%/(xone+2*xtwo+3*xthree+4*xfour);%normreac/(xone+2*xtwo+3*xthree+4*xfour);
    problog(i)=reactivity;
    one(i)=one_count;
    two(i)=two_count;
    three(i)=three_count;
    four(i)=four_count;
    flaket=flakem;
    
    for j=3:msize-2
        for k=3:nsize-2
            if flakem(j,k)==1
                if flaket(j,k)~=2
					react=0;
                    reactc=0;
					if flakem(j+1,k)==0
                        reactc=reactc+1;
					end;
					if flakem(j-1,k)==0
                        reactc=reactc+1;
					end;
					if flakem(j,k+1)==0
                        reactc=reactc+1;
					end;
					if flakem(j,k-1)==0
                        reactc=reactc+1;
					end;
%                    react=(reactivity)*reactc;
                    react=1-(1-reactivity)^reactc;
                     if react>1
                         react=1;
                     end;
					if (rand<react)&(rem(i,normreact)==0)
                        may_reac=0;
                        cat_att=0;
                        has_reac=0;
                        is_cat=0;
                        if flakem(j+1,k)==2
                            is_cat=1;
                            cat_att=flakem(j+2,k)+flakem(j+2,k+1)+flakem(j+2,k-1)+flakem(j+1,k+1)+flakem(j+1,k-1)+flakem(j,k)+flakem(j,k+1)+flakem(j,k-1);
                            if cat_att>1
                                may_reac=1;
                            elseif (cat_att==1)&(~has_reac)
                                flaket(j+1,k)=0;                                
                                flaket(j,k)=2;
                                has_reac=1;
                            end;
                        end;
                        if flakem(j-1,k)==2
                            is_cat=1;
                            cat_att=flakem(j-2,k)+flakem(j-2,k+1)+flakem(j-2,k-1)+flakem(j-1,k+1)+flakem(j-1,k-1)+flakem(j,k)+flakem(j,k+1)+flakem(j,k-1);
                            if cat_att>1
                                may_reac=1;
                            elseif (cat_att==1)&(~has_reac)
                                flaket(j-1,k)=0;                                
                                flaket(j,k)=2;
                                has_reac=1;
                            end;
                        end;
                        if flakem(j,k+1)==2
                            is_cat=1;
                            cat_att=flakem(j+1,k+2)+flakem(j,k+2)+flakem(j-1,k+2)+flakem(j+1,k+1)+flakem(j-1,k+1)+flakem(j+1,k)+flakem(j,k)+flakem(j-1,k);
                            if cat_att>1
                                may_reac=1;
                            elseif (cat_att==1)&(~has_reac)
                                flaket(j,k+1)=0;                                
                                flaket(j,k)=2;
                                has_reac=1;
                            end;
                        end;
                        if flakem(j,k-1)==2
                            is_cat=1;
                            cat_att=flakem(j+1,k-2)+flakem(j,k-2)+flakem(j-1,k-2)+flakem(j+1,k-1)+flakem(j-1,k-1)+flakem(j+1,k)+flakem(j,k)+flakem(j-1,k);
                            if cat_att>1
                                may_reac=1;
                            elseif (cat_att==1)&(~has_reac)
                                flaket(j,k-1)=0;                                
                                flaket(j,k)=2;
                                has_reac=1;
                            end;
                        end;
                        if flakem(j+1,k+1)==2
                            is_cat=1;
                            cat_att=flakem(j+2,k+2)+flakem(j+2,k+1)+flakem(j+2,k)+flakem(j+1,k+2)+flakem(j+1,k)+flakem(j,k+2)+flakem(j,k+1)+flakem(j,k);
                            if cat_att>1
                                may_reac=1;
                            elseif (cat_att==1)&(~has_reac)
                                flaket(j+1,k+1)=0;                                
                                flaket(j,k)=2;
                                has_reac=1;
                            end;
                        end;
                        if flakem(j-1,k-1)==2
                            is_cat=1;
                            cat_att=flakem(j,k)+flakem(j,k-1)+flakem(j,k-2)+flakem(j-1,k)+flakem(j-1,k-2)+flakem(j-2,k)+flakem(j-2,k-1)+flakem(j-2,k-2);
                            if cat_att>1
                                may_reac=1;
                            elseif (cat_att==1)&(~has_reac)
                                flaket(j-1,k-1)=0;                                
                                flaket(j,k)=2;
                                has_reac=1;
                            end;
                        end;
                        if flakem(j-1,k+1)==2
                            is_cat=1;
                            cat_att=flakem(j,k+2)+flakem(j,k+1)+flakem(j,k)+flakem(j-1,k+2)+flakem(j-1,k)+flakem(j-2,k+2)+flakem(j-2,k+1)+flakem(j-2,k);
                            if cat_att>1
                                may_reac=1;
                            elseif (cat_att==1)&(~has_reac)
                                flaket(j-1,k+1)=0;                                
                                flaket(j,k)=2;
                                has_reac=1;
                            end;
                        end;
                        if flakem(j+1,k-1)==2
                            is_cat=1;
                            cat_att=flakem(j+2,k)+flakem(j+2,k-1)+flakem(j+2,k-2)+flakem(j+1,k)+flakem(j+1,k-2)+flakem(j,k)+flakem(j,k-1)+flakem(j,k-2);
                            if cat_att>1
                                may_reac=1;
                            elseif (cat_att==1)&(~has_reac)
                                flaket(j+1,k-1)=0;                                
                                flaket(j,k)=2;
                                has_reac=1;
                            end;
                        end;
                        if may_reac==1
                            flaket(j,k)=0;
                        end;
                        if is_cat==0
                            flaket(j,k)=0;
                        end;
                    end;
				end;
            elseif flakem(j,k)==2
                catopen=false;
                if flakem(j+1,k)==0
                    catopen=true;
                end;
                if flakem(j-1,k)==0
                    catopen=true;
                end;
                if flakem(j,k+1)==0
                    catopen=true;
                end;
                if flakem(j,k-1)==0
                    catopen=true;
                end;
                if flakem(j+1,k+1)==0
                    catopen=true;
                end;
                if flakem(j-1,k-1)==0
                    catopen=true;
                end;
                if flakem(j-1,k+1)==0
                    catopen=true;
                end;
                if flakem(j+1,k-1)==0
                    catopen=true;
                end;
				if (rand<catreac)&(catopen)
                    counter=0;
                    dira(1:8)=0;
                    if flakem(j+1,k)==1
                        counter=counter+1;
                        dira(1)=1;
                    end;
                    if flakem(j-1,k)==1
                        counter=counter+1;
                        dira(2)=1;
                    end;
                    if flakem(j,k+1)==1
                        counter=counter+1;
                        dira(3)=1;
                    end;
                    if flakem(j,k-1)==1
                        counter=counter+1;
                        dira(4)=1;
                    end;
                    if flakem(j+1,k+1)==1
                        counter=counter+1;
                        dira(5)=1;
                    end;
                    if flakem(j-1,k-1)==1
                        counter=counter+1;
                        dira(6)=1;
                    end;
                    if flakem(j-1,k+1)==1
                        counter=counter+1;
                        dira(7)=1;
                    end;
                    if flakem(j+1,k-1)==1
                        counter=counter+1;
                        dira(8)=1;
                    end;
                    dirgo=ceil(rand*counter);
                    dirc=0;
                    for cc=1:8
                        if dira(cc)==1
                            dirc=dirc+1;
                            if dirc==dirgo
                                switch cc
                                    case 1
                                        flaket(j,k)=0;
                                        flaket(j+1,k)=2;
                                    case 2
                                        flaket(j,k)=0;
                                        flaket(j-1,k)=2;
                                    case 3
                                        flaket(j,k)=0;
                                        flaket(j,k+1)=2;
                                    case 4
                                        flaket(j,k)=0;
                                        flaket(j,k-1)=2;
                                    case 5
                                        flaket(j,k)=0;
                                        flaket(j+1,k+1)=2;
                                    case 6
                                        flaket(j,k)=0;
                                        flaket(j-1,k-1)=2;
                                    case 7
                                        flaket(j,k)=0;
                                        flaket(j-1,k+1)=2;
                                    case 8
                                        flaket(j,k)=0;
                                        flaket(j+1,k-1)=2;
                                end;
                            end;
                        end;
                    end;
                end;
    		end;
		end;
	end;

	str1=['flake' num2str(i) '.m'];
    fid1=fopen(str1,'w');
    fprintf(fid1,'%2.0f',flaket);
    fclose(fid1);

% 	if cat
% 		str2=['cat' num2str(i) '.m'];
%         fid2=fopen(str2,'w');
%         fprintf(fid2,'%2.0f',flakec);
%         fclose(fid2);
% 	end;
    
    subcat=2*size(find(flakem==2),1);
    conv(i+1)=sum(sum(flaket))-subcat;
    if conv(i+1)<=1
        break;
    end;
    close(h);
    h = waitbar((conv(1)-conv(i))/conv(1),'The earth will end in:');
%     check(i)=(conv(i)-conv(i+1))/total(i);

end;
close(h);
conv=conv';
total=total';
ASA=ASA';
one=one';
two=two';
three=three';
four=four';
problog=problog';