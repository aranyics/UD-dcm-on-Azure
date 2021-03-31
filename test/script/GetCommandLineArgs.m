function args = GetCommandLineArgs()

if isunix
    %fid = fopen(['/proc/' num2str(feature('getpid')) '/cmdline'], 'r');
    %args = textscan(fid, '%s', 'Delimiter', char(0));
    %fclose(fid);
    [status cmdout] = system(strcat('xargs -0 < ', ['/proc/' num2str(feature('getpid')) '/cmdline']));
    args = regexp(cmdout, ' ', 'split');
else
    kernel32WasAlreadyLoaded = libisloaded('kernel32');
    if ~kernel32WasAlreadyLoaded
        temporaryHeaderName = [gettempfolder '\GetCommandLineA.h'];
        dlmwrite(temporaryHeaderName, 'char* __stdcall GetCommandLineA(void);', '');
        loadlibrary('kernel32', temporaryHeaderName);
        delete(temporaryHeaderName);
    end
    args = textscan(calllib('kernel32', 'GetCommandLineA'), '%q');
    if ~kernel32WasAlreadyLoaded
        unloadlibrary kernel32;
    end
    args = args{1};
end
