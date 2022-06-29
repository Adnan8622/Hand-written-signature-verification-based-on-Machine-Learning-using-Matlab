clear all
close all
clc

imds = imageDatastore('F:\My Library\Research Work\My work\Hand written signature verification\Signature-Dataset','IncludeSubfolders',true,'LabelSource','foldernames');

tbl = countEachLabel(imds)

% figure
%montage(imds.Files(1:20:end))

[training, validation] = splitEachLabel(imds, 0.8, 'randomize');

train_labels = training.Labels;
train_Data = training.Files;

test_labels = validation.Labels;
test_Data = validation.Files;

 for i = 1:length(train_Data)
     img1 = imread(train_Data{i});
     %imshow(img2)
     img1=imresize(img1,[128,128],'bicubic');
     %seg1 = Segmentation(img1);
     %train=i
     %cch_feat_train(i,:) = color_features_CCH(img1);
     Hog_train(i,:) = extractHOGFeatures(img1,'CellSize',[16 16]);
    % Hog_train2(i,:) = extractHOGFeatures(seg1,'CellSize',[16 16]);
     lbp_feat_train(i,:) = extractLBPFeatures(rgb2gray(img1));     
     
     %Hog_train3(i,:) = ccprops(seg1);
     

 end
 
 for j = 1 : length(test_Data)
     %test=j
     img2 = imread(test_Data{j});
     
      img2=imresize(img2,[128,128],'bicubic');
     %seg2 = Segmentation(img2);
     
     %cch_feat_test(j,:) = color_features_CCH(img2);
     Hog_test(j,:) = extractHOGFeatures(img2,'CellSize',[16 16]);
     %Hog_test2(j,:) = extractHOGFeatures(seg2,'CellSize',[16 16]);
     lbp_feat_test(j,:) = extractLBPFeatures(rgb2gray(img2));
     %Hog_test3(j,:) = ccprops(seg2);
     
 end
 train_feat = [lbp_feat_train,Hog_train];
 test_feat = [lbp_feat_test,Hog_test];

train=fitcecoc(train_feat,train_labels); %% SVM Training
%save('model.mat')
 test=predict(train,test_feat);
 
 
 test
 
 [confMat,order] = confusionmat(test_labels,test);
 confMat
 plotconfusion()
 for i=1:size(confMat)
     recall(i) = confMat(i,i)/sum(confMat(i,:));
     precision(i) = confMat(i,i)/sum(confMat(:,i));
 end
 Recall=sum(recall)/size(confMat,1)
 Precision = sum(precision)/size(confMat,1)
 

 Accuracy = sum(confMat(1,1)+confMat(2,2)+confMat(3,3)+confMat(4,4)+confMat(5,5)+confMat(6,6)+confMat(7,7)+confMat(8,8)+confMat(9,9)+confMat(10,10))/length(test_labels)*100




