function eec = L5forward_group2(jc)
    % L5FORWARD_GROUP2 Calculates forward kinematics for the Lynx robot arm.
    % 
    %   Given a 5x1 column matrix of joint angles, jc, this function calculates
    %   the position and orientation of the end affector for the Lynx robot
    %   arm.
    %
    % Parameters:
    %     jc  - 5x1 colum matrix containing the angles for joints 1-5 in radians.
    %
    % Returns:
    %     eec - The end effector position and orientation, in the format 
    %           [x; y; z; pitch; roll] 

    dh = dh_table(jc, 0);

    trans = Transformation.b();

    for i = 1:5
        trans = trans.dh(dh(i).theta, dh(i).d, dh(i).a, dh(i).alpha);
    end

    fr = trans.m()
    
    theta = atan2(fr(3, 3), sqrt(1 - fr(3, 3) ^ 2));
    phi = atan2(fr(2, 4), fr(1, 4));
    psi = atan2(-fr(3, 1), fr(3, 2));
    
    fprintf("Theta: %8.3f\nPhi: %8.3f\nPsi: %8.3f\n", theta, phi, psi);

%     pitch = atan2(fr(3, 3), fr(1, 3));
%     roll = atan2(fr(2, 4), fr(1, 4));
%     yaw = atan2(fr(2, 3), fr(3, 3)) * 180 / pi

%     pitch = atan2(-fr(3, 1), sqrt(fr(3, 2) ^ 2 + fr(3, 3) ^ 2));
%     roll = atan2(fr(2, 1), fr(1, 1));
%     yaw = atan2(fr(2, 3), fr(3, 3)) * 180 / pi

%     pitch = atan2(-fr(3, 1), fr(3, 3));
%     roll = atan2(fr(2, 1) / cos(pitch), fr(1, 1) / cos(pitch));

    eec = [fr(1:3, 4)', theta, psi];
end

