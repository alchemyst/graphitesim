function [conv,total,ASA,allcounts,problog]=flatflakec

rand('state', 0);

iter=300;%4000;
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

cat=true;
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
    for i = 1:8
        flakem(round(rand*msize),round(rand*nsize))=0;
    end
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

flakem = uint8(flakem);
flaket = flakem;

%writeframe('flake', 0, 'dat', flakem)

subcat=2*size(find(flakem==2),1);
conv(1)=sum(sum(flakem))-subcat;

% Stencils
opencross = [0 1 0; 
             1 0 1; 
             0 1 0];
circle = ones(3); circle(2, 2) = 0;


% if cat
% 	writeframe('cat', 0, 'dat', flakec)
% end;
% h = waitbar(0,'The earth will end in:');

total = zeros(iter, 1);
ASA = zeros(iter, 1);
problog = zeros(iter, 1);
allcounts = zeros(iter, 4);

for i=1:iter
    disp(['i=' num2str(i)]);
    if mod(i,catreacstep)==0
        normreac=normreacT;
    else
        normreac=0;
    end;
    %flakem = readframe('flake', i-1, 'dat', msize, nsize);
    flakem = flaket;

    counters = conv2(flakem==0, opencross, 'same') .* (flakem==1);
    counts = histc(counters(:), 1:4)

    total(i)=sum(counts);
    ASA(i)=sum(counts .* (1:4)');
    x=counts/total(i)
    reactivity=normreac;%/(xone+2*xtwo+3*xthree+4*xfour);%normreac/(xone+2*xtwo+3*xthree+4*xfour);
    problog(i)=reactivity;
    allcounts(i, :) = counts;

    % TODO: Check if this is required
    %flaket=flakem;
    
    disp('Start loop2')
    bigreactc = conv2(flakem==0, opencross, 'same');
    bigcat_att = conv2(flakem, circle, 'same');
    for j=3:msize-2
        for k=3:nsize-2
            neighbourhood = flakem(j-1:j+1, k-1:k+1);
            if flakem(j,k)==1
                if flaket(j,k)~=2
                    reactc = bigreactc(j, k);
                    react = min(1, 1-(1-reactivity)^reactc);

                    if (rand<react)&(rem(i,normreact)==0)
                        may_reac=0;
                        cat_att=0;
                        has_reac=0;
                        is_cat=0;

                        [cposi, cposj] = find(neighbourhood == 2);
                        for cati = 1:length(cposi)
                            is_cat = true;
                            cat_att = bigcat_att(j+cposi(cati)-1, k+cposj(cati)-1);
                            if cat_att > 1
                                may_reac = true;
                            elseif (cat_att==1) & ~has_reac
                                flaket(j+cposi(cati)-1, k+cposj(cati)-1) = 0;
                                flaket(j, k) = 2;
                                has_reac = true;
                            end
                        end    

                        if may_reac | ~is_cat
                            flaket(j,k)=0;
                        end;
                    end;
                end;
            elseif flakem(j,k)==2
                catopen = any(neighbourhood(:) == 0);

                if (rand<catreac)&(catopen)
                    [possi, possj] = find(neighbourhood == 1);
                    if length(possi) > 0
                        choice = floor(rand*length(possi)) + 1;
                        flaket(j, k) = 0;
                        flaket(j+possi(choice)-1, k+possj(choice)-1) = 2;
                    end
                end;
            end;
        end;
    end;
    disp('End loop2')
    writeframe('flake', i, 'dat', flaket)

    % 	if cat
    % 	  writeframe('cat', i, 'dat', flakec)
    % 	end;
    
    subcat=2*size(find(flakem==2),1);
    conv(i+1)=sum(sum(flaket))-subcat;
    if conv(i+1)<=1
        break;
    end;
    disp (conv(1)-conv(i))/conv(1)
    %     check(i)=(conv(i)-conv(i+1))/total(i);
end;

