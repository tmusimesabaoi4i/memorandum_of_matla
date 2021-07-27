
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

%% テューキー (コサインテーパー) ウィンドウをかける
y = y .* (tukeywin( length(y),(0.1/(T/2)) )).';

%% ノイズの付加
n1 = ( wgn( T * fs , 1 , 0 ) ).';
n1 = n1/max(n1)*0.5;
n2 = ( wgn( T * fs , 1 , 0 ) ).';
n2 = n2/max(n2)*0.5;
y = [ n1 y n2 ];

%% 時間ベクトルの更新
t = 0 : 1/fs : 3*T - 1/fs;

%% プロット
figure('position', [0, 0, 800*sqrt(2), 800]);
plot( t , y );
xlim([ t(1) t(end) ]);
ylabel( 'amplitude[Pa]' );
xlabel( 'time[sec]' );
ax = gca;
ax.FontSize = 20;

%% 三段の図を作成する
func_make_two_tiered_diagram_with_noise(t,y,fs,1,'./make_two_tiered_diagram/chirp_two_tiered_diagram.png');

%% end %%

% 信号のパワースペクトル密度
function [s,ave] = plot_psd(y,fs,cl)

  N = length( y );
  xdft = fft( y );
  xdft = xdft( 1:N/2+1 );
  psdx = (1/(fs*N)) * abs(xdft).^2;
  psdx(2:end-1) = 2*psdx(2:end-1);
  freq = fs*(0:(N/2))/N;

  ave = mean( 10*log10(psdx) );
  s = plot(freq/1e3,10*log10(psdx),'Color',cl);

  ylabel('power/frequency[dB/Hz]');
  xlabel('frequency[Hz]');

  xlim([ freq(1)/1e3 freq(end)/1e3 ]);
  ylim([-200 50]);

  ax = gca;
  ax.FontSize = 17;
end

% 信号のパワースペクトル
function [s,ave] = plot_ps(y,fs,cl)

  Y = fft( y );
  L = length( y );
  A = abs( Y/L );
  A = A( 1:L/2+1 );
  A = A.^2;
  A(2:end-1) = 2*A(2:end-1);
  f = fs*(0:(L/2))/L;

  ave = mean( 10*log10(A/(20e-6).^2) );
  s = plot(f/1e3,10*log10(A/(20e-6).^2),'Color',cl);

  ylabel( 'power[dB SPL]' );
  xlabel( 'frequency[kHz]' );

  xlim([ f(1)/1e3 f(end)/1e3 ]);
  ylim([-300 200]);
  ax = gca;

  ax.FontSize = 17;
end

function func_make_two_tiered_diagram_with_noise(t,y,fs,random,filename)
  figure('position', [0, 0, 800*sqrt(2), 800]);

  sgtitle('Make Two Tiered Diagram');

  t_s = 5;
  t_e = 10;

  % 信号のプロット
  subplot(2,1,1);

  plot( t , y );
  ylabel( 'amplitude[Pa]' );
  xlabel( 'time[sec]' );
  xlim([ t(1) t(end) ]);
  ax = gca;
  ax.FontSize = 17;

  if random == 1
    subplot(2,1,2);

    [s1,ave_sig] = plot_psd(y(t_s*fs:t_e*fs),fs,[0 0.4470 0.7410]);
    hold on
    [s2,ave_noi] = plot_psd(y(1:t_s*fs),fs,[0.8500 0.3250 0.0980]);
    legend([s1 s2] , { ['signal : ' num2str(round(ave_sig,2)) ' [dB/Hz]' ] , ['noise : ' num2str(round(ave_noi,2)) ' [dB/Hz]' ] })
    hold off
  else
    subplot(2,1,2);

    [s1,ave_sig] = plot_ps(y(t_s*fs:t_e*fs),fs,[0 0.4470 0.7410]);
    hold on
    [s2,ave_noi] = plot_ps(y(1:t_s*fs),fs,[0.8500 0.3250 0.0980]);
    legend([s1 s2] , { ['signal : ' num2str(round(ave_sig,2)) ' [dB SPL]' ] , ['noise : ' num2str(round(ave_noi,2)) ' [dB SPL]' ] })
    hold off
  end

  if filename ~= 0
    f = gcf;
    exportgraphics(f,filename,'Resolution',500);
  end

end
