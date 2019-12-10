home = [
    0
    0
    0
    0
    0
];

% Symbolic variables
syms a0 a1 a2 a3 a4 a5 t0 tf;

% Initial and final time matrix
M = [
    1 t0 t0^2 t0^3   t0^4    t0^5
    0 1  2*t0 3*t0^2 4*t0^3  5*t0^4
    0 0  2    6*t0   12*t0^2 20*t0^3
    1 tf tf^2 tf^3   tf^4    tf^5
    0 1  2*tf 3*tf^2 4*tf^3  5*tf^4
    0 0  2    6*tf   12*tf^2 20*tf^3
];

% Movement constants
H = [
    a0
    a1
    a2
    a3
    a4
    a5
];

% Positions of each movement
P = [
    0        0         0          0        0        0
    0.523599 1.0821   -0.994838   0        0.523599 3.55
    0.523599 0.55     -.85        0        0.523599 3.55
    0.523599 0.55     -.85        0        0.523599 2
    0.523599 1.007571 -1.30899694 0.436332 0.523599 2
   -0.710865 0.8      -2.2        3.4      0        2
   -0.710865 0.8      -2.2        2.6      0        2
   -0.710865 0.8      -2.2        2.6      0        3.55
];

% Matrix of initial and final times
% Each column is one movement
T = [
    0 3 5   5.5 6.5 8.5 9
    3 5 5.5 6.5 8.5 9   10
] .* 2000;

jointsCell = cell(1, size(P, 1) - 1);
gripCell = cell(1, size(P, 1) - 1);

for i = 2:size(P, 1)
    time = T(:, i-1);
    t1 = time(1);
    t2 = time(2);
    steps = floor((t2 - t1)/40);
    Q = zeros(6, steps + 1);

    for j = 1:size(P, 2)
        q0 = P(i - 1, j);
        qf = P(i, j);

        m = subs(M, [t0 tf], [time(1) time(2)]);
        [b0, b1, b2, b3, b4, b5] = solve(m * H == [q0 0 0 qf 0 0]');

        q = @(t) b0 + b1*t + b2*t^2 + b3*t^3 + b4*t^4 + b5*t^5;
        samples = t1:(t2-t1)/steps:t2;
        Q(j, :) = double(arrayfun(q, samples));
    end
    
    jointsCell{i-1} = Q(1:5, :);
    gripCell{i-1} = Q(6, :);
end

global joints grip;
joints = [];
grip = [];

for i = 1:length(jointsCell)
    joints = [joints jointsCell{i}];
    grip = [grip gripCell{i}];
end
