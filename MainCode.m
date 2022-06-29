clear;
close all;
clc;
setDir  = fullfile('Signature-Dataset');
imds = imageDatastore(setDir,'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
[trainingSet,testSet] = splitEachLabel(imds,0.8,'randomize');
X_train = dataSetFeatures_extract_function(trainingSet);
X_test = dataSetFeatures_extract_function(testSet);
y_train = grp2idx(trainingSet.Labels);
y_test = grp2idx(testSet.Labels);
load x_test.mat;
load y_test.mat;
X_train_w_best_feature = X_train(:,:);

%Md1 = fitcecoc(X_train_w_best_feature,y_train); 
load matlab.mat
X_test_w_best_feature = X_test(:,:);
pred = predict(Md1,X_test_w_best_feature);
pred

test_accuracy_for_iter = sum((predict(Md1,X_test_w_best_feature) == y_test))/length(y_test)*100


