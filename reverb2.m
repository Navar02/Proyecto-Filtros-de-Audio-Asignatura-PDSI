function y = reverb2(ret, alfa, x, fs)
    % ret retardo en milisegundos (debe convertirse en número de muestras R)
    % alfa factor de amortiguación
    % x vector que contiene la señal de entrada
    % fs frecuencia de muestreo
    % y vector que contiene la señal de salida
    % Convertir el retardo de milisegundos a número de muestras
    R = round(ret * fs / 1000);
    
    % Inicializar los coeficientes del filtro
    b = [-alfa, zeros(1, R-1), 1];
    a = [1, zeros(1, R-1), -alfa];
    
    % Aplicar el filtro
    y = filter(b, a, x);
end





