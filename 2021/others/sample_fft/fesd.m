% 信号のパワースペクトル密度[Pa^2/Hz]
% https://www.onosokki.co.jp/HP-WK/eMM_back/emm148.pdf
function [f,e] = fesd(x,fs)
  N = length(x);
  xdft = fft(x .* (tukeywin( length(x),0.01 )) );
  ck_temp = abs(xdft/N);
  ck = ck_temp(1:N/2+1);
  ck2 = ck.^2;
  psx = ck2;
  psx(2:end-1) = 2*psx(2:end-1);
  f = fs*(0:(N/2))/N;
  df = f(end)/(length(f)-1);
  gx = psx / df;
  T = length(x)/fs;
  e = T * gx;
end
