function saveDCMResults(DCM, data_DCM_path, results_DCM_path, modelName, SubjName, resting_state, DCM_filename, DCM_mode)    

    parts = strsplit(SubjName, '_');
    SessID = strcat(parts{2}, '_', parts{3});
    SubjName = parts{1};

    % print model parameters
    mkdir( fullfile(results_DCM_path,'results','csv',modelName) );
    mkdir( fullfile(results_DCM_path,'results','par',modelName) );
    saveDCMHeader( 'hd.csv', fullfile(data_DCM_path,SubjName,SessID,DCM_filename) );
    printDCMparams_csd( DCM, results_DCM_path, modelName, strcat(SubjName,'_',SessID), resting_state );
    
    % print free-energy
    csvwrite( strcat(results_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',SessID,'_',modelName,'_F.csv'), DCM.F );
    
    % save parameter structures
    Ep = DCM.Ep;
    Pp = DCM.Pp;
    Cp = DCM.Cp;
    if ~strcmp( DCM_mode, 'csd' )
        Vp = DCM.Vp;
    end
    save( strcat(results_DCM_path,'/results/par/',modelName,'/Ep_',DCM_filename),'Ep' );
    save( strcat(results_DCM_path,'/results/par/',modelName,'/Pp_',DCM_filename),'Pp' );
    save( strcat(results_DCM_path,'/results/par/',modelName,'/Cp_',DCM_filename),'Cp' );
    if ~strcmp( DCM_mode, 'csd' )
        save( strcat(results_DCM_path,'/results/par/',modelName,'/Vp_',DCM_filename),'Vp' );
    end
    