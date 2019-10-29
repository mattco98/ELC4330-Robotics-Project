function table = dh_table(thetas, grip)
    if ~all(size(thetas) == [1 5])
        error('Input for dh_table function must be a 1x5 column vector.\n\tInput vector size: %dx%d', size(thetas, 1), size(thetas, 2));
    end
    
    % Theta values are the unknowns
    table(1) = struct('theta', thetas(1), 'd', 8.415,  'a', 0,         'alpha', pi / 2);
    table(2) = struct('theta', thetas(2), 'd', 0,      'a', 11.811,    'alpha', 0);
    table(3) = struct('theta', thetas(3), 'd', 0,      'a', 12.4968,   'alpha', 0);
    table(4) = struct('theta', thetas(4), 'd', 0,      'a', 0,         'alpha', pi / 2);
    table(5) = struct('theta', thetas(5), 'd', 8.3388, 'a', 0,         'alpha', 0);
    
    % NOTE: The next two entries aren't really a part of the formal DH
    % table, they're just here to help with drawing the gripper parts
    table(6) = struct('theta', pi / 2,    'd', 0,      'a', grip / 2,  'alpha', 0);
    table(7) = struct('theta', 0,         'd', 0,      'a', -grip,     'alpha', 0);
end