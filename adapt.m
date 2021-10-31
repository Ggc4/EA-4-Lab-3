%table=readtable("Lab3Inputs.xls");
%vars=table.(2);
global A
A=1;
global B
B=0;
global m
m=1;
global k
k=1;
global count
count = 0;
h=1;
hbig=1;
hsmall=1*10^(-12);
hcut=1.5;
hraise=1.05;
tinit=0;
tfin=30;
E = 0.01;
xinit=0;
yinit=0;
% initialize vectors 
X=[]; % vector of x values
Y=[]; % vector of y values
T=[]; % vector of t values
Tz =[]; % vector of tzero values
j=1; 
t=tinit;
x=A;
y=0;
tzero=1;
while t < tfin
    tnew = t + h;
    if tnew > tfin
        h = tfin - tnew;
        tnew = t + h;
    end
    [xk0,yk0]= prime(t,x,y); 
    count = count +1; % count # of calls to prime
    xlow = x+(h*xk0); % compute xlow
    ylow = y+(h*yk0); % compute ylow
    [xk1,yk1]= prime(tnew,xlow,ylow);
    count = count +1;% corrected slopes
    xhigh=x+(h/2)*(xk0+xk1); % compute xhigh
    yhigh=y+(h/2)*(yk0+yk1); % compute yhigh
    e_x = abs(xhigh - xlow);
    e_y = abs(yhigh - ylow);
    e = max([e_x,e_y]);
    if e < E
        if yhigh < 0 && y > 0
            tzero = (((-y)*(tnew-t))/(yhigh-y))+t;
            % compute tzero at y=0
        end
        h = h*hraise;
        if h > hbig
            h = hbig; % dont want h getting too big
        end
    else
        h = h/hcut;
        if h < hsmall
            h = hsmall; % dont want h getting too small
        end    
    end
    % append vectors with values
    X = [X;x];
    Y = [Y;y];
    T = [T;t];
    Tz = [Tz;tzero];
    j = j+1;
    % set new x, y and t values
    x=xhigh;
    y=yhigh;
    t=tnew;
end
J = 1:j;
s = length(Tz)-1;
P = [];
for i = 1:s
    p = Tz(i+1)-Tz(i);
    P=[P;p];
end

avgper = sum(P)/length(P);
nsteps=length(X)-1;
raccept=(2*nsteps)/count;  
