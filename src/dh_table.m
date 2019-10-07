function table = dh_table(thetas)
    if ~all(size(thetas) == [1 5])
        error('Input for dh_table function must be a 1x5 column vector.\n\tInput vector size: %dx%d', size(thetas, 1), size(thetas, 2));
    end
    
    table(1) = struct('theta', thetas(1), 'd', 6.51,   'a', 0,       'alpha', 90);
    table(2) = struct('theta', thetas(2), 'd', 0,      'a', 11.811,  'alpha', 0);
    table(3) = struct('theta', thetas(3), 'd', 0,      'a', 12.4968, 'alpha', 0);
    table(4) = struct('theta', thetas(4), 'd', 0,      'a', 0,       'alpha', 90);
    table(5) = struct('theta', thetas(5), 'd', 8.5598, 'a', 0,       'alpha', 0);
end