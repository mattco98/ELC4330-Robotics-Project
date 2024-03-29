function eec = L5forward_group2(jc)
    % L5FORWARD_GROUP2 Calculates forward kinematics for the Lynx robot arm.
    % 
    %   Given a 5x1 column matrix of joint angles, jc, this function calculates
    %   the position and orientation of the end affector for the Lynx robot
    %   arm.
    %
    % Parameters:
    %     jc  - 5x1 colum matrix containing the angles for joints 1-5 in radians.
    %     Where jc contains [t1, t2, t3, t4, t5], t2 must be postive and t3
    %     and t4 must be negative.
    %
    % Returns:
    %     eec - The end effector position and orientation, in the format 
    %           [x; y; z; pitch; roll] 

    % Get DH table
    dh = dh_table(jc);

    % The Transformation object is from a library we built specifically to
    % do matrix calculation. For information on how it works, see
    % lib/matrix-transformations/README.md. 
    trans = Transformation.b();

    for i = 1:5
        % Make 5 DH matrices and multiple them together
        trans = trans.dh(dh(i).theta, dh(i).d, dh(i).a, dh(i).alpha);
    end

    % Get the matrix from the transformation object.
    fr = trans.m();
    o = fr(3, 3) ^ 2;
    if (o > 1)
        o = 1;
    end
    % Eq 2.29
    theta = atan2(-sqrt(1 - o), fr(3, 3));
    
    % Eq 2.33
    psi = jc(5);

    eec = [fr(1:3, 4); theta; psi];
end

