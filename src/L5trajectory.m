function L5trajectory(varargin)
    global A B
    
    if ~isequal(size(A), [6 1]) || ~isequal(size(B), [6 1])
        error('Error: A and B do not exist.\n');
    end
    
    joints = varargin{1};
    grip = varargin{2};
    
    if size(joints, 2) ~= size(grip, 2)
        error('Columns of joints must match columns of grip');
    end
    
    % Time the movements take
    time = 15;
    
    try
        % This throws an error if there are no ports open, so we surround
        % it with a try catch
        fclose(instrfind);
    catch
    end
    
    if nargin == 3 && varargin{3}
        LynxApp(joints, grip);
        return;
    end
    
    s = serial('COM7', 'Terminator', 'CR', 'BaudRate', 38400);
    fopen(s);
    
    try
        for i = 1:size(joints, 2)
            cmd = "";

            for j = 1:size(joints, 1)
                angle = joints(j, i);
                pos = round(A(j) * angle) + B(j);

                cmd = sprintf("%s#%iP%iT%i", cmd, j - 1, pos, time);
            end
            
            cmd = sprintf("%s#%iP%iT%i", cmd, 5, round(A(6) * grip(1, i)) + B(6), time);

            fprintf(s, cmd);
            java.lang.Thread.sleep(time);
        end
    catch e
        disp(e);
    end
    
    fclose(s);
    delete(s);
    clear s;
end

