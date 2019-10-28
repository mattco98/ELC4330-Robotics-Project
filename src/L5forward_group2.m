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

    fr = trans.m();

    pitch = atan2(-fr(3, 1), fr(3, 3));
    roll = atan2(fr(2, 1) / cos(pitch), fr(1, 1) / cos(pitch));

    eec = [fr(1:3, 4)', pitch + pi / 2, roll];
end

