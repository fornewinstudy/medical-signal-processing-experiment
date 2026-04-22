function hd = ideal_lp(wc,N)
%hd(n) n =0:N-1
%wc cutoff frequency
alpha = (N-1)/2;
n = 0:N-1;
m = n-alpha;
fc = wc/pi;
hd = fc*sinc(fc*m);

end

