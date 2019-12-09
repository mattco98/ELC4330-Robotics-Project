function L5goto(varargin)
    global A B
    
    if ~isequal(size(A), [6 1]) || ~isequal(size(B), [6 1])
        error('Error: A and B do not exist.\n');
    end
    
    try
        % This throws an error if there are no ports open, so we surround
        % it with a try catch
        fclose(instrfind);
    catch
    end

    % joints is the jointspace (5 thetas) in radians
    % grip is the distance between the grippers in cm
    % flag is optional boolean

    joints = varargin{1};
    grip = varargin{2};
    
    if nargin == 3 && varargin{3}
        flag = varargin{3};
    else
        flag = 0;
    end
    
    % Time the movement takes
    time = 1000;
    
    if flag ~= 0
        % variables will be passed to LynxApp
        LynxApp(joints, grip);
        return;
    end
        
    s = serial('COM12', 'Terminator', 'CR', 'BaudRate', 38400);
    fopen(s);

    cmd = "";

    for i = 1:5
        % variables will be passed to robot 
        % get position
        pos = round(A(i) * joints(i)) + B(i);
        cmd = sprintf("%s#%iP%iT%i", cmd, i - 1, pos, time);
    end
    
    cmd = sprintf("%s#%iP%iT%i", cmd, 5, round(A(6) * grip) + B(6), time);

    fprintf(s, cmd);
    
    fclose(instrfind);
end

