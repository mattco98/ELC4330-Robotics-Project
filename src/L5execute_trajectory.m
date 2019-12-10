global joints grip;

% Start at home position
L5goto([-0.710865, 1.558505, -1.8326, 2.79253, 0, 3.55], 0);
java.lang.Thread.sleep(1500);
L5goto(home, 0);
java.lang.Thread.sleep(1500);

L5trajectory(joints, grip);
