function saveDCMHeader(filename, DCMmat)


load(DCMmat, 'DCM');

voiNames = cell(1,length(DCM.xY));
for i = 1:length(voiNames)
voiNames{i} = strcat('"', DCM.xY(1,i).name, '"');
end

voiHeader = [];
for i = 1:length(voiNames)
voiHeader = strcat(voiHeader, ',', voiNames{i});
end
voiHeader = voiHeader(2:end);

fileID = fopen(filename,'w');
fprintf(fileID, '%s\n', voiHeader);
fclose (fileID);


end