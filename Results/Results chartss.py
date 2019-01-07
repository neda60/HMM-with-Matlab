import pandas as pd
import matplotlib.pyplot as plt
import os
#import seaborn as sn
df = pd.DataFrame()
ff = pd.DataFrame()
path = r'C:\Users\Neda\Desktop\Datasets\results\Gnome'
for file in os.listdir(path):
    ff = pd.read_csv(path + '\\' + file, sep='\t')
    df[file.split('.')[0]] = ff['TPR']
    #ff[file.split('.')[0]]= f['FPR']
    #f = f.read()
df['CrashAutomata'] = (df['4_TPFP']+ df['5_TPFP'])/2
#f = pd.read_csv(r'C:\Users\Neda\Desktop\Datasets\results\HMM.txt', sep='\t')#r'C:\Users\Neda\Desktop\Datasets\results\HMM.txt'
# f = f.groupby('N').mean()['TPR'] #.max()
# #df['HMM'] = f[f['N']==30]['TPR']
# #f = f[f['N']==30]
# #print(f)
#df['HMM']=f['TPR']

#f = pd.read_csv(r'C:\Users\Neda\Desktop\Datasets\results\CrashGraphs.txt', sep='\t')#r'C:\Users\Neda\Desktop\Datasets\results\HMM.txt'
#print(f)
#df['CrashGraphs']=f['TPR']
print(df.mean())
# #print(ff.mean())



df = df[['CrashGraphs','CrashAutomata','HMM']]
ff = df.mean()
ff.plot(kind='bar')#
#colors = ['r', 'lightgreen', 'tan', 'pink']
#fig = plt.hist(ff)
bp = plt.xticks(rotation=0)
plt.savefig(r'C:\Users\Neda\Desktop\Datasets\results\g_bar.jpg')
plt.show()


boxplot = df.boxplot(column=['CrashGraphs','CrashAutomata','HMM'],notch=True, patch_artist= True)#

# for i,box in enumerate(boxplot['boxes']):
#     box.set_facecolor(colors[i])
#plt.boxplot(df.T)

# for patch, color in zip(boxplot['boxes'], colors):
#     patch.set_facecolor(color)
#bplot = sn.boxplot(x=['4_TPFP','5_TPFP','CrashGraphs','HMM'], data =df, palette="colorblind")
boxplot.axes.set_title("Comparing Recall values",
                    fontsize=16)
 
boxplot.set_xlabel("Approaches", 
                fontsize=14)
 
boxplot.set_ylabel("Recall",
                fontsize=14)
 
boxplot.tick_params(labelsize=10)
# output file name
plot_file_name=r"C:\Users\Neda\Desktop\Datasets\results\recall_comp.jpg"
 
# save as jpeg
boxplot.figure.savefig(plot_file_name,
                    format='jpeg',
                    dpi=200)
plt.show()
