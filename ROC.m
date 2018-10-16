% % ROC curve in Matlab
% % https://stackoverflow.com/questions/33523931/matlab-generate-confusion-matrix-from-classifier/33542453#33542453
% 
% % tot_op = testZ;
% % targets = testY;
% % th_vals= sort(tot_op);
% % 
% % for i = 1:length(th_vals)
% %   b_pred = (tot_op>=th_vals(i,1));
% %   TP = sum(b_pred == 1 & targets == 2);
% %   FP = sum(b_pred == 1 & targets == 1);
% %   TN = sum(b_pred == 0 & targets == 1);
% %   FN = sum(b_pred == 0 & targets == 2);
% %   sens(i) = TP/(TP+FN);
% %   spec(i) = TN/(TN+FP);
% % end
% 
% TP = [0,1, 0.1, 0.5, 0.2, 0.8, 0.3];
% FP = [0,1, 0.9, 0.4, 0.5, 0.1, 0.7];
% 
% sens = sort(TP);
% cspec = sort(FP);
% 
% 
% 
% figure(2);
% % cspec = 1-spec;
% % cspec = cspec(end:-1:1);
% % sens = sens(end:-1:1);
% plot(cspec,sens,'k');
% 
% AUC = sum(0.5*(sens(2:end)+sens(1:end-1)).*(cspec(2:end) - cspec(1:end-1)));
% fprintf('\nAUC: %g \n',AUC);

%=======================
% import pandas as pd
% import numpy as np
% import pylab as pl
% from sklearn.metrics import roc_curve, auc
% 
% df = pd.read_csv('filename.csv')
% 
% y_test = np.array(df)[:,0]
% probas = np.array(df)[:,1]
% 
% # Compute ROC curve and area the curve
% fpr, tpr, thresholds = roc_curve(y_test, probas)
% roc_auc = auc(fpr, tpr)
% print("Area under the ROC curve : %f" % roc_auc)
% 
% # Plot ROC curve
% pl.clf()
% pl.plot(fpr, tpr, label='ROC curve (area = %0.2f)' % roc_auc)
% pl.plot([0, 1], [0, 1], 'k--')
% pl.xlim([0.0, 1.0])
% pl.ylim([0.0, 1.0])
% pl.xlabel('False Positive Rate')
% pl.ylabel('True Positive Rate')
% pl.title('Receiver operating characteristic')
% pl.legend(loc="lower right")
% pl.show()
% 
% 








%=========================================

%folderPath = 'I:\NEDA\HMM2\scores\TPFP\';
folderPath = 'I:\NEDA\FIREFOX DATA\HMM2\scores\TPFP\TPFP';
Folder = fullfile(folderPath);
d = dir(Folder);
fileNames = {d.name}';

        for m = 3 : 5%length(fileNames) %starting no of hmm loop (i.e. no of unique bug_ID)

            thresh=1;
            fname = fileNames{m}(1:end-4);         
            tp = cell([1 1]); 
            fid = fopen(strcat(folderPath, fname, '.txt'));
            tline = fgets(fid);          
            while true 
% 
%                 if(thresh > 9)
%                  
%                     thresh = 1;
%                 end
                for it = 1 : 9
                C = strsplit(tline);
                tp = zeros(1, 1); idxSeq = 1;
                label= C{1};              
                for i = 2 : length(C)-1 % First elemnt is the operator and last element is empty so we omit them
                    num = str2double(C{i});
                    if (~isempty(num))
                        tp(1, idxSeq) = num;
                        idxSeq = idxSeq + 1;
                    end
                end
        %         if (idxSeq>1)
                    %seqs{idxTrain, 1} = tp; idxTrain = idxTrain + 1;
        %         end                
            %For fp
                tline = fgets(fid);
                C = strsplit(tline);
                fp = zeros(1, 1); idxSeq = 1;
                for i = 2 : length(C)-1
                    num = str2double(C{i});
                    if (~isempty(num))
                        fp(1, idxSeq) = num;
                        idxSeq = idxSeq + 1;
                    end
                end
                
                tline = fgets(fid);
                %thresh = thresh+1; 
                end

                myPlot = zeros(length(fp), length(tp));
                for i = 1 : length(fp)
                        myPlot(i , 1) = fp (1, i);
                        myPlot(i , 2) = tp(1,i);
                end
                sortrows(myPlot , 1);
                
                %legend(plot(fp,tp),label); %, 'red', thresh);
                legend(plot(myPlot(:,1),myPlot(:,2)),label); %, 'red', thresh);
                xlabel('False positive rate')
                ylabel('True positive rate')
                title('ROC for HMM combinations')
                Int = trapz(fp, tp);
                disp(Int);
                hold on
                
                
                if(~ischar(tline)) 
                    break;
                end               
             end
            
                            

            fclose(fid);
            
            
        end