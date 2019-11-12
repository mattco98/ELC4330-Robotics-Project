function L5trajectory(varargin)
    joints = varargin{1};
    grip = varargin{2};
    
    if nargin == 3 && varargin{3}
        LynxApp(joints, grip);
        return;
    end
    
    s = serial('COM9', 'Terminator', 'CR', 'BaudRate', 38400);
    fopen(s);
    
    try
        for i = 1:size(joints, 2)
            cmd = "";

            for j = 1:size(joints, 1)
                angle = joints(j, i);
                p = angleToPos(angle, j - 1);

                cmd = sprintf("%s#%iP%iT%i", cmd, j - 1, p, 20);
            end

            fprintf(s, cmd);
            java.lang.Thread.sleep(20);
        end
    catch e
        disp(e);
    end
    
    fclose(s);
    delete(s);
    clear s;
end

