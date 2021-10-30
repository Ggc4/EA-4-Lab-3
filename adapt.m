function [X, Y, J] = adapt(A,B,m,k,h,hbig,hsmall,hcut,hraise,E,xinit,yinit,tfin,tinit)
%table=readtable("Lab3Inputs.xls");
%vars=table.(2);
global A;
global B;
global m;
global k;

global count
count = 0;
% initialize vectors 
X=[]; % vector of x values
Y=[]; % vector of y values
%T=[]; % vector of t values
%Tz =[]; % vector of tzero values
j=1; 
t=tinit;
x=xinit;
y=yinit;
while t < tfin
    tnew = t + h;
    if tnew > tfin
        h = tfin - tnew;
        tnew = t + h;
    end
    [xk0,yk0]= prime(t,x,y); % count # of calls to prime
    xlow=x+h*xk0; % compute xlow
    ylow=y+h*yk0; % compute ylow
    [xk1,yk1]= prime(tnew,xlow,ylow); % corrected slopes
    xhigh=x+(h/2)*(xk0+xk1); % compute xhigh
    yhigh=y+(h/2)*(yk0+yk1); % compute yhigh
    e_x = abs(xhigh - xlow);
    e_y = abs(yhigh - ylow);
    e = max(e_x,e_y);
    if e < E
        if yhigh < 0 && y > 0
            tzero = (((-y*(tnew-t))/(yhigh-y))+t);
            % compute tzero at y=0
        end
        h = h*hraise;
        if h > hbig
            h= hbig; % dont want h getting too big
        end
    else
        h = h/hcut;
        if h < hsmall
            h = hsmall; % dont want h getting too small
        end    
    end
    % calculate period 
    % append vectors with values
    X = [X;x];
    Y = [Y;y];
    %T = [T;t];
    %Tz = [Tz;tzero];
    j = j+1;
    % set new x, y and t values
    x=xhigh;
    y=yhigh;
    t=tnew;
end
    J = 1:j;
end
    % calculating period
    % for loop that takes each successive pairs of tzeros
    % and subtracts them to get a number
    
     
    % dat file for T, X
    % dat file for T, Y
    % dat file for X, Y
    
    % avgper = sum(P(:,2))/size(P,1);
    % nsteps=size(X,1);
    % raccept=(2*nsteps)/count;
    

    
% y-y1=((y2-y1)/(t2-t1))*(t-t1)
% solve for y = 0 and write it 

% look at saving two column vectors into one dat file
