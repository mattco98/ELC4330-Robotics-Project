function pos = angleToPos(angle, joint)
global A B
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
