close('all');
clear;
%% ======Load training data into a Cell Array of Vectrors======
% bugIDs = importdata('C:\Mac\Neda\PreparedData_Bug\allBugIds.mat');



TextOrMat = 2; % 1 for using mat files, others for using test and train text files

if TextOrMat == 1
%   homePath = 'C:\Users\Neda\Desktop\HMMCode full\GenomeID\Pre\';
%   hmmPath = 'C:\Users\Neda\Desktop\HMMCode full\GenomeID\hmm\';  
%   bugIDs = importdata('C:\Users\Neda\Desktop\HMMCode full\GenomeID\allBugIds.mat');  
% 
%     for N = 15 : 5 : 50; 
%     % M = 11861;
%     % M = 2517; %for Eclipse
%     %M = 6494; %for Gnome
%         M = 1431; % For Mozilla Journal
%         [AA, BB, PP] = init_hmm(M, N);
%         hmms = []; hmm = cell([1, 3]);
%         for i = 1 : length(bugIDs)
% 
%             %%%% change filepath to text directories for train
%             filepath = strcat(homePath,bugIDs{i},'\train_seqs.mat');
%             train_seqs = importdata(filepath);
% 
%             [A, B, P, ll] = bw(train_seqs , AA, BB, PP);
%             hmms(i).A = A; %hmm{1,1} = A;
%             hmms(i).B = B; %hmm{1,2} = B;
%             hmms(i).P = P; %hmm{1,3} = P;
%         %     filePath = strcat(hmmPath,'hmm', bugIDs{i}, '_', num2str(N));
%         %     save(filePath, 'hmm');
%         end
%     save(strcat(hmmPath, 'hmms',num2str(N)),'hmms');
%    end

