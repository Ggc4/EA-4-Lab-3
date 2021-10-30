function [xk,yk] = prime(t,x,y)
global k
global m
global B
xk = (-B/k)*(x^3)-(m/k)*((-k/m)*y+(-B/m)*(x^3));
yk = (-k/m)*y+(-B/m)*(x^3);
end
