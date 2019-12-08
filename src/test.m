% joints = [
%     -45:1:45
%     zeros(1, 91) + 90
%     zeros(1, 91) - 90
%     zeros(1, 91)
%     zeros(1, 91)
% ] * pi / 180;

joints = [
    0
    0
    0
    0
    0
];

% joints = [ % home v2
%     0
%     90
%     -90
%     0
%     0
% ] * pi / 180;

% joints = [
%     0
%     150
%     -120
%     60
%     0
% ] * pi / 180;

L5goto(joints, 0);
for i = 1:5
    L5trajectory(Joints, Grip);
    java.lang.Thread.sleep(500);
    L5trajectory(fliplr(Joints), fliplr(Grip));
    java.lang.Thread.sleep(500);
end
