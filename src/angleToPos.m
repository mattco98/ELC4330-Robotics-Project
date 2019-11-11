% angleToPos(pi / 2, 1)
% angleToPos(0, 1)
% angleToPos(pi / 2, 2)
% angleToPos(2.3562, 2)

%{

900: 45 degrees
1300: 90

pi / 2: 1350
0: 530

%}

function pos = angleToPos(angle, joint)
    A = [
        -509.29462694169
        509.29598869567
        -572.95779520082
        522.02821334304
        0
    ];

    B = [
        1300
        700
        600
        530
        0
    ];

    a = A(joint + 1);
    b = B(joint + 1);
    
    pos = round(a * angle) + b;
end








