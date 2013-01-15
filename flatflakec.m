function [conv,total,ASA,allcounts,problog]=flatflakec

rand('state', 0);
filestem = 'results/flake';

iter=2000;%4000;
msize=504;%1004; THIS IS Y
nsize=504;%1004; THIS IS X

makerandhole=false;%true;
makerand=false;%true;

numblocks=1500; %1200
blocksize=45; %30
makecirc=false;%true;
radius=250;
maketriangle=false;%true;
makerevtriangle=false;%true;
makecross=false;%true;
makecirchole=false;%true;
% radius=20;

cat=false;
catreacstep=1;
catdist=10000;
normreacT=0.1;
normreact=1;   %for entire edge react sim
% numcat=50;
catreac=1;%;normreac*10;
% catreac=0.208;%0.4731;%1;%;normreac*10;
% normreac=1;
% normreact=10;

flakem=zeros(msize,nsize);
flakem(3:end-2, 3:end-2) = 1;
flakem(50,50:450)=0;
flakem(450,50:450)=0;
flakem(100:400,250)=0;

if makecross
	flakem(200:800,499:501)=0;
	flakem(499:501,200:800)=0;
end;

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
end;

if makecirc
    for x=-msize/2:msize/2
        for y=-nsize/2:nsize/2
            if (x^2+y^2)>radius^2
                if (x+msize/2~=0) && (y+nsize/2~=0)
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
    for i = 1:8
        flakem(round(rand*msize),round(rand*nsize))=0;
    end
end;

if maketriangle
    for x=-msize/2:msize/2
        for y=-nsize/2:nsize/2
            if x>(2*y+500)
                if (x+msize/2~=0) && (y+nsize/2~=0)
                    flakem(x+msize/2,y+nsize/2)=0;
                end;
            elseif x>(-2*y+500)
                 if (x+msize/2~=0) && (y+nsize/2~=0)
                    flakem(x+msize/2,y+nsize/2)=0;
                end;
%             if x>(y+250) && x>(-y+250)
%                 if (x+msize/2~=0)&&(y+nsize/2~=0)
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
            if ((x>(y-1900)/(-2))&&(y>(-2*x+1900)))
                if ((x<(y+100)/(2))&&(y>(2*x-100)))
                    flakem(y,x)=0;
                end;
            end;
        end;
    end;
    flakem(msize,:)=0;
    flakem(msize-1,:)=0;
end;

if cat
    for i=1:catdist
        cat_xcoord=round(rand*(msize-5)+3);
        cat_ycoord=round(rand*(nsize-5)+3);
        if flakem(cat_xcoord,cat_ycoord)==1
            flakem(cat_xcoord,cat_ycoord)=2;
        end;
    end;
end;

flakem = uint8(flakem);
flaket = flakem;

writeframe(filestem, 0, 'dat', flakem)

subcat=2*size(find(flakem==2),1);
conv(1)=sum(sum(flakem))-subcat;

% Stencils
opencross = [0 1 0; 
             1 0 1; 
             0 1 0];
circle = ones(3); circle(2, 2) = 0;

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
    %flakem = readframe(filestem, i-1, 'dat', msize, nsize);
    flakem = flaket;
    
    opensum = conv2(flakem==0, opencross, 'same');
    counters = opensum .* (flakem==1);
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
    bigcat_att = conv2(flakem, circle, 'same');
    for j=3:msize-2
        for k=3:nsize-2
            neighbourhood = flakem(j-1:j+1, k-1:k+1);
            if flakem(j,k)==1
                % We have a graphite particle
                if flaket(j,k)~=2
                    reactc = opensum(j, k);
                    react = min(1, 1-(1-reactivity)^reactc);

                    if (rand<react) && (rem(i,normreact)==0)

                        may_reac = false;
                        is_cat = false;
                        % NOTE: We don't need to mask the center out here, as we know it is not 2
                        [cposi, cposj] = find(neighbourhood == 2);
                        for cati = 1:length(cposi)
                            [joffset, koffset] = calcoffset(cposj, cposj, cati);
                            is_cat = true;
                            cat_att = bigcat_att(j+joffset, k+koffset);
                            if cat_att > 1
                                may_reac = true;
                            elseif cat_att==1
                                flaket(j+joffset, k+koffset) = 0;
                                flaket(j, k) = 2;
                                break
                            end
                        end    

                        if may_reac || ~is_cat
                            flaket(j,k)=0;
                        end;
                    end;
                end;
            elseif flakem(j,k)==2 % We have a catalyst particle
                % Is it open?
                catopen = any(neighbourhood(:) == 0);

                if catopen && (rand<catreac)
                    % Move to a random location where there is carbon
                    [possi, possj] = find(neighbourhood == 1);
                    if length(possi) > 0
                        choice = floor(rand*length(possi)) + 1;
                        [joffset, koffset] = calcoffset(possi, possj, choice);
                        flaket(j, k) = 0;
                        flaket(j+joffset, k+koffset) = 2;
                    end
                end;
            end;
        end;
    end;
    disp('End loop2')
    
    writeframe(filestem, i, 'dat', flaket);
    
    subcat=2*sum(sum(flakem==2)); %2*size(find(flakem==2),1);
    conv(i+1)=sum(sum(flaket))-subcat;
    if conv(i+1)<=1
        break;
    end;
    disp (conv(1)-conv(i))/conv(1)
    %     check(i)=(conv(i)-conv(i+1))/total(i);
end;

