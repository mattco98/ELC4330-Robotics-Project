function L5goto(varargin)
% joints is the jointspace (5 thetas) in radians
% grip is the distance between the grippers in cm
% flag is optional boolean
fclose(instrfind)

joints = varargin{1};
grip = varargin{2};

A = [-509.29; 509.29; -572.96; 522.03; 0];
B = [1300; 700; 600; 530; 0];
t = 1000;

if nargin == 3 && varargin{3}
    flag = varargin{3}
    if flag ~= 0
        % variables will be passed to LynxApp
        i = 0;
        % variables will be passed to robot 
        % get position
        angleToPos(joints(i+1), i);
        LynxApp(joints, grip);


    else
        i = 0;
        s = serial('COM7', 'Terminator', 'CR', 'BaudRate', 38400);
        fopen(s);
        for i = 0:4
            % variables will be passed to robot 
            % get position
            angleToPos(joints(i+1),i)

            if exist('A') && exist('B')
                cmd = sprintf("#%iP%iT%i", i, ans, t);
                fprintf(s, cmd);
            else
                disp('Error: A and B do not exist.\n')
            end
        end
    end
    
   else
        i = 0;
        s = serial('COM7', 'Terminator', 'CR', 'BaudRate', 38400);
        fopen(s);
        for i = 0:4
            % variables will be passed to robot 
            % get position
            angleToPos(joints(i+1),i)

            if exist('A') && exist('B')
                cmd = sprintf("#%iP%iT%i", i, ans, t);
                fprintf(s, cmd);
            else
                disp('Error: A and B do not exist.\n')
            end
        end   
end

