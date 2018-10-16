close('all');
clear;
% homePath = 'C:\Users\Neda\Desktop\HMMCode full\GenomeID\Pre\';

    Data = importdata('I:\NEDA\FIREFOX DATA\HMM\allBugIds.mat');
    %DataField = fieldnames(Data);
    %dlmwrite('I:\NEDA\FIREFOX DATA\HMM\allBugIds.txt', Data.(DataField{1}));
    %save('I:\NEDA\FIREFOX DATA\HMM\allBugIds.txt', 'Data','-ASCII');%.(DataField{1})



% for N = 15 : 5 : 50;
    
%     Data = load(strcat('I:\NEDA\GNOME\HMM\Result\recog_', num2str(N)));
%     DataField = fieldnames(Data);
%     dlmwrite(strcat('I:\NEDA\GNOME\HMM\Result\conver2txt\recog_', num2str(N)), Data.(DataField{1}));
    
%     Data1 = load(strcat('I:\NEDA\GNOME\HMM\Result\scores_hmm', num2str(N)));
%     DataField1 = fieldnames(Data1);
%     dlmwrite(strcat('I:\NEDA\GNOME\HMM\Result\conver2txt\scores_hmm', num2str(N)), Data1.(DataField1{1}));
    
% end;

% 
% bugIDs = importdata('I:\NEDA\GNOME\HMM\allBugIds.mat');
% homePath = 'I:\NEDA\GNOME\HMM\Pre\';
% for i = 1 : length(bugIDs)
% 
%     Data = load(strcat(homePath,bugIDs{i},'\test_seqs.mat'));
%     DataField = fieldnames(Data);
%     xlswrite(strcat('I:\NEDA\GNOME\HMM\Result\conver2txt\hmms\test_seq_', bugIDs{i}), Data.(DataField{1}));
% 
% % FileData = load('I:\NEDA\GNOME\HMM\hmm\hmms15.mat');
% % csvwrite('I:\NEDA\GNOME\HMM\Result\conver2txt\hmms\hmms_15', FileData);
% 
% end;
    