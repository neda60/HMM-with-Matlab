close('all');
clear;

bugIDs = importdata('C:\Mac\Neda\GnomePreData\allBugIds.mat');

homePath = 'C:\Mac\Neda\GnomePreData\';
trainPath = 'C:\Mac\Neda\GnomePreData\TrainingSet\';
testPath = 'C:\Mac\Neda\GnomePreData\TestingSet\';
for i = 1 : length(bugIDs)
    filepath = strcat(homePath,bugIDs{i},'\train_seqs.mat');
    train_seqs = importdata(filepath);
    
    filepath = strcat(homePath,bugIDs{i},'\test_seqs.mat');
    test_seqs = importdata(filepath);
    
    filepath = strcat(trainPath,bugIDs{i},'.txt');
    save_data(filepath,train_seqs);
    
    filepath = strcat(testPath,bugIDs{i},'.txt');
    save_data(filepath,test_seqs);
end