close('all');
clear;

 %mainPath = 'I:\NEDA\ECLIPSE\HMMJ\';
 %mainPath = 'I:\NEDA\GNOME\HMMJ\';
 %mainPath = 'I:\NEDA\GNOME\HMMJ with unique traces\';
 mainPath = 'I:\NEDA\FIREFOX DATA\HMM_J\HMMJ 124 stacks\';
 %mainPath = 'I:\NEDA\GNOME\HMMJ with unique traces\Gnome 182\';
 %mainPath = 'I:\NEDA\GNOME\5 dup buckets\'
 %mainPath = 'I:\NEDA\ECLIPSE\HMMJ unique traces\'
 %mainPath = 'I:\NEDA\ECLIPSE\HMMJ unique traces\'
% If you only need the allBugID file 

%folderPath = 'I:\NEDA\FIREFOX DATA\HMM3\3buckets\Cleaned Stacks\';
%folderPath = 'I:\NEDA\ECLIPSE\HMM2\Converted to ID\';
%folderPath = 'I:\NEDA\GNOME\Converted to ID\';
folderPath = strcat(mainPath ,'Train\');
Folder = fullfile(folderPath);
d = dir(Folder);
fileNames = {d.name}';
flag = 3; %start index of original file in "converted to ID" directory

%initialize the bug_ids variable
noHmm = length(fileNames) - flag + 1;
bug_ids = cell([noHmm,1]);


  
for m = flag : length(fileNames) %starting no of hmm loop (i.e. no of unique bug_ID)
    
    bug_id = fileNames{m};
    bug_id = bug_id(1:end-4);%end-4
    % bug_id = bug_id(1:end);
    bug_ids{m-flag+1, 1} = bug_id;
end


saveFile =  strcat(mainPath ,'allBugIds');
%saveFile = 'I:\NEDA\FIREFOX DATA\HMM3\3buckets\allBugIds';
% saveFile = 'I:\NEDA\FIREFOX DATA\HMM\allBugIds';
save(saveFile, 'bug_ids');


% 
% 
% % Uncomment the below code and comment the abow code
% %% ======Load training data into a Cell Array of Vectrors======
% 
% % read files names of all bug_ids 
%  %folderPath = 'I:\NEDA\ECLIPSE\Eclipse_convetedID\ID\';
% folderPath = 'I:\NEDA\GNOME\GNOME Traces\';
% Folder = fullfile(folderPath);
% d = dir(Folder);
% fileNames = {d.name}';
% flag = 3; %start index of original file in "converted to ID" directory
% 
% %initialize the bug_ids variable
% noHmm = length(fileNames) - flag + 1;
% bug_ids = cell([noHmm,1]);
% 
% %initialize hmm parameter
% % N = 10; M = 10000;
% % [A, B, P] = init_hmm(M, N);
%   
% for m = flag : length(fileNames) %starting no of hmm loop (i.e. no of unique bug_ID)
%     
%     bug_id = fileNames{m};
%     bug_id = bug_id(1:end);%end-4
%     % bug_id = bug_id(1:end);
%     bug_ids{m-flag+1, 1} = bug_id;
% 
%     % read all traces of each bug type and split it into training and testing
%     %filePath = strcat('I:\NEDA\ECLIPSE\Eclipse_convetedID\ID\', bug_id);%,'.txt'
%     filePath = strcat('I:\NEDA\GNOME\GNOME Traces\', bug_id);%,'.txt'
%     seqs = cell([1 1]); idxTrain = 1;
%     fid = fopen(filePath);
%     tline = fgets(fid);
%     while ischar(tline)
%         C = strsplit(tline);
%         seq = zeros(1, 1); idxSeq = 1;
%         for i = 1 : length(C)
%             num = str2num(C{i});
%             if (~isempty(num))
% %                 if(num ==  0)
% %                     num = 6494;
% %                 end
%                 seq(1, idxSeq) = num;
%                 idxSeq = idxSeq + 1;
%             end
%         end
% %         if (idxSeq>1)
%             seqs{idxTrain, 1} = seq; idxTrain = idxTrain + 1;
% %         end
%         tline = fgets(fid);
%     end
%     fclose(fid);
% %     %divide all seqs into training (80%) and testing(20%)
%     totalSeqs = length(seqs);
%     noTrainSeqs = floor(0.70*totalSeqs);
%     trainIdx = randperm(totalSeqs,noTrainSeqs);
%     train_seqs = seqs(trainIdx);
%     test_seqs = cell([totalSeqs-noTrainSeqs,1]); idxTest = 1;
%     for k = 1 : length(seqs)
%         if( find(trainIdx == k) > 0)
%             continue;
%         else
%             test_seqs{idxTest, 1} = seqs{k, 1}; idxTest = idxTest + 1;
%         end
%     end
% 
%     %save whole seqs, trining, and testing for each bug_id
%     %savePath = strcat('I:\NEDA\ECLIPSE\HMM\PreProcess\', bug_id);
%     savePath = strcat('I:\NEDA\GNOME\HMM\Data\', bug_id(1:end-4));
%     if (exist(savePath) == 0)
%         mkdir (savePath);
%     end
%     saveFile = strcat(savePath,'\',bug_id);
%     save(saveFile, 'seqs');
%     saveFile = strcat(savePath,'\train_seqs');
%     save(saveFile, 'train_seqs');
%     saveFile = strcat(savePath,'\test_seqs');
%     save(saveFile, 'test_seqs');
% 
% end %end of no of hmm (m) loop
% saveFile = 'I:\NEDA\GNOME\HMM\allBugIds';
% save(saveFile, 'bug_ids');
