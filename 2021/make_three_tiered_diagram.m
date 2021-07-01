%% start %%

%% クリア
clc;
clear;

%% 定数
T = 5;
fs = 192e3;

%% 時間ベクトル
t = 0 : 1/fs : T - 1/fs;

%% チャープ信号の作成
f0 = 0;
t1 = T;
f1 = fs/2;
y = chirp(t,f0,t1,f1);

%% プロット
figure('position', [0, 0, 1400, 700]);
plot( t , y );
xlim([ t(1) t(end) ]);
ylabel( 'amplitude[Pa]' );
xlabel( 'time[sec]' );
ax = gca;
ax.FontSize = 20;

f = gcf;
exportgraphics(f,'./make_three_tiered_diagram/chirp.png','Resolution',500);

%% 三段の図を作成する
func_make_three_tiered_diagram(t,y,fs,0,'./make_three_tiered_diagram/chirp_three_tiered_diagram.png');

%% end %%

function func_make_three_tiered_diagram(t,y,fs,random,filename)
  % 三段にしてプロットを行う
  figure('position', [0, 0, 1500, 800]);

  sgtitle('Make Three Tiered Diagram');

  % チャープ信号のプロット
  s1 = subplot(3,1,1);
  plot( t , y );
  ylabel( 'amplitude[Pa]' );
  xlabel( 'time[sec]' );
  xlim([ t(1) t(end) ]);
  ax = gca;
  ax.FontSize = 17;


  if random == 1
    % 信号のパワースペクトル密度
    s2 = subplot(3,1,2);

    N = length(y);
    xdft = fft(y);
    xdft = xdft(1:N/2+1);
    psdx = (1/(fs*N)) * abs(xdft).^2;
    psdx(2:end-1) = 2*psdx(2:end-1);
    freq = 0:fs/length(y):fs/2;

    plot(freq/1e3,10*log10(psdx));
    xlabel('frequency[Hz]');
    ylabel('power/frequency[dB/Hz]');

    xlim([ freq(1)/1e3 freq(end)/1e3 ]);
    ax = gca;
    ax.FontSize = 17;

    % 信号のスペクトグラム
    Temporal_Sensitivity_Profile = 0.1;
    s3 = subplot(3,1,3);
    % pspectrum(y,fs,'spectrogram','TimeResolution',Temporal_Sensitivity_Profile);
    spectrogram(y,256,120,256,fs,'yaxis');
    ylim([ freq(1)/1e3 freq(end)/1e3 ]);
    ylabel( 'frequency[kHz]' );
    xlabel( 'time[sec]' );
    ax = gca;
    ax.FontSize = 17;
  else
    % 信号のパワースペクトル
    s2 = subplot(3,1,2);

    Y = fft( y );
    L = length( y );
    A = abs( Y/L );
    A = A(1:L/2+1);
    A(2:end-1) = 2*A(2:end-1);
    f = fs*(0:(L/2))/L;

    plot( f/1e3 , 10*log10(A) );
    ylabel( 'power[dB]' );
    xlabel( 'frequency[kHz]' );
    xlim([ f(1)/1e3 f(end)/1e3 ]);
    ax = gca;
    ax.FontSize = 17;

    % 信号のスペクトグラム
    Temporal_Sensitivity_Profile = 0.1;
    s3 = subplot(3,1,3);
    % pspectrum(y,fs,'spectrogram','TimeResolution',Temporal_Sensitivity_Profile);
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
