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
figure('position', [0, 0, 700, 700]);
plot( t , y );
xlim([ t(1) t(end) ]);
ylabel( 'amplitude[Pa]' );
xlabel( 'time[sec]' );
ax = gca;
ax.FontSize = 20;

f = gcf;
exportgraphics(f,'./Make_Three_Tiered_Diagram/chirp.png','Resolution',500);

%% 三段にしてプロットを行う
figure('position', [0, 0, 1200, 700]);

sgtitle('Make Three Tiered Diagram');

s1 = subplot(3,1,1);
plot( t , y );
ylabel( 'amplitude[Pa]' );
xlabel( 'time[sec]' );
xlim([ t(1) t(end) ]);
ax = gca;
ax.FontSize = 17;

s2 = subplot(3,1,2);

Y = fft( y );
L = length( y );
A = abs( Y/L );
A = A(1:L/2+1);
A(2:end-1) = 2*A(2:end-1);
f = fs*(0:(L/2))/L;

plot( f/1e3 , A );
ylabel( 'amplitude[Pa]' );
xlabel( 'frequency[kHz]' );
xlim([ f(1)/1e3 f(end)/1e3 ]);
ax = gca;
ax.FontSize = 17;

%% 白色ガウス雑音のスペクトグラム
Temporal_Sensitivity_Profile = 0.1;
s3 = subplot(3,1,3);
% pspectrum(y,fs,'spectrogram','TimeResolution',Temporal_Sensitivity_Profile);
spectrogram(y,256,120,256,fs,'yaxis');
ylim([ f(1)/1e3 f(end)/1e3 ]);
ylabel( 'frequency[kHz]' );
xlabel( 'time[sec]' );
ax = gca;
ax.FontSize = 17;

f = gcf;
exportgraphics(f,'./Make_Three_Tiered_Diagram/chirp_Three_Tiered_Diagram.png','Resolution',500);

s1Pos = get(s1,'position');
s2Pos = get(s2,'position');
s3Pos = get(s3,'position');
s2Pos(3:4) = [s1Pos(3:4)];
s3Pos(3:4) = [s1Pos(3:4)];
set(s2,'position',s2Pos);
set(s3,'position',s3Pos);