%CHANGE M WHICH IS THE NUMBER OF FUNCTION IDS.
else % For text train and test

        %%%%%%%%%%%% Uncomment if you want to use the text files as input
        %%%%%%%%%%%% Train text file
        %folderPath= 'I:\NEDA\ECLIPSE\HMM2\Train\'; %Gets Text files
        %folderPath= 'I:\NEDA\FIREFOX DATA\HMM3\3buckets\Train\'; %Gets Text files
        %folderPath= 'I:\NEDA\FIREFOX DATA\HMM\Test Run\TrainText\'; %Gets Text files
        %folderPath= 'I:\NEDA\FIREFOX DATA\HMM\Test Run\TrainText\'; %Gets Text files
        folderPath= 'I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\ConvertedToID\Train\'; %Gets Text files
        
        Folder = fullfile(folderPath);
        d = dir(Folder);
        fileNames = {d.name}';
        flag = 3; %start index of original file in "converted to ID" directory
    for N = 15 : 5 : 50; 
    % M = 11861;
    % M = 2517; %for Eclipse
    %M = 6494; %for Gnome
        %M = 9978; % For Mozilla Journal with Thread0 only
        M = 993; % For Gnome  Number of functions
        [AA, BB, PP] = init_hmm(M, N);
        hmms = []; %hmm = cell([1, 3]);
        %
        %initialize the bug_ids variable
        noHmm = length(fileNames) - flag + 1;
        bug_ids = cell([noHmm,1]);

        %initialize hmm parameter
        % N = 10; M = 10000;
        % [A, B, P] = init_hmm(M, N);

        for m = flag : length(fileNames) %starting no of hmm loop (i.e. no of unique bug_ID)

            bug_id = fileNames{m};
            bug_id = bug_id(1:end-4);%end-4
            % bug_id = bug_id(1:end);
            bug_ids{m-flag+1, 1} = bug_id;
            
            
            %%%%%%%%%% For creating Test mat files 
            filePath = strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\ConvertedToID\Test\', bug_id, '.txt');%Reads text files
            %filePath = strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\Phase2\Aut ConvertedToID\AutTest\', bug_id, '.txt');%Reads text files
            %filePath = strcat('I:\NEDA\ECLIPSE\HMM2\Test\', bug_id, '.txt');%Reads text files
            %filePath = strcat('I:\NEDA\FIREFOX DATA\HMM3\3buckets\Test\', bug_id, '.txt');%Reads text files
            %filePath = strcat('I:\NEDA\FIREFOX DATA\CrashAutomata\Test\', bug_id, '.txt');%Reads text files
            seqs = cell([1 1]); idxTrain = 1;
            fid = fopen(filePath);
            tline = fgets(fid);
            while ischar(tline)
                C = strsplit(tline);
                seq = zeros(1, 1); idxSeq = 1;
                for i = 1 : length(C)
                    num = str2num(C{i});
                    if (~isempty(num))
        %                 if(num ==  0)
        %                     num = 6494;
        %                 end
                        seq(1, idxSeq) = num;
                        idxSeq = idxSeq + 1;
                    end
                end
        %         if (idxSeq>1)
                    seqs{idxTrain, 1} = seq; idxTrain = idxTrain + 1;
        %         end
                tline = fgets(fid);
            end
            fclose(fid);

            savePath = strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\Data\', bug_id);
            %savePath = strcat('I:\NEDA\ECLIPSE\HMM2\Data\', bug_id);I:\NEDA\GNOME\HMM\Data
            %savePath = strcat('I:\NEDA\FIREFOX DATA\HMM3\3buckets\Data\', bug_id);
            %savePath = strcat('I:\NEDA\FIREFOX DATA\HMM\Data,I:\NEDA\FIREFOX DATA\HMM\Test Run\data\', bug_id);
            if (exist(savePath) == 0)
                mkdir (savePath);
            end
            saveFile = strcat(savePath,'\',bug_id);
            save(saveFile, 'seqs');


            saveFile = strcat(savePath,'\test_seqs');
            save(saveFile, 'seqs'); %train_seqs           

            
            %%%%%%%%%% end of creatig Test mat files 

            % read train text files and all traces of each bug type and split it into training and testing
            %filePath = strcat('I:\NEDA\FIREFOX DATA\CrashAutomata\Train\', bug_id, '.txt');%Reads text files
            %filePath = strcat('I:\NEDA\FIREFOX DATA\HMM3\3buckets\Train\', bug_id, '.txt');%Reads Train text files
            %filePath = strcat('I:\NEDA\ECLIPSE\HMM2\Train\', bug_id, '.txt');%Reads Train text files
            %filePath = strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\Phase2\Aut ConvertedToID\AutTrain\', bug_id, '.txt');%Reads Train text files
            filePath = strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\ConvertedToID\Train\', bug_id, '.txt');%Reads Train text files
            
            seqs = cell([1 1]); idxTrain = 1;
            fid = fopen(filePath);
            tline = fgets(fid);
            while ischar(tline)
                C = strsplit(tline);
                seq = zeros(1, 1); idxSeq = 1;
                for i = 1 : length(C)
                    num = str2num(C{i});
                    if (~isempty(num))
        %                 if(num ==  0)
        %                     num = 6494;
        %                 end
                        seq(1, idxSeq) = num;
                        idxSeq = idxSeq + 1;
                    end
                end
        %         if (idxSeq>1)
                    seqs{idxTrain, 1} = seq; idxTrain = idxTrain + 1;
        %         end
                tline = fgets(fid);
            end
            fclose(fid);

            %savePath = strcat('I:\NEDA\FIREFOX DATA\HMM\Test\', bug_id);
            %savePath = strcat('I:\NEDA\FIREFOX DATA\HMM3\3buckets\Data\', bug_id);
            %savePath = strcat('I:\NEDA\ECLIPSE\HMM2\Data\', bug_id);
            %savePath = strcat('I:\NEDA\ECLIPSE\HMM2\Data\', bug_id); I:\NEDA\GNOME\HMM\Data
            savePath = strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\Data\', bug_id); 
            if (exist(savePath) == 0)
                mkdir (savePath);
            end
            saveFile = strcat(savePath,'\',bug_id);
            save(saveFile, 'seqs'); %,'-v7.3','-append'


            saveFile = strcat(savePath,'\train_seqs');
            save(saveFile, 'seqs'); %train_seqs           

            
            [A, B, P, ll] = bw(seqs , AA, BB, PP);
            hmms(m-2).A = A; %hmm{1,1} = A;   hmms(i).A = A
            hmms(m-2).B = B; %hmm{1,2} = B;   hmms(i).B = B
            hmms(m-2).P = P; %hmm{1,3} = P;   hmms(i).P = P
    %     filePath = strcat(hmmPath,'hmm', bugIDs{i}, '_', num2str(N));
    %     save(filePath, 'hmm');
        end
    %hmmPath = 'I:\NEDA\FIREFOX DATA\HMM\HMM\'; 
    %hmmPath = 'I:\NEDA\FIREFOX DATA\HMM3\3buckets\HMM\'; 
    %hmmPath = 'I:\NEDA\ECLIPSE\HMM2\HMM\'; 
    hmmPath = 'I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\HMM\'; 
    save(strcat(hmmPath, 'hmms',num2str(N)),'hmms', '-v7.3');
    end
end     

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Up to here for using text Train
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% and Test


% close('all');
% clear;
% %% ======Load training data into a Cell Array of Vectrors======
% bugIDs = importdata('I:\NEDA\GNOME\HMM\allBugIds.mat');
% %bugIDs = importdata('C:\Users\Neda\Desktop\HMMCode
% %full\GenomeID\allBugIds.mat'); %GNOME
% %homePath = 'C:\Users\Neda\Desktop\HMMCode full\GenomeID\Pre\';
% %hmmPath = 'C:\Users\Neda\Desktop\HMMCode full\GenomeID\hmm\';
% %homePath = 'I:\NEDA\ECLIPSE\HMM\PreProcess\';
% %hmmPath = 'I:\NEDA\ECLIPSE\HMM\hmm\';
% homePath = 'I:\NEDA\GNOME\HMM\Pre\';
% hmmPath = 'I:\NEDA\GNOME\HMM\hmm\';
% 
% for N = 35 : 5 : 50; 
% % M = 11861;
% % M = 2517; %for Eclipse
% %M = 6494; %for Gnome
% M = 11861;
% [AA, BB, PP] = init_hmm(M, N);
% hmms = []; hmm = cell([1, 3]);
% for i = 1 : length(bugIDs)
%     filepath = strcat(homePath,bugIDs{i},'\train_seqs.mat');
%     train_seqs = importdata(filepath);
%     [A, B, P, ll] = bw(train_seqs , AA, BB, PP);
%     hmms(i).A = A; %hmm{1,1} = A;
%     hmms(i).B = B; %hmm{1,2} = B;
%     hmms(i).P = P; %hmm{1,3} = P;
% %     filePath = strcat(hmmPath,'hmm', bugIDs{i}, '_', num2str(N));
% %     save(filePath, 'hmm');
% end
% save(strcat(hmmPath, 'hmms',num2str(N)),'hmms', '-v7.3');
% end
