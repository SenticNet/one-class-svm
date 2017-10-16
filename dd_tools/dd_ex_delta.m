% DD_EX1
%
% Example of the creation of a One-Class problem, and the solutions
% obtained by the Nearest Neighbor Data Description and the Support
% Vector Data Description. Furthermore, the ROC curve is plotted and
% the AUC-error and F1-performance is computed.

% Copyright: D.M.J. Tax, D.M.J.Tax@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

% % generate normal classification problem: train data:
% a = gendatb([30 30]);
% % make the second class the target class and change the labels:
% a = oc_set(a,'1');
% % only use target class:
% a = target_class(a);
% % generate test data:
% b = oc_set(gendatb(200),'1');

figure; clf;hold on;

Files=dir('../data/*.mat');
for k=1:length(Files)
    
FileNames=Files(k).name
fname= sprintf('..\\data\\%s',FileNames)
load(fname);

%load('..\data\data1_bearing2.mat');

data=feature(1:200,:);
labels=[ones(200,1)*2];
data_pr = prdataset(data,labels); %% Convert into 'prmapping' format 
a=oc_set(data_pr,'2'); %% Set label '2' as one-class dataset 

data=[feature(201:400,:);feature(end-99:end,:)];
labels=[ones(200,1)*2;ones(100,1)];
data_pr = prdataset(data,labels); %% Convert into 'prmapping' format 
b=oc_set(data_pr,'2'); %% Set label '2' as one-class dataset 


% first show a 2D plot:
% figure(1); clf; hold on; H = [0;0];
% h = scatterd(a);
% V = axis; axis(1.5*V);

% train the individual data descriptions and plot them
% the error on the target class:
fracrej = 0.2;
% train the svdd:
w2 = svdd(a,fracrej,5);
% and also plot this:
% h = plotc(w2,'r--');
% H(2) = h(1);
% legend(H,'NNdd','SVDD');
% axis equal;
% axis image;

% second show the ROC curves:
H=[0];
% the ROC for the SVDD:
e2 = dd_roc(b,w2);
% also plot this:
h = plotroc(e2,'r--'); H(1) = h(1);
% and compute the area under the ROC:
auc_svdd = dd_auc(e2)
% and the f1 measure:
f1_svdd = b*w2*dd_f1

fmea(k)=f1_svdd;
auc(k)=auc_svdd;

%legend(H,'SVDD');

end

fmea_mean = mean(fmea)
fmea_std = std(fmea)

auc_mean = mean(auc)
auc_std = std(auc)



