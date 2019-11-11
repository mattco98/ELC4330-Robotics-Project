s = serial('COM9', 'Terminator', 'CR', 'BaudRate', 38400);
fopen(s);

while true
    info = input('Enter parameters in the form: [ch, pw, t]\n');
    
    if info == 'q'
        break;
    end
    
    cmd = sprintf("#%iP%iT%i", info(1), info(2), info(3));
    fprintf(s, cmd);
end

fclose(s);
delete(s);
clear s;