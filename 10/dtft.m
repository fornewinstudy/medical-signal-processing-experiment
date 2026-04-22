function [XK,w] = dtft(xn,n,N)
%
w = 0:2*pi/N:2*pi-2*pi/N;
XK = xn*(exp(-j).^(n'*w));
end

