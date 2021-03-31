function saveDCMResults(DCM, filebase, outdir)

    mkdir( outdir );

    % print model parameters
    printDCMparams_csd( DCM, filebase, outdir );

    % print free-energy
    csvwrite( fullfile( outdir, strcat(filebase,'_F.csv') ), DCM.F );
