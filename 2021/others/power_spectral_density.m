%% 一つ目の白色ガウスノイズの定数定義
fs_1 = 192e3;
T_1 = 1;
N_1 = fs_1 * T_1;

%% 二つ目の白色ガウスノイズの定数定義
fs_2 = 192e3 / 2;
T_2 = 1;
N_2 = fs_2 * T_2;

%% ガウスノイズの作成 パワーが約 1 ワット (0 dBW)
y1_wgn = wgn( N_1 , 1 , 0 );
y2_wgn = wgn( N_2 , 1 , 0 );

%% 時間ベクトルの生成
t_1 = 0 : 1/fs_1 : T_1 - 1/fs_1;
t_2 = 0 : 1/fs_2 : T_2 - 1/fs_2;

%% プロットを行う
figure('position', [0, 0, 1400, 700]);
plot( t_1 , y1_wgn );

title_y1 = sprintf( 'Sampling Frequency = %.0f[kHz] , Total Time = %.0f[sec] , Data Points = %.0f' ,fs_1/1e3 ,T_1 ,N_1 );
title(title_y1);
xlabel('Time[sec]');
ax = gca;
ax.FontSize = 20;
ylabel('Amplitude[V]');
xlim([ t_1(1) t_1(end) ]);

figure('position', [0, 0, 1400, 700]);
plot( t_2 , y2_wgn );
title_y2 = sprintf( 'Sampling Frequency = %.0f[kHz] , Total Time = %.0f[sec] , Data Points = %.0f' ,fs_2/1e3 ,T_2 ,N_2);
title(title_y2);
xlabel('Time[sec]');
ylabel('Amplitude[V]');
ax = gca;
ax.FontSize = 20;
xlim([ t_2(1) t_2(end) ]);

%% フーリエ変換

Y_1 = fft( y1_wgn );
L_1 = length( y1_wgn );
Spectrum_y1_2 = abs(Y_1/L_1);
Spectrum_y1_1 = Spectrum_y1_2(1:L_1/2+1);
Spectrum_y1_1(2:end-1) = 2*Spectrum_y1_1(2:end-1);
f1 = fs_1*(0:(L_1/2))/L_1;

Y_2 = fft( y2_wgn );
L_2 = length( y2_wgn );
Spectrum_y2_2 = abs(Y_2/L_2);
Spectrum_y2_1 = Spectrum_y2_2(1:L_2/2+1);
Spectrum_y2_1(2:end-1) = 2*Spectrum_y2_1(2:end-1);
f2 = fs_2*(0:(L_2/2))/L_2;

figure('position', [0, 0, 1400, 700]);
plot(f1/1e3,Spectrum_y1_1);
title_y1 = sprintf( 'Sampling Frequency = %.0f[kHz] , Total Time = %.0f[sec] , Data Points = %.0f' ,fs_1/1e3 ,T_1 ,N_1 );
title(title_y1);
xlabel('Frequency[kHz]');
ylabel('Amplitude[V] ???');
ax = gca;
ax.FontSize = 20;
xlim([ f1(1)/1e3 f1(end)/1e3 ]);

figure('position', [0, 0, 1400, 700]);
plot(f2/1e3,Spectrum_y2_1);
title_y2 = sprintf( 'Sampling Frequency = %.0f[kHz] , Total Time = %.0f[sec] , Data Points = %.0f' ,fs_2/1e3 ,T_2 ,N_2);
title(title_y2);
xlabel('Frequency[kHz]');
ylabel('Amplitude[V] ???');
ax = gca;
ax.FontSize = 20;
xlim([ f2(1)/1e3 f2(end)/1e3 ]);

%% パワースペクトル密度 FFT関数を利用する場合

xdft_1 = fft(y1_wgn);
xdft_1 = xdft_1(1:N_1/2+1);
psdx_1 = (1/(length(y1_wgn)*fs_1)) * abs(xdft_1).^2;
psdx_1(2:end-1) = 2*psdx_1(2:end-1);
freq_1 = 0:fs_1/length(y1_wgn):fs_1/2;

figure('position', [0, 0, 1400, 700]);
plot(freq_1/1e3,10*log10(psdx_1))
xlim([ freq_1(1)/1e3 freq_1(end)/1e3 ]);
title('Periodogram Using FFT')
xlabel('Frequency (kHz)')
ylabel('Power/Frequency (dB/Hz)')
ax = gca;
ax.FontSize = 20;

