syms t1 t2 t3 t4 t5 grip

dh = dh_table([t1 t2 t3 t4 t5], grip);

trans = Transformation.b();

for i = 4:5
    trans = trans.dh(dh(i).theta, dh(i).d, dh(i).a, dh(i).alpha);
end

simplify(vpa(trans.m(), 5))

%     table(1) = struct('theta', thetas(1), 'd', 8.415,  'a', 0,         'alpha', pi / 2);
%     table(2) = struct('theta', thetas(2), 'd', 0,      'a', 11.811,    'alpha', 0);
%     table(3) = struct('theta', thetas(3), 'd', 0,      'a', 12.4968,   'alpha', 0);

% vpa(Transformation.b().dh(t1, 8.415, 0, pi / 2).dh(t2, 0, 11.811, 0).dh(t3, 0, 12.4968, 0).m(), 5)