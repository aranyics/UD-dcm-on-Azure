% Arguments: s, m

addpath( genpath( fileparts( mfilename('fullpath') ) ) );
addpath( fullfile( getenv('HOME'), 'matlabsrc', 'spm' ) );
args = GetCommandLineArgs();

s = '';
r = '';
m = '';
%s = '133019';
%r = 'REST1_LR';
%m = 'MDMNFC';

for a = 1:length(args)
    try
        tmp = args{a};
        tmp = tmp( regexp(tmp, '=') + 1 : length(tmp) );
    end
    if strfind(args{a}, 's=') == 1
        s = tmp
    end
    if strfind(args{a}, 'r=') == 1
        r = tmp
    end
    if strfind(args{a}, 'm=') == 1
        m = tmp
    end
end


set(0,'DefaultFigureVisible','off');

% directories
project_path = fullfile( getenv('HOME'), 'azure/analysis/DCM/largescale/' );
%DCM_dir = 'conn/';
%project_path = '/mnt/raid6_data/hc/azure/analysis/DCM/largescale/'; %path for testing
DCM_dir = 'conn_4sess/';

% script run
argGLM = 0;
argVOI = 0;
argDCM = 1;
motcorr = 1;
resting_state = 1;

SessID = 'null';
ParID = 'null';
SubjID = 'null';
SubjName = 'null';

%ts_path = strcat(project_path, DCM_dir, '/ts/');
ts_path = strcat(project_path, '/ts/');


%  1:55   56:110 111:165 166:220 221:275 276:330 331:385 386:440
%441:495 496:550 551:605 606:660 661:715 716:770 771:825 826:880
%p1 - 1:143

for subjCnt = [1:1]

    SubjID = s;


for paradigm = [1]

    %if paradigm == 1
    %    ParID = 'rfMRI';
    %end

for sessionCnt = [1]

    %if sessionCnt == 1
    %    SessID = 's01';
    %end
    
    SessID = r;


    %SubjName = strcat(SubjID, '-', ParID, '_', SessID);
    SubjName = strcat(SubjID);
    SubjSessName = strcat(SubjID, '_', SessID);

    fprintf('\n\n%s %s\n', SubjName, SessID);


    data_DCM_path = strcat(project_path, DCM_dir);
    results_DCM_path = strcat(project_path);


   % try
% Initialise SPM
%--------------------------------------------------------------------------
spm('Defaults','fMRI');
spm_jobman('initcfg');
%spm_get_defaults('cmdline',1);


%%
% GLM for 1 session
%--------------------------------------------------------------------------

if argGLM == 1


end

%%
% VOI extraction
%--------------------------------------------------------------------------
if argVOI == 1



end




    
for modelCnt = [2]
    
    if modelCnt == 99
        mkdir(ts_path);
    end

    


% DCM computations

if argDCM == 1

clear DCM


if modelCnt == 2

    modelName = m;
    DCM_mode = 'csd';
    %DCM_filename = strcat('DCM_', SubjName, '_', modelName,'_', DCM_mode, '.mat');
    DCM_filename = strcat('DCM_', SubjName, '_', SessID, '_', modelName,'_', DCM_mode, '.mat');

    %load( fullfile(data_DCM_path,SubjName,DCM_filename),'DCM');
    load( fullfile(data_DCM_path,SubjName,SessID,DCM_filename),'DCM');

    if strcmp(DCM_mode, 'sto')
        DCM = spm_dcm_estimate( fullfile(data_DCM_path,SubjName,SessID,DCM_filename) );
    end
    if strcmp(DCM_mode, 'csd')
        DCM = spm_dcm_fmri_csd( fullfile(data_DCM_path,SubjName,SessID,DCM_filename) );
    end

    %saveDCMResults(DCM, data_DCM_path, results_DCM_path, modelName, SubjName, resting_state, DCM_filename, DCM_mode);
    saveDCMResults(DCM, data_DCM_path, results_DCM_path, modelName, SubjSessName, resting_state, DCM_filename, DCM_mode);

end


if modelCnt == 99
    

try

    mkdir(ts_path);
    
    header = DCM.Y.name(1);
    for v = 2:size(DCM.Y.name, 2)
        header = strcat( header, ',', DCM.Y.name(v));
    end
    
    %csvname = strcat(ts_path, SubjName, '_ts.csv');
    csvname = strcat(ts_path, SubjName, '_', SessID, '_ts.csv');
    
    dlmwrite(csvname, header, 'delimiter', '');
    dlmwrite(csvname, DCM.Y.y, '-append', 'delimiter', ',');
    
catch
    
    print('Warning: write timeseries\n')
    
end
    
end


end



end

%     catch
% 
%         try
%             rm_cmd = strcat({'rm '}, {data_filepath}, {data_filename});
%             %system(rm_cmd{:});
%         catch
% 
%         end
%         
%         continue
%     end
% 
%     
%     try
%         rm_cmd = strcat({'rm '}, {data_filepath}, {data_filename});
%         %system(rm_cmd{:});
%     catch
% 
%     end


end


end



assignin('base', 'voierr', VOIerr);

end

fprintf('\nfinished \n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FINISH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%matlab -nodisplay -nosplash -nodesktop -r "run('/mnt/raid6_data/hc/azure/analysis/DCM/batch/GLM_DCM_rest_p1.m'); exit;"
