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
end

