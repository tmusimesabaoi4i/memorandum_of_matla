
%% start %%

%% クリア
clc;
clear;

%% 定数
T = 5;
fs = 192e3;

%% 時間ベクトル
t = 0 : 1/fs : T - 1/fs;

%% チャープ信号 の作成
f0 = 0;
t1 = T;
f1 = fs/2;
y = chirp(t,f0,t1,f1) * sqrt(2);

%% プロット
figure('position', [0, 0, 800*sqrt(2), 800]);
plot( t , y );
xlim([ t(1) t(end) ]);
ylabel( 'amplitude[Pa]' );
xlabel( 'time[sec]' );
ax = gca;
ax.FontSize = 17;

%% 三段の図を作成する
func_make_three_tiered_diagram(t,y,fs,1,'./make_three_tiered_diagram/chirp_three_tiered_diagram.png');

%% pure tone の作成
f1 = 10e3;
y = sqrt(2) * sin( 2 * pi * f1 * t );

%% プロット
figure('position', [0, 0, 800*sqrt(2), 800]);
plot( t , y );
xlim([ t(1) t(end) ]);
ylabel( 'amplitude[Pa]' );
xlabel( 'time[sec]' );
ax = gca;
ax.FontSize = 17;

%% 三段の図を作成する
func_make_three_tiered_diagram(t,y,fs,0,'./make_three_tiered_diagram/pure_tone_three_tiered_diagram.png');

%% end %%

% 信号のパワースペクトル密度
function [freq,l,ave] = plot_psd(y,fs,cl)

  N = length( y );
  xdft = fft( y );
  xdft = xdft( 1:N/2+1 );
  psdx = (1/(fs*N)) * abs(xdft).^2;
  psdx(2:end-1) = 2*psdx(2:end-1);
  freq = fs*(0:(N/2))/N;

  ave = mean( 10*log10(psdx) );
  l = plot(freq/1e3,10*log10(psdx),'Color',cl);

  ylabel('power/frequency[dB/Hz]');
  xlabel('frequency[Hz]');

  xlim([ freq(1)/1e3 freq(end)/1e3 ]);

  ax = gca;
  ax.FontSize = 17;
end

% 信号のパワースペクトル
function [f,l,ave] = plot_ps(y,fs,cl)

  Y = fft( y );
  L = length( y );
  A = abs( Y/L );
  A = A( 1:L/2+1 );
  A = A.^2;
  A(2:end-1) = 2*A(2:end-1);
  f = fs*(0:(L/2))/L;

  ave = mean( 10*log10(A/(20e-6).^2) );
  l = plot(f/1e3,10*log10(A/(20e-6).^2),'Color',cl);

  ylabel( 'power[dB SPL]' );
  xlabel( 'frequency[kHz]' );

  xlim([ f(1)/1e3 f(end)/1e3 ]);
  ylim([-300 200]);
  ax = gca;

  ax.FontSize = 17;
end

function func_make_three_tiered_diagram(t,y,fs,random,filename)
  figure('position', [0, 0, 800*sqrt(2), 800]);

  sgtitle('Make Three Tiered Diagram');

  % 信号のプロット
  s1 = subplot(3,1,1);

  plot( t , y );
  ylabel( 'amplitude[Pa]' );
  xlabel( 'time[sec]' );
  xlim([ t(1) t(end) ]);
  ax = gca;
  ax.FontSize = 17;

  if random == 1

    s2 = subplot(3,1,2);

    [f,l,ave_sig] = plot_psd(y,fs,[0 0.4470 0.7410]);

    % 信号のスペクトグラム
    s3 = subplot(3,1,3);

    Temporal_Sensitivity_Profile = 0.1;
    spectrogram(y,256,120,256,fs,'yaxis');
    ylim([ f(1)/1e3 f(end)/1e3 ]);
    ylabel( 'frequency[kHz]' );
    xlabel( 'time[sec]' );
    ax = gca;
    ax.FontSize = 17;

  else

    s2 = subplot(3,1,2);

    [f,l,ave_sig] = plot_ps(y,fs,[0 0.4470 0.7410]);

    % 信号のスペクトグラム
    s3 = subplot(3,1,3);

    Temporal_Sensitivity_Profile = 0.1;
    spectrogram(y,256,120,256,fs,'yaxis');
    ylim([ f(1)/1e3 f(end)/1e3 ]);
    ylabel( 'frequency[kHz]' );
    xlabel( 'time[sec]' );
    ax = gca;
    ax.FontSize = 17;

  end

  s1Pos = get(s1,'position');
  s2Pos = get(s2,'position');
  s3Pos = get(s3,'position');
  s2Pos(3:4) = [s1Pos(3:4)];
  s3Pos(3:4) = [s1Pos(3:4)];
  set(s2,'position',s2Pos);
  set(s3,'position',s3Pos);

  if filename ~= 0
    f = gcf;
    exportgraphics(f,filename,'Resolution',500);
  end

end
