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
    
    % Get DH table
    dh = dh_table([0; 0; 0; 0; 0]);
    
    d1 = dh(1).d;
    a2 = dh(2).a;
    a3 = dh(3).a;
    d5 = dh(5).d;
    
    xee = eec(1);
    yee = eec(2);
    
    t1 = atan2(yee, xee);
    phi = eec(4);
    psi = eec(5);
    
    R = Transformation.r().z(t1).y(pi / 2 - phi).z(pi + psi).m();
    
    pc = eec(1:3) - d5 * R(1:3, 1:3) * [0; 0; 1];
    px = pc(1);
    py = pc(2);
    pz = pc(3);
    
    D = (px^2 + py^2 + (pz - d1) ^ 2 - a2 ^ 2 - a3 ^ 2) / (2 * a2 * a3);
    t3 = atan2(-sqrt(1 - D ^ 2), D);
    t2 = atan2(pz - d1, sqrt(px ^ 2 + py ^ 2)) - atan2(a3 * sin(t3), a2 + a3 * cos(t3));
    t4 = phi - t2 - t3 + pi / 2;
    t5 = psi;
    
    jc = [t1; t2; t3; t4; t5];
end

