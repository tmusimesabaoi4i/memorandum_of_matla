%% start

%% clear
clc;
clear;

%% constant
fs = 60e3;
freq = 10e3;

for T = [ 1 2 3 4 5 ]

  datal = fs * T;
  df =  1 / T;

  %% signal
  t = 0 : 1/fs : T - 1/fs;
  y = transpose( sqrt(2) .* sin(2 * pi * freq * t) );
  % y = wgn(length(t),1,-10);

  %% plot
  figure('position', [0, 0, 500*sqrt(2), 500]);

  strtitle = sprintf('Fourier Transform change ( T = %d [sec] )', T );

  subplot(2,1,1);
  plot(t,y);
  ylabel( 'amplitude[Pa]' );
  xlabel( 'time[sec]' );
  xlim([ t(1) t(end) ]);
  ylim([-3 3]);
  ax = gca;
  ax.FontSize = 17;

  subplot(2,1,2);
  r = 'ps';

  if isequal( r,'ps' )
    [f,p] = fps(y,fs);
    pltdb(f,p,'ps',[0 0.4470 0.7410]);
  elseif isequal( r,'psd' )
    [f,p] = fpsd(y,fs);
    pltdb(f,p,'psd',[0 0.4470 0.7410]);
  end

  sgtitle( strtitle , 'FontSize' , 17 );

  str_df = [ 'df ='  num2str(df) '[Hz]' ];
  str_fs = [ 'fs ='  num2str(fs/1e3) '[kHz]' ];
  str_datal = [ 'datal ='  num2str(datal) '[points]' ];
  str_T = [ 'T ='  num2str(T) '[sec]' ];
  str_ini = [ str_df ' , ' str_fs ' , ' str_datal ' , ' str_T ];

  if isequal( r,'ps' )
    fprintf( [ str_ini ' , ' 'signal = ' num2str(round(max(10*log10(p/(20e-6^2))),2)) '[dB spl] ' ' , ' 'noise mean = ' num2str(round(10*log10(mean(p)/20e-6),2)) '[dB spl] ' ' , ' 'RMS = ' num2str(rms(y).^2) ' , ' 'sum = ' num2str(sum(p)) '\n' ] );
  elseif isequal( r,'psd' )
    fprintf( [ str_ini ' , ' 'signal = ' num2str(round(max(10*log10(p)),2)) '[dB/Hz] ' ' , ' 'noise mean = ' num2str(round(10*log10(mean(p)),2)) '[dB/Hz] ' ' , ' 'RMS = ' num2str(rms(y).^2) ' , ' 'sum = ' num2str(sum(df*p)) '\n' ] );
  end

end

close all;
%% end
