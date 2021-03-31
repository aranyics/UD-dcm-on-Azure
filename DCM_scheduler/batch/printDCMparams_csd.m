function printDCMparams_csd(DCM, data_DCM_path, modelName, SubjName, resting_state)


    csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_A.csv'); copyfile('hd.csv', csvname);
    dlmwrite(csvname, DCM.Ep.A, '-append', 'delimiter', ',');
    csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_pA.csv'); copyfile('hd.csv', csvname);
    dlmwrite(csvname, DCM.Pp.A, '-append', 'delimiter', ',');
    
%    if ( resting_state == 0 )
%        for i = 1:DCM.uN
%            csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_B',i,'.csv'); copyfile('hd.csv', csvname);
%            dlmwrite(csvname, DCM.Ep.B(:,:,i)', '-append', 'delimiter', ',');
%            csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_pB',i,'.csv'); copyfile('hd.csv', csvname);
%            dlmwrite(csvname, DCM.Pp.B(:,:,i)', '-append', 'delimiter', ',');
%        end
%        csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_C.csv'); copyfile('hd.csv', csvname);
%        dlmwrite(csvname, DCM.Ep.C', '-append', 'delimiter', ',');
%        csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_pC.csv'); copyfile('hd.csv', csvname);
%        dlmwrite(csvname, DCM.Pp.C', '-append', 'delimiter', ',');
%    end
%    
%    if ( DCM.options.nonlinear == 1 )
%        for i = 1:DCM.n
%            csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_D',i,'.csv'); copyfile('hd.csv', csvname);
%            dlmwrite(csvname, DCM.Ep.D(:,:,i)', '-append', 'delimiter', ',');
%            csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_pD',i,'.csv'); copyfile('hd.csv', csvname);
%            dlmwrite(csvname, DCM.Pp.D(:,:,i)', '-append', 'delimiter', ',');
%        end
%    end
%    
%    % print hemodynamic parameters
%    csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_transit.csv'); copyfile('hd.csv', csvname);
%    dlmwrite(csvname, DCM.Ep.transit', '-append', 'delimiter', ',');
%    csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_ptransit.csv'); copyfile('hd.csv', csvname);
%    dlmwrite(csvname, DCM.Pp.transit', '-append', 'delimiter', ',');
%    
%    csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_decay.csv'); copyfile('hd.csv', csvname);
%    dlmwrite(csvname, DCM.Ep.decay', '-append', 'delimiter', ',');
%    csvname = strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_pdecay.csv'); copyfile('hd.csv', csvname);
%    dlmwrite(csvname, DCM.Pp.decay', '-append', 'delimiter', ',');
%    
%    csvwrite( strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_epsilon.csv'), DCM.Ep.epsilon );
%    csvwrite( strcat(data_DCM_path,'/results/csv/',modelName,'/',SubjName,'_',modelName,'_pepsilon.csv'), DCM.Pp.epsilon );


end