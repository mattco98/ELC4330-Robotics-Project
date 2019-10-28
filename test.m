angles = [
    rand() * pi - pi / 2
    rand() * pi
    rand() * -pi / 2
    rand() * 6 * pi / 8 - pi / 4
    rand() * 2 * pi - pi
]';

L5draw_group2(angles, 3.55)

ee = L5forward_group2(angles);
inv = L5inverse_group2(ee);

fprintf("Angles:         %8.3f %8.3f %8.3f %8.3f %8.3f\n", angles * 180 / pi);
fprintf("EE:             %8.3f %8.3f %8.3f %8.3f %8.3f\n", [ee(1:3), ee(4:5) * 180 / pi]);
fprintf("Inverse angles: %8.3f %8.3f %8.3f %8.3f %8.3f\n", inv * 180 / pi);