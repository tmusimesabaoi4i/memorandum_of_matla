% 信号のパワースペクトル密度[Pa^2/Hz]
% https://www.onosokki.co.jp/HP-WK/eMM_back/emm148.pdf
function [f,gx] = fpsd(x,fs)
  N = length(x);
  xdft = fft(x .* (tukeywin( length(x),0.01 )) );
  ck_temp = abs(xdft/N);
  ck = ck_temp(1:N/2+1);
  ck2 = ck.^2;
  psx = ck2;
  psx(2:end-1) = 2*psx(2:end-1);
  f = fs*(0:(N/2))/N;
  gx = psx ./ (f(2)-f(1));
end
% function [freq,psdx] = psd(x,fs)
%     N = length(x);
%     xdft = fft(x .* (tukeywin( length(x),0.01 )) );
%     xdft = xdft(1:N/2+1);
%     psdx = (1/(fs*N)) * abs(xdft).^2;
%     psdx(2:end-1) = 2*psdx(2:end-1);
%     freq = 0:fs/length(x):fs/2;
% end
