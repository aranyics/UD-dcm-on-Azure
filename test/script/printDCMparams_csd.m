function printDCMparams_csd(DCM, filebase, outdir)

    % print endogenous connectivity
    csvname = fullfile( outdir, strcat(filebase,'_A.csv') );
    dlmwrite(csvname, full(DCM.Ep.A), 'delimiter', ',');
    csvname = fullfile( outdir, strcat(filebase,'_pA.csv') );
    dlmwrite(csvname, full(DCM.Pp.A), 'delimiter', ',');
    
%    % print external modulation and direct effect
%    if ( resting_state == 0 )
%        for i = 1:DCM.uN
%            csvname = fullfile( outdir, strcat(filebase,'_B', i, '.csv') );
%            dlmwrite(csvname, DCM.Ep.B(:,:,i)', '-append', 'delimiter', ',');
%            csvname = fullfile( outdir, strcat(filebase,'_pB', i, '.csv') );
%            dlmwrite(csvname, DCM.Pp.B(:,:,i)', '-append', 'delimiter', ',');
%        end
%        csvname = fullfile( outdir, strcat(filebase,'_C.csv') );
%        dlmwrite(csvname, DCM.Ep.C', '-append', 'delimiter', ',');
%        csvname = fullfile( outdir, strcat(filebase,'_pC.csv') );
%        dlmwrite(csvname, DCM.Pp.C', '-append', 'delimiter', ',');
%    end
%    
%    % print non-linear modulation
%    if ( DCM.options.nonlinear == 1 )
%        for i = 1:DCM.n
%            csvname = fullfile( outdir, strcat(filebase,'_D', i, '.csv') );
%            dlmwrite(csvname, DCM.Ep.D(:,:,i)', '-append', 'delimiter', ',');
%            csvname = fullfile( outdir, strcat(filebase,'_pD', i, '.csv') );
%            dlmwrite(csvname, DCM.Pp.D(:,:,i)', '-append', 'delimiter', ',');
%        end
%    end
    
    % print hemodynamic Balloon-parameters
    csvname = fullfile( outdir, strcat(filebase,'_transit.csv') );
    dlmwrite(csvname, full(DCM.Ep.transit)', 'delimiter', ',');
    csvname = fullfile( outdir, strcat(filebase,'_ptransit.csv') );
    dlmwrite(csvname, full(DCM.Pp.transit)', 'delimiter', ',');
    
    csvname = fullfile( outdir, strcat(filebase,'_decay.csv') );
    dlmwrite(csvname, full(DCM.Ep.decay)', 'delimiter', ',');
    csvname = fullfile( outdir, strcat(filebase,'_pdecay.csv') );
    dlmwrite(csvname, full(DCM.Pp.decay)', 'delimiter', ',');
    
    csvname = fullfile( outdir, strcat(filebase,'_epsilon.csv') );
    csvwrite( csvname, full(DCM.Ep.epsilon) );
    csvname = fullfile( outdir, strcat(filebase,'_pepsilon.csv') );
    csvwrite( csvname, full(DCM.Pp.epsilon) );

end