f = gcf;
exportgraphics(f,'./power_spectral_density/power_spectral_density_y1_wgn.png','Resolution',500);

xdft_2 = fft(y2_wgn);
xdft_2 = xdft_2(1:N_2/2+1);
psdx_2 = (1/(length(y2_wgn)*fs_2)) * abs(xdft_2).^2;
psdx_2(2:end-1) = 2*psdx_2(2:end-1);
freq_2 = 0:fs_2/length(y2_wgn):fs_2/2;

figure('position', [0, 0, 1400, 700]);
plot(freq_2/1e3,10*log10(psdx_2))
xlim([ freq_2(1)/1e3 freq_2(end)/1e3 ]);
title('Periodogram Using FFT')
xlabel('Frequency (kHz)')
ylabel('Power/Frequency (dB/Hz)')
ax = gca;
ax.FontSize = 20;

%% パワースペクトル密度 periodogram関数を利用する場合
figure('position', [0, 0, 1400, 700]);
periodogram(y1_wgn,rectwin(length(y1_wgn)),length(y1_wgn),fs_1);
ax = gca;
ax.FontSize = 20;

figure('position', [0, 0, 1400, 700]);
periodogram(y2_wgn,rectwin(length(y2_wgn)),length(y2_wgn),fs_2);
ax = gca;
ax.FontSize = 20;


%% 確認
fprintf('var = %f , power = %f[W] \n',var(y1_wgn) ,sum( psdx_1 ) );
fprintf('var = %f , power = %f[W] \n',var(y2_wgn) ,sum( psdx_2 ) );

%% 一つ目の白色ガウスノイズの定数定義
fs_1 = 192e3;
T_1 = 1;
N_1 = fs_1 * T_1;

%% 二つ目の白色ガウスノイズの定数定義
fs_2 = 192e3 / 2;
T_2 = 1;
N_2 = fs_2 * T_2;


%% ガウスノイズの作成 パワーが約 100ワット (20 dBW)
y1_wgn = wgn( N_1 , 1 , 20 );
y2_wgn = wgn( N_2 , 1 , 20 );

%% 時間ベクトルの生成
t_1 = 0 : 1/fs_1 : T_1 - 1/fs_1;
t_2 = 0 : 1/fs_2 : T_2 - 1/fs_2;

%% パワースペクトル密度 FFT関数を利用する場合
xdft_1 = fft(y1_wgn);
xdft_1 = xdft_1(1:N_1/2+1);
psdx_1 = (1/(length(y1_wgn)*fs_1)) * abs(xdft_1).^2;
psdx_1(2:end-1) = 2*psdx_1(2:end-1);
freq_1 = 0:fs_1/length(y1_wgn):fs_1/2;

figure('position', [0, 0, 1400, 700]);
plot(freq_1/1e3,10*log10(psdx_1))
xlim([ freq_1(1)/1e3 freq_1(end)/1e3 ]);
title('Periodogram Using FFT')
xlabel('Frequency (kHz)')
ylabel('Power/Frequency (dB/Hz)')
ax = gca;
ax.FontSize = 20;

xdft_2 = fft(y2_wgn);
xdft_2 = xdft_2(1:N_2/2+1);
psdx_2 = (1/(length(y2_wgn)*fs_2)) * abs(xdft_2).^2;
psdx_2(2:end-1) = 2*psdx_2(2:end-1);
freq_2 = 0:fs_2/length(y2_wgn):fs_2/2;

figure('position', [0, 0, 1400, 700]);
plot(freq_2/1e3,10*log10(psdx_2))
xlim([ freq_2(1)/1e3 freq_2(end)/1e3 ]);
title('Periodogram Using FFT')
xlabel('Frequency (kHz)')
ylabel('Power/Frequency (dB/Hz)')
ax = gca;
ax.FontSize = 20;

%% パワースペクトル密度 periodogram関数を利用する場合
figure('position', [0, 0, 1400, 700]);
periodogram(y1_wgn,rectwin(length(y1_wgn)),length(y1_wgn),fs_1);
ax = gca;
ax.FontSize = 20;

figure('position', [0, 0, 1400, 700]);
periodogram(y2_wgn,rectwin(length(y2_wgn)),length(y2_wgn),fs_2);
ax = gca;
ax.FontSize = 20;

%% 確認
fprintf('var = %f , power = %f[W] \n',var(y1_wgn) ,sum( psdx_1 ) );
fprintf('var = %f , power = %f[W] \n',var(y2_wgn) ,sum( psdx_2 ) );
