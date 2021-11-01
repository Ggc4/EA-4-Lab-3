% adapt.m 
table=readtable("Lab3Inputs.xls");
vars=table.(2);
global A
A=vars(1);
global B
B=vars(2);
global m
m=vars(3);
global k
k=vars(4);
global count
count = 0;
h=vars(5);hbig=vars(6);hsmall=vars(7);hcut=vars(8);hraise=vars(9);
E = vars(10);
xinit=A;yinit=vars(12);
tinit=vars(14);tfin=vars(13);

% initialize vectors 
X=[]; % vector of x values
Y=[]; % vector of y values
T=[]; % vector of t values
Tz =[]; % vector of tzero values
j=1; % counting loops
t=tinit;
x=xinit;
y=yinit;
tzero=1;
while t < tfin
    tnew = t + h;
    if tnew > tfin % checking if tnew is bigger than our final t
        h = tfin - t;
        tnew = t + h;
    end
    [xk0,yk0]= prime(t,x,y); 
    xlow = x+(h*xk0); % compute xlow
    ylow = y+(h*yk0); % compute ylow
    [xk1,yk1]= prime(tnew,xlow,ylow); % corrected slopes
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
    % append vectors with values
    X = [X xhigh];
    Y = [Y yhigh];
    T = [T tnew];
    Tz = [Tz tzero];
    j = j+1;
    % set new x, y and t values
    x=xhigh;
    y=yhigh;
    t=tnew;
    else
        h = h/hcut;
        if h < hsmall
            error('H is too small') % dont want h getting too small
        end 
    end
end
J = 1:j;
s = length(Tz)-1;
P = [];
for i = 1:s
    p = Tz(i+1)-Tz(i); % caclulating period by taking succ
    P=[P p];
end
Periods=P(P~=0);
avgper = mean(Periods);
nsteps=length(X)-1;
raccept=(2*nsteps)/count;    
% dat file for T, X
writematrix([T.' X.'],'x.dat');
% dat file for T, Y
writematrix([T.' Y.'],'y.dat');
% dat file for X, Y
writematrix([X.' Y.'],'xy.dat');
% dat file for j, jth period
J(end)=[]; J(end)=[]; % making vectors the same length
writematrix([J.' P.'],'per.dat');
avgper;
count;
nsteps;
raccept;
