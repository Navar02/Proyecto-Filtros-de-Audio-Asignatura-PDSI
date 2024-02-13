% Parámetros para las funciones de filtro
[x,fs]=audioread("E101.WAV");

% Parámetros para las funciones de filtro ecual3B
gb = 2;  % Ganancia para bajos
gm = 0.5;  % Ganancia para banda media
ga = 0.7;  % Ganancia para altos
f1 = 200;  % Frecuencia de corte baja en Hz
f2 = 600;  % Frecuencia de corte alta en Hz

% Aplicar el filtro ecual3B
output_ecual3B = ecual3B(gb, gm, ga, f1, f2, fs, x);

%representar efectos de los filtros
[b_low, a_low] = butter(4, f1/(fs/2), 'low');   % Filtro paso bajo
[b_band, a_band] = butter(4, [f1/(fs/2), f2/(fs/2)], 'bandpass');  % Filtro paso banda
[b_high, a_high] = butter(4, f2/(fs/2), 'high'); % Filtro paso alto
figure, freqz(b_low,a_low),title("efecto del filtro sobre frecuencias bajas");
figure, freqz(b_band,a_band),title("efecto del filtro sobre frecuencias medias");
figure, freqz(b_high,a_high),title("efecto del filtro sobre frecuencias altas");
% Parámetros para las funciones de filtro eco
ret_eco = 500;  % Retardo en milisegundos
alfa_eco = 0.5;  % Factor de amortiguación

% Aplicar el filtro eco
output_eco = eco(ret_eco, alfa_eco, x, fs);

%representar efecto del filtro
R = round(ret_eco * fs / 1000);
figure, freqz([1, zeros(1, R-1), alfa_eco],1),title("efecto del filtro de eco");

% Parámetros para las funciones de filtro reverb1 y reverb2
ret_reverb = 100;  % Retardo en milisegundos
alfa_reverb = 0.7;  % Factor de amortiguación

% Aplicar los filtros reverb1 y reverb2
output_reverb1 = reverb1(ret_reverb, alfa_reverb, x, fs);

%representar efecto del filtro
R = round(ret_reverb * fs / 1000);
figure,freqz(1, [1, zeros(1, R-1), -alfa_reverb]),title("efecto del filtro de reverb simple");

output_reverb2 = reverb2(ret_reverb, alfa_reverb, x, fs);

%representar efecto del filtro
R = round(ret_reverb * fs / 1000);
b = [-alfa_reverb, zeros(1, R-1), 1];
a = [1, zeros(1, R-1), -alfa_reverb];
figure,freqz(b,a),title("efecto del filtro de reverb con filtro pasa-todo");

% Parámetros para la función de filtro coro
ret_coro = 20;  % Retardo medio de la 2ª voz en milisegundos
fret_coro = 1;  % Frecuencia a la que varía el retardo de la 2ª voz en Hz
aret_coro = 5;  % Amplitud de la variación del retardo de la 2ª voz en milisegundos
nvoces_coro = 3;  % Número de voces

% Aplicar el filtro coro
output_coro = coro(ret_coro, fret_coro, aret_coro, nvoces_coro, x, fs);

% Graficar las señales de entrada y salida de cada filtro
t=(0:length(x)-1) / fs;
figure;

subplot(3, 2, 1);
plot(t, x);
title('Señal de entrada');xlabel('Tiempo (s)');

subplot(3, 2, 2);
plot(t, output_ecual3B);
title('Salida de ecual3B');xlabel('Tiempo (s)');

subplot(3, 2, 3);
plot(t, output_eco);
title('Salida de eco');xlabel('Tiempo (s)');

subplot(3, 2, 4);
plot(t, output_reverb1);
title('Salida de reverb1');xlabel('Tiempo (s)');

subplot(3, 2, 5);
plot(t, output_reverb2);
title('Salida de reverb2');xlabel('Tiempo (s)');

subplot(3, 2, 6);
plot(t, output_coro);
title('Salida de coro');xlabel('Tiempo (s)');

% Ajustar el diseño de la figura
sgtitle('Pruebas de Filtros de Audio');

%escuhar resultado y original
duracion_audio = (length(x) / fs)+5;

soundsc(x,fs);
pause(duracion_audio);

soundsc(output_ecual3B,fs);
pause(duracion_audio);

soundsc(output_eco,fs);
pause(duracion_audio);

soundsc(output_reverb1,fs);
pause(duracion_audio);

soundsc(output_reverb2,fs);
pause(duracion_audio);

soundsc(output_coro,fs);
pause(duracion_audio);

