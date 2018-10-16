close('all');
clear;

% bugIDs = importdata('C:\Mac\Neda\PreparedData_Bug\allBugIds.mat');
% homePath = 'C:\Mac\Neda\PreparedData_Bug\';

% bugIDs = importdata('I:\NEDA\FIREFOX DATA\HMM\allBugIds.mat');
% homePath = 'I:\NEDA\FIREFOX DATA\HMM\Test\';
bugIDs = importdata('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\Phase2\allBugIds.mat');
%bugIDs = importdata('I:\NEDA\ECLIPSE\HMM2\allBugIds.mat');
%homePath = 'I:\NEDA\FIREFOX DATA\HMM\Data\';
%homePath = 'I:\NEDA\ECLIPSE\HMM2\Data\';
homePath = 'I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\Data\';
test_seqs = []; labels = []; idxTest = 1;

for i = 1 : length(bugIDs)
    labs = []; 
%    filepath = strcat(homePath,bugIDs{i},'\test_seqs.mat');    
    filepath = strcat(homePath,bugIDs{i},'\test_seqs.mat');%',bugIDs{i},'.mat'
    seqs = importdata(filepath); 
    labs(1:length(seqs),1) = i;
    if (~isempty(seqs))
        test_seqs = [test_seqs; seqs]; labels = [labels; labs];
    end
end
test_seqs1 = cell([1,1]); idx = 1;
labels1 = [];
for i = 1 : length(test_seqs)
   seq =  test_seqs{i, 1};
   if(~isempty(seq))
       test_seqs1{idx,1} = test_seqs{i,1};
       labels1(idx,1) = labels(i,1);
       idx = idx + 1;
   end
end
%save(strcat('I:\NEDA\ECLIPSE\HMM2\labels.txt'), 'labels1', '-ASCII'); % saving related lables(which trace belongs to which bucket)
save(strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\labels.txt'), 'labels1', '-ASCII'); % saving related lables(which trace belongs to which bucket)
for N = 15 : 5 : 50

%test_seqs1 = importdata('C:\Mac\Neda\NewDatasetResult\test_seqs.mat');
%labels1 = importdata('C:\Mac\Neda\NewDatasetResult\labels.mat');
% test_seqs1 = test_seqs(1:265, 1);
% test_seqs1(266:length(test_seqs)-1) = test_seqs(267:end, 1);
%hmms = importdata('C:\Users\Neda\Desktop\HMMCode full\GenomeID\hmm\hmms45.mat');

% hmms = importdata(strcat('I:\NEDA\FIREFOX DATA\HMM\HMM\hmms',num2str(N),'.mat')); 
 %hmms = importdata(strcat('I:\NEDA\ECLIPSE\HMM2\HMM\hmms',num2str(N),'.mat'));I:\NEDA\GNOME\HMM\HMM
 hmms = importdata(strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\HMM\hmms',num2str(N),'.mat'));
% bugIDs = importdata('C:\Mac\Neda\GnomePreData\allBugIds.mat');
%hmmPath = 'C:\Users\Neda\Desktop\HMMCode full\GenomeID\hmm\';
%hmmPath = 'I:\NEDA\FIREFOX DATA\HMM\HMM\';

%hmmPath = 'I:\NEDA\FIREFOX DATA\HMM\Test Run\HMM\';
%hmmPath = 'I:\NEDA\ECLIPSE\HMM2\HMM\';
hmmPath = 'I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\HMM\';

%N = 45;
scores = zeros(length(test_seqs1), length(bugIDs));

for i = 1 : numel(hmms) %length(bugIDs)  %% ADDED lenght(hmms)
%     filePath = strcat(hmmPath,'hmm', bugIDs{i}, '_', num2str(N), '.mat');
%     hmm = importdata(filePath);

    A = hmms(i).A;
    B = hmms(i).B;
    P = hmms(i).P;
    
    
    
    scores(:,i) = test_forward(test_seqs1, A, B, P);  

%     Y = test_seqs1;
%     ll = zeros(length(Y),1);
%     for j=1:length(Y)
% %    ll(i) = ffbs(Y{i},A,B,P);  
%          ll(j) = fb(Y{j},A,B,P); % slightly slower 
%    % both fb or ffbs take care of the true length and gives the ll of each seq
%    % per symbol.
%     end

end


%save('C:\Users\Neda\Desktop\HMMCode full\GenomeID\Result\scores_hmm45', 'scores');
%save(strcat('I:\NEDA\FIREFOX DATA\HMM\Result\scores_hmm',num2str(N)),'scores');
%save(strcat('I:\NEDA\ECLIPSE\HMM2\Result\scores_hmm',num2str(N)),'scores');
%save(strcat('I:\NEDA\ECLIPSE\HMM2\Result\scores_hmm',num2str(N),'.txt'), 'scores', '-ASCII');
save(strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\Result\scores_hmm',num2str(N)),'scores');
save(strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\Result\scores_hmm',num2str(N),'.txt'), 'scores', '-ASCII');


% rsave('C:\Mac\Neda\NewDatasetResult\test_seqs', 'test_seqs1');
% save('C:\Mac\Neda\NewDatasetResult\labels', 'labels1');
scores = scores';

%% computing rr based on ranking
% scores = importdata('C:\Mac\Neda\GnomeResults\scores.mat');
stage = 1; galIDs = 1:length(bugIDs);
galIDs = galIDs'; recog = zeros(length(bugIDs),1);
for i = 1 : length(labels1)
    scrInd = scores(:, i);
    pID = labels1(i);
    minrcog = rank_bugs(stage,scrInd,galIDs,pID);
    recog = recog + minrcog;
end
recog = recog./ length(labels1);
%save(strcat('I:\NEDA\FIREFOX DATA\HMM\Result\recog_',num2str(N)), 'recog');

%save(strcat('I:\NEDA\ECLIPSE\HMM2\Result\recog_',num2str(N)), 'recog');
%save(strcat('I:\NEDA\ECLIPSE\HMM2\Result\recog_',num2str(N),'.txt'), 'recog','-ASCII');
save(strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\Result\recog_',num2str(N)), 'recog');
save(strcat('I:\NEDA\FIREFOX DATA\HMM3\AutHMM\HMM\Result\recog_',num2str(N),'.txt'), 'recog','-ASCII');
[minVals, I] = min(scores);
I = I';
tp = (I == labels1);
tp = sum(tp);

rr = tp/length(labels1);

end



