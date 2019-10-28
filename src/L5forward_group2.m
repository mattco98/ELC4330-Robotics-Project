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
%           [x; y; z; psi; phi] 

table = dh_table(jc, 0);
A1 = Transformation.b().dh(table(1).theta, table(1).d, table(1).a, table(1).alpha).m();
A2 = Transformation.b().dh(table(2).theta, table(2).d, table(2).a, table(2).alpha).m();
A3 = Transformation.b().dh(table(3).theta, table(3).d, table(3).a, table(3).alpha).m();
A4 = Transformation.b().dh(table(4).theta, table(4).d, table(4).a, table(4).alpha).m();
A5 = Transformation.b().dh(table(5).theta, table(5).d, table(5).a, table(5).alpha).m();
H6=A1*A2*A3*A4*A5;

pitch = atan2(-H6(3, 1), H6(3, 3));
roll = atan2(H6(2, 1) / cos(pitch), H6(1, 1) / cos(pitch));

eec = [H6(1:3, 4)', pitch + pi / 2, roll];

% pitchu = [1; 0; 0]
% pitchv = H6(1:3, 3)
% pitchcos = dot(pitchu, pitchv) / (norm(pitchu) * norm(pitchv))
% pitch = atan2(sqrt(1 - pitchcos ^ 2), pitchcos)

% AN1=H6(1,4)/H6(2,4);
% Lxy=sqrt((H6(1,4))^2+(H6(2,4))^2);
% AN2=H6(2,4)/Lxy;
% eec=[H6(1,4),H6(2,4),H6(3,4),atan(AN2),atan(AN1)];

%eec = [H6(1, 4), H6(2, 4), H6(3, 4), atan2(H6(2, 4), H6(1, 4)), atan2(H6(3, 4), H6(1, 4))];
end

