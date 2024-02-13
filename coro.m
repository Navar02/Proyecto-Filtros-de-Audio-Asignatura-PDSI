function y = coro(ret, fret, aret, nvoces, x, fs)
    % ret: retardo medio de la 2ª voz en milisegundos
    % fret: frecuencia a la que varía el retardo de la 2ª voz en Hz
    % aret: amplitud de la variación del retardo de la 2ª voz en milisegundos
    % nvoces: número de voces
    % x: señal de entrada
    % fs: frecuencia de muestreo

    % Inicializar la señal de salida
    y = zeros(size(x));

    % Adaptar de ms a ciclos
    ret2 = ret/1000 * fs;
    aret2 = aret/1000 * fs;

    % Crear la segunda voz con retardo variable
    retardo_segunda_voz = ret2 + aret2 * sin(2 * pi * fret/fs * (1:length(x)));
    retardo_segunda_voz=sort(retardo_segunda_voz);
    for i = 1:length(x)
        indice_retardado = round(i - retardo_segunda_voz(i));
        indice_retardado = max(1, min(indice_retardado, length(x))); 
        y(i) = y(i) + x(indice_retardado);
    end
    
    % Crear voces adicionales
    for n = 2:nvoces
        % Calcular retardo para voces adicionales (variación en cada iteración)
        random = rand;
        retardo_adicional = retardo_segunda_voz + round(((15 + 10 * random) / 1000) * fs);
        retardo_adicional=sort(retardo_adicional);
        for i = 1:length(x)
            % Calcular retardo adicional para cada voz
            indice_retardado = round(i - retardo_adicional(i));
            indice_retardado = max(1, min(indice_retardado, length(x)));
            y(i) = y(i) + x(indice_retardado);
        end
    end
    y=y+x; %Añadir la señal original
end











