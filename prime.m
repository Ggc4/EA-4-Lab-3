function [xk,yk] = prime(t,x,y)
global k m B count
xk = y;
yk = (-k/m)*x+(-B/m)*(x^3);
count = count + 1;
end
