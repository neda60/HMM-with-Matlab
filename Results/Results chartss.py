import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
import os


# rank = range(1,21) #[1,2,3,4,5,6,7,8,9,10]
# df = pd.DataFrame(index=range(15,51,5))#, columns=['N']
# df = df.rename_axis("N")
#df.reset_index(inplace = True)
#measure = ['TPR', 'TPR', 'FN','Pre','Rec','Acc','F-measure']
m = 'TPR'
#for m in measure:
ff = pd.DataFrame()
path = r'C:\Users\Neda\Desktop\Datasets\results\Gnome' #C:\Users\Neda\Desktop\Datasets\results\firefox
for file in os.listdir(path):
    df = pd.read_csv(path + '\\' + file, sep='\t')
    df['Approach']= file.split('.')[0]
    df = df[['Approach',m]]
    #print(df)
    ff=ff.append(df)
    # #df1.fillna(0, inplace=True)
    # #df1['F-measure'] = 2*((df1['Pre']*df1['Rec'])/(df1['Pre']+df1['Rec']))
    # #v = df1.groupby(['N'])[m].sum().reset_index()/1232# 2350 for Firefox and 1232 Gnome
    # #print(v)
print(ff)
ax = sns.boxplot(x=ff['Approach'], y=ff[m] ,notch=True)#
ax.set_title('Recall comparison')
ax.set_ylabel('Recall')
    # #sns.violinplot(x=df1['N'], y=df1[m]).figure.show()
ax.figure.show()
plot_file_name=r"C:\Users\Neda\Desktop\Datasets\results\G2recall_comp.jpg"
ax.figure.savefig(plot_file_name, format='jpeg', dpi=200)

#  import pandas as pd
# import matplotlib.pyplot as plt
# import os
# #import seaboread_csv
# df = pd.DataFrame()
# ff = pd.DataFrame()
# path = r'C:\Users\Neda\Desktop\Datasets\results\firefox' #C:\Users\Neda\Desktop\Datasets\results\Gnome
# for file in os.listdir(path):
#     ff = pd.read_csv(path + '\\' + file, sep='\t')
#     df[file.split('.')[0]] = ff['TPR']
#     #ff[file.split('.')[0]]= f['FPR']
#     #f = f.read()
# #JUST FOR GNOME df['CrashAutomata'] = (df['4_TPFP']+ df['5_TPFP'])/2
# #f = pd.read_csv(r'C:\Users\Neda\Desktop\Datasets\results\HMM.txt', sep='\t')#r'C:\Users\Neda\Desktop\Datasets\results\HMM.txt'
# # f = f.groupby('N').mean()['TPR'] #.max()
# # #df['HMM'] = f[f['N']==30]['TPR']
# # #f = f[f['N']==30]
# # #print(f)
# #df['HMM']=f['TPR']

# #f = pd.read_csv(r'C:\Users\Neda\Desktop\Datasets\results\CrashGraphs.txt', sep='\t')#r'C:\Users\Neda\Desktop\Datasets\results\HMM.txt'
# #print(f)
# #df['CrashGraphs']=f['TPR']
# print(df.mean())
# # #print(ff.mean())



# df = df[['CrashGraphs','CrashAutomata','HMM']]
# ff = df.mean()
# ff.plot(kind='bar')#
# #colors = ['r', 'lightgreen', 'tan', 'pink']
# #fig = plt.hist(ff)
# bp = plt.xticks(rotation=0)
# plt.savefig(r'C:\Users\Neda\Desktop\Datasets\results\f1_bar.jpg')
# plt.show()


# boxplot = df.boxplot(column=['CrashGraphs','CrashAutomata','HMM'],notch=True, patch_artist= True)#

# # for i,box in enumerate(boxplot['boxes']):
# #     box.set_facecolor(colors[i])
# #plt.boxplot(df.T)

# # for patch, color in zip(boxplot['boxes'], colors):
# #     patch.set_facecolor(color)
# #bplot = sn.boxplot(x=['4_TPFP','5_TPFP','CrashGraphs','HMM'], data =df, palette="colorblind")
# boxplot.axes.set_title("Comparing Recall values",
#                     fontsize=16)
 
# boxplot.set_xlabel("Approaches", 
#                 fontsize=14)
 
# boxplot.set_ylabel("Recall",
#                 fontsize=14)
 
# boxplot.tick_params(labelsize=10)
# # output file name
# plot_file_name=r"C:\Users\Neda\Desktop\Datasets\results\F1recall_comp.jpg"
 
# # save as jpeg
# boxplot.figure.savefig(plot_file_name,
#                     format='jpeg',
#                     dpi=200)
# plt.show() 
