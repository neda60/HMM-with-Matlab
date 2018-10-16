close('all');
clear;
%% ======Load training data into a Cell Array of Vectrors======
% bugIDs = importdata('C:\Mac\Neda\PreparedData_Bug\allBugIds.mat');


tic;
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

        %mainPath = 'I:\NEDA\GNOME\5 dup buckets\'
        %mainPath = 'I:\NEDA\GNOME\HMMJ with unique traces\Gnome 182\';
        mainPath = 'I:\NEDA\FIREFOX DATA\HMM_J\HMMJ 124 stacks\';
        %mainPath = ' I:\NEDA\GNOME\HMMJ with unique traces\';
        %mainPath = ' I:\NEDA\FIREFOX DATA\HMM_J\';

        %mainPath = 'I:\NEDA\ECLIPSE\HMMJ\';
        %mainPath = 'I:\NEDA\GNOME\HMMJ\';
        %%%%%%%%%%%% Uncomment if you want to use the text files as input
        %%%%%%%%%%%% Train text file
        %folderPath= 'I:\NEDA\ECLIPSE\HMM2\Train\'; %Gets Text files
        folderPath= strcat(mainPath , 'Train\');%I:\NEDA\FIREFOX DATA\HMM_J\Train\'; %Gets Text files
        %folderPath= 'I:\NEDA\FIREFOX DATA\HMM\Test Run\TrainText\'; %Gets Text files
        %folderPath= 'I:\NEDA\FIREFOX DATA\HMM\Test Run\TrainText\'; %Gets Text files
        %folderPath= 'I:\NEDA\GNOME\Train\'; %Gets Text files
        
        Folder = fullfile(folderPath);
        d = dir(Folder);
        fileNames = {d.name}';
        flag = 3; %start index of original file in "converted to ID" directory
        
    for N = 15 : 5 : 50; 
    % M = 11861;
    % M = 2517; %for Eclipseallbug
    
    %M = 6494; %for Gnome ,  Number of functions
        %M = 9978; % For Mozilla Journal with Thread0 only
        %M = 6073; % For Gnome
        %M = 1163; %firefox 5 buckets
        %M = 633; %GNOME 6 buckets
        %M = 514; %Eclipse 5 buckets
        %M=520; %Gnome 5b unique traces
        %M= 4019; % Gnome 182 unique buckets
        M= 7355; % Firefox 124 buckets I:\NEDA\FIREFOX DATA\HMM_J\HMMJ stacks more than 4
%         M= 2548; % Eclipse 35 unique stacks
        [AA, BB, PP] = init_hmm(M, N);
        hmms = []; %hmm = cell([1, 3]);
        
        %
        %initialize the bug_ids variable
        noHmm = length(fileNames) - flag + 1;
        bug_ids = cell([noHmm,1]);
        med = zeros(length(bug_ids),1);% keeps median for scores of each bucket
        %initialize hmm parameter
        % N = 10; M = 10000;
        % [A, B, P] = init_hmm(M, N);

        for m = flag : length(fileNames) %starting no of hmm loop (i.e. no of unique bug_ID)

            bug_id = fileNames{m};
            bug_id = bug_id(1:end-4);%end-4
            % bug_id = bug_id(1:end);
            bug_ids{m-flag+1, 1} = bug_id;
            
            
            %%%%%%%%%% For creating Test mat files 
            %filePath = strcat('I:\NEDA\GNOME\Test\', bug_id, '.txt');%Reads text files
            %filePath = strcat('I:\NEDA\ECLIPSE\HMM2\Test\', bug_id, '.txt');%Reads text files
            filePath = strcat(mainPath , 'Test\', bug_id, '.txt');%strcat('I:\NEDA\FIREFOX DATA\HMM_J\Test\', bug_id, '.txt');%Reads text files
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

            %savePath = strcat('I:\NEDA\GNOME\HMM\Data\', bug_id);
            %savePath = strcat('I:\NEDA\ECLIPSE\HMM2\Data\', bug_id);I:\NEDA\GNOME\HMM\Data
            savePath = strcat(mainPath , 'Data\', bug_id); % strcat('I:\NEDA\FIREFOX DATA\HMM_J\Data\', bug_id);
            %savePath = strcat('I:\NEDA\FIREFOX DATA\HMM\Data,I:\NEDA\FIREFOX DATA\HMM\Test Run\data\', bug_id);
            if (exist(savePath) == 0)
                mkdir (savePath);
            end
            saveFile = strcat(savePath,'\',bug_id);
            save(saveFile, 'seqs');


            saveFile = strcat(savePath,'\test_seqs');
            save(saveFile, 'seqs'); %test_seqs           

            
            %%%%%%%%%% end of creatig Test mat files 

             
             %%%%%% Start creating Training set
            % read train text files and all traces of each bug type and split it into training and testing
            %filePath = strcat('I:\NEDA\FIREFOX DATA\CrashAutomata\Train\', bug_id, '.txt');%Reads text files
            filePath = strcat(mainPath , 'Train\', bug_id, '.txt'); %strcat('I:\NEDA\FIREFOX DATA\HMM_J\Train\', bug_id, '.txt');%Reads Train text files
            %filePath = strcat('I:\NEDA\ECLIPSE\HMM2\Train\', bug_id, '.txt');%Reads Train text files
            %filePath = strcat('I:\NEDA\GNOME\Train\', bug_id, '.txt');%Reads Train text files
            
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
            savePath = strcat(mainPath ,'Data\', bug_id); % strcat('I:\NEDA\FIREFOX DATA\HMM_J\Data\', bug_id);
            %savePath = strcat('I:\NEDA\ECLIPSE\HMM2\Data\', bug_id);
            %savePath = strcat('I:\NEDA\ECLIPSE\HMM2\Data\', bug_id); I:\NEDA\GNOME\HMM\Data
            %savePath = strcat('I:\NEDA\GNOME\HMM\Data\', bug_id); 
            if (exist(savePath) == 0)
                mkdir (savePath);
            end
            saveFile = strcat(savePath,'\',bug_id);
            save(saveFile, 'seqs'); %,'-v7.3','-append'


            saveFile = strcat(savePath,'\train_seqs');
            save(saveFile, 'seqs'); %train_seqs           
            %%%%%%% End of creating Training set
            
            
            
                           %%%%%%%%%%%%%%%%%% Converting Validation set to mat
    %%%%%%%%%%%%%%%%%%%%%%%%%%
            filePath = strcat(mainPath , 'Validation\', bug_id, '.txt'); %strcat('I:\NEDA\FIREFOX DATA\HMM_J\Validation\', bug_id, '.txt');%Reads Validation text files
         
            vals = cell([1 1]); idxTrain = 1;
            fid = fopen(filePath);
            tline = fgets(fid);
            while ischar(tline)
                C = strsplit(tline);
                val = zeros(1, 1); idxSeq = 1;
                for i = 1 : length(C)
                    num = str2num(C{i});
                    if (~isempty(num))
                        val(1, idxSeq) = num;
                        idxSeq = idxSeq + 1;
                    end
                end
        %         if (idxSeq>1)
                    vals{idxTrain, 1} = val; idxTrain = idxTrain + 1;
        %         end
                tline = fgets(fid);
            end
            fclose(fid);
            
            savePath = strcat(mainPath , 'Data\', bug_id);% strcat('I:\NEDA\FIREFOX DATA\HMM_J\Data\', bug_id);
            if (exist(savePath) == 0)
                mkdir (savePath);
            end
            saveFile = strcat(savePath,'\',bug_id);
            save(saveFile, 'vals'); %,'-v7.3','-append'


            saveFile = strcat(savePath,'\val_seqs');
            save(saveFile, 'vals'); %validation_seqs    

             %%%%%%%%%%% End of creating validation set

            bestMean = 100000;
             for c= 1:10
            [A, B, P, ll] = bw(seqs , AA, BB, PP);
            %[A1, B1, P1, ll1] = bw(vals , A, B, P);
            
            %%%%%%%%%%%%%%%%% CHecking for the best Log Likelyhood
            
            %logl1 = loglik(seqs , A, B, P);
            scores = test_forward(vals , A, B, P);
            %avg = mean (logl2)
            avg = mean(scores)
                if (avg < bestMean)
                   TempA = A;
                   TempB = B;
                   TempP = P;
                   bestMean = avg
                   med(str2num(bug_id),1) = median(scores);
                   
                end
            
            [AA, BB, PP] = init_hmm(M, N);
            
             end
            
            A = TempA;
            B = TempB;
            P = TempP;
            
            %%%%%%%%%% End of checking

           
            
            
            hmms(m-2).A = A; %hmm{1,1} = A;   hmms(i).A = A
            hmms(m-2).B = B; %hmm{1,2} = B;   hmms(i).B = B
            hmms(m-2).P = P; %hmm{1,3} = P;   hmms(i).P = P
            
            
            
            %calculate f_measure for 10 times' if bigger update the parameters: 
    %     filePath = strcat(hmmPath,'hmm', bugIDs{i}, '_', num2str(N));
    %     save(filePath, 'hmm');
          end
            %savePath = strcat('I:\NEDA\FIREFOX DATA\HMM_J\Medians\', bug_id);
        save(strcat(mainPath ,'\medians'), 'med'); %,'-v7.3','-append'I:\NEDA\FIREFOX DATA\HMM_J\Medians
        save(strcat(mainPath ,'\Result\medians.txt'), 'med','-ASCII');

    %hmmPath = 'I:\NEDA\FIREFOX DATA\HMM\HMM\'; 
    hmmPath = strcat(mainPath ,'HMM\'); 
    %hmmPath = 'I:\NEDA\ECLIPSE\HMM2\HMM\'; 
    %hmmPath = 'I:\NEDA\GNOME\HMM\HMM\'; 
    save(strcat(hmmPath, 'hmms',num2str(N)),'hmms', '-v7.3');
    end
end     

exeTime= toc;
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
