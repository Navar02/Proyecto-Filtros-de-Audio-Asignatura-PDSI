function y = ecual3B(gb, gm, ga, f1, f2, fs, x)
    % Diseñar los filtros
    [b_low, a_low] = butter(4, f1/(fs/2), 'low');   % Filtro paso bajo
    fiir1 = filter(b_low, a_low, x);

    [b_band, a_band] = butter(4, [f1/(fs/2), f2/(fs/2)], 'bandpass');  % Filtro paso banda
    fiir2 = filter(b_band, a_band, x);

    [b_high, a_high] = butter(4, f2/(fs/2), 'high'); % Filtro paso alto
    fiir3 = filter(b_high, a_high, x);
    
    % Aplicar la ganancia a las partes
    y_bajos = gb .* fiir1;
    y_pasoBanda = gm .* fiir2;
    y_altos = ga .* fiir3;
    
    % Unir las partes
    y = y_bajos + y_pasoBanda + y_altos;
end

