function y = reverb1(ret, alfa, x, fs)
    % Convertir el retardo de milisegundos a número de muestras
    R = round(ret * fs / 1000);

    % Aplicar la función de transferencia H(z) = 1 / (1 - alfa*z^{-R})
    y = filter(1, [1, zeros(1, R-1), -alfa], x);
end


