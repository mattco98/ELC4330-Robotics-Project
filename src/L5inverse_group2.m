function jc = L5inverse_group2(eec)
    % L5INVERSE_GROUP2 Calculates inverse kinematics for the Lynx robot arm.
    % 
    %   Given a 5x1 column matrix containing the position and orientation of 
    %   the end affector, this function calculates all five joint angles
    %   required for the end affector to reach that position and orientation.
    %
    % Parameters:
    %     eec - The end effector position and orientation, in the format 
    %            [x; y; z; pitch; roll] 
    %
    % Returns:
    %     jc  - 5x1 colum matrix containing the angles for joints 1-5 in 
    %           radians.
    
    d1 = 8.415;
    a2 = 11.811;
    a3 = 12.4968;
    d5 = 8.3388;
    
    x = eec(1);
    y = eec(2);
    z = eec(3);

    phi = atan2(y, x);
    theta = eec(4);
    psi = eec(5);

    R = [
        cos(phi)*cos(theta)*cos(psi) - sin(phi)*sin(psi), -cos(phi)*cos(theta)*sin(psi) - sin(phi)*cos(psi), cos(phi)*sin(theta)
        sin(phi)*cos(theta)*cos(psi) + cos(phi)*sin(psi), -sin(phi)*cos(theta)*sin(psi) + cos(phi)*cos(psi), sin(phi)*sin(theta)
        -sin(theta)*cos(psi),                              sin(theta)*sin(psi),                              cos(theta)
    ]

    fprintf("Theta: %8.3f\nPhi: %8.3f\nPsi: %8.3f\n", theta, phi, psi);

    px = x - d5 * R(1, 3);
    py = y - d5 * R(2, 3);
    pz = z - d5 * R(3, 3);
    
    % Eq (3.43)
    t1 = atan2(py, px);
    
    % Eq (3.44)
    D = (px ^ 2 + py ^ 2 + (pz - d1) ^ 2 - a2 ^ 2 - a3 ^ 2) / (2 * a2 * a3);
    
    % Eq (3.45)
    t3 = atan2(-sqrt(1 - D ^ 2), D);
    
    % Eq (3.46)
    t2 = atan2(pz - d1, sqrt(px ^ 2 + py ^ 2)) - atan2(a3 * sin(t3), a2 + a3 * cos(t3));
    
    us = cos(t1)*cos(t2 + t3)*R(1, 3) + sin(t1)*cos(t2 + t3)*R(2, 3) + sin(t2 + t3)*R(3, 3);
    uc = cos(t1)*sin(t2 + t3)*R(1, 3) + sin(t1)*sin(t2 + t3)*R(2, 3) - cos(t2 + t3)*R(3, 3);
    
    t4 = atan2(us, uc);
    t5 = atan2(sin(t1)*R(1, 1) - cos(t1)*R(2, 1), sin(t1)*R(2, 1) - cos(t1)*R(2, 2));
    
    jc = [t1 t2 t3 t4 t5];
end

