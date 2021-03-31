
% Arguments: dcmfile, outdir

addpath( genpath( fileparts( mfilename('fullpath') ) ) );
addpath( fullfile( getenv('HOME'), 'matlabsrc', 'spm' ) );
args = GetCommandLineArgs();



dcmfile1 = '';
dcmfile2 = '';
dcmfile3 = '';
outdir = '';

for a = 1:length(args)
    try
	tmp = args{a};
	tmp = tmp( regexp(tmp, '=') + 1 : length(tmp) );
    end
    if strfind(args{a}, 'dcmfile1=') == 1
	dcmfile1 = tmp
    end
    if strfind(args{a}, 'dcmfile2=') == 1
	dcmfile2 = tmp
    end
    if strfind(args{a}, 'dcmfile3=') == 1
	dcmfile3 = tmp
    end
    if strfind(args{a}, 'outdir=') == 1
	outdir = tmp
    end
end

dcmfiles = {dcmfile1; dcmfile2; dcmfile3};


computer = getComputerName();
v = ver('MATLAB');
v = v.Release;
SPMv = spm('version');

outcompdir = fullfile( outdir, v, SPMv, computer );
mkdir( outcompdir );
cd(outcompdir);

spm('Defaults', 'fMRI');

for f = [1:1]

    clear DCM

    [p b e] = fileparts( dcmfiles{f} );
    modeldir = strsplit(p, '/');
    modeldir = modeldir{end};
    mkdir( fullfile( outcompdir, modeldir, b ) );

    %profile -nohistory
    %profile -timer real
    %profile on
    timeStart = tic;
    DCM = spm_dcm_fit( dcmfiles{f} );
    timeStop = toc(timeStart)
    %profile off
    %profinfo = profile('info');
    %profstatus = profile('status');
    %profsave( profinfo, fullfile( outdir, b ) );
    %save( fullfile( outdir, b, 'timer.mat' ), 'profstatus' );

    try
        DCM = DCM{1};
    end
    saveDCMResults( DCM, b, fullfile(outcompdir, modeldir, b) );
    dlmwrite( fullfile( outdir, 'runtime.csv' ), strcat(datestr(clock),',',v,',',SPMv,',',computer,',',modeldir,',',b,',',num2str(timeStop),'s'), '-append', 'delimiter', '' );
    save( fullfile( outcompdir, modeldir, strcat(b, e) ), 'DCM' );

end
