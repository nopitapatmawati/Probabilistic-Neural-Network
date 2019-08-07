%Nopita Pratiwi Patmawati 1301152636 IF39-05

clc;
dataTrain = tdfread('data_train_PNN.txt');
dataTest = tdfread('data_test_PNN.txt');

train = [dataTrain.att1, dataTrain.att2, dataTrain.att3, dataTrain.label];
disp(train);
train = sortrows(train,4);
train1 = [dataTrain.att1, dataTrain.att2, dataTrain.att3, dataTrain.label];
train2 = [dataTrain.att1, dataTrain.att2, dataTrain.att3];
dt0= [train((1:46),:)];
dt1=[train((47:94),:)];
dt2 = [train((95:150),:)];

dtr0= [train2((1:46),:)];
dtr1= [train2((47:94),:)];
dtr2= [train2((95:150),:)];

test = [dataTest.att1, dataTest.att2, dataTest.att3];
disp(test);
% test(:,4)=0;
pjg0 = length(dt0);
pjg1 = length(dt1);
pjg2 = length(dt2);

% d0=0;
% for i=1:pjg0
%     current = [dt0(i,1);
%     d=[d norm(current-dt0(i,1)-(current-dt0(i,2))-(current-dt0(i,3)))];
%     end
%     d0 = d0+min(d);
% end
% 
% d1=0;
% for i=1:pjg1,
%     for j=1:3,
%         current = dataTrain(i,j);
%         d=[d norm(current-dataTrain(i,1)-(current-dataTrain(i,2))-(current-dataTrain(i,3)))];
%     end
%         d1=d1+min(d);
% end
% 
% d2=0;
% for i=1:pjg2
%     for j=1:3
%         current = dataTrain(i,j);
%         d=[d norm(current-dataTrain(i,1)-(current-dataTrain(i,2))-(current-dataTrain(i,3)))];
%     end
%     d2 = d2+min(d);
% end

% minG = 0;
% step= 0.1;
% maxG = 1;

% fungsi gaussian

sigma = 0.1;
%mencari fungsi pdf multivariate

% cross validation k=2
pers1 = [train2((1:75),:)];
pers2 = [train2((76:150),:)];

for k=1:length(pers1)
    f0(k,1)=multi(sigma, dtr0, pers1(k,:))/length(pers1);
    f1(k,1)=multi(sigma, dtr1, pers1(k,:))/length(pers1);
    f2(k,1)=multi(sigma, dtr2, pers1(k,:))/length(pers1);
end
benar=0;
for i=1:length(f0)
    if(f0(i)>f1(i))&&(f0(i)>f2(i))
        h =0;
    elseif(f1(i)>f0(i))&&(f1(i)>f2(i))
        h = 1;
    elseif(f0(i)>f1(i))&&(f0(i)>f2(i))
        h =2;
    end
%     disp(h);
    if(h==train1(i,4))
        benar=benar+1;
    end
%     disp(benar);
end
akurasi = benar/3;
disp(akurasi);
for k=76:length(pers2)
    f0=multi(sigma, dtr0, pers2(k,:));
    f1=multi(sigma, dtr1, pers2(k,:));
    f2=multi(sigma, dtr2, pers2(k,:));
end
benar=0;
cv2=train(:,4);
for i=76:length(f0)
    if(f0(i)>f1(i))&&(f0(i)>f2(i))
        h =0;
    elseif(f1(i)>f0(i))&&(f1(i)>f2(i))
        h = 1;
    elseif(f2(i)>f0(i))&&(f2(i)>f1(i))
        h = 2;
    end
    if(h==train1(i,4))
        benar=benar+1;
    end
end
% akurasi = benar/3;
% disp(akurasi);
%Testing
for k=1:length(test)
    ftes0(k,1)=multi(sigma, dtr0, test(k,:))/length(pers1);
    ftes1(k,1)=multi(sigma, dtr1, test(k,:))/length(pers1);
    ftes2(k,1)=multi(sigma, dtr2, test(k,:))/length(pers1);
end
benar=0;
for i=1:length(ftes0)
    if(ftes0(i)>ftes1(i))&&(ftes0(i)>ftes2(i))
        hasil(i,1) =0;
        jawab(i,1)=hasil(i,1);
    elseif(ftes1(i)>ftes0(i))&&(ftes1(i)>ftes2(i))
        hasil(i,1) =1;
        jawab(i,1)= hasil(i,1);
    elseif(ftes2(i)>ftes1(i))&&(ftes2(i)>ftes0(i))
        hasil(i,1)=2;
        jawab(i,1)=hasil(i,1);
    end
%     disp(h);
    if(hasil(i,1)==jawab(i,1))
        benar=benar+1;
    end
%     disp(benar);
end
fid =fopen('Jawaban.txt','w');
for i=1:length(jawab)
    fprintf(fid, '%g\t', jawab(i,1));
    fprintf(fid, '\n');
end
fclose(fid);

% for g = minG:step:maxG,
%     benar =0
% %     cross validation
%     mini0 =1;
%     maxi0 =75;
%     mini1=1;
%     maxi1 =75;
%     mini2 =1;
%     maxi2 = 75;
%     minj0 =76;
%     maxj0 =150;
%     minj1=76;
%     maxj1 =150;
%     minj2 =76;
%     maxj2 = 150;
%     for cv=1:2
%         for i0=mini0:maxi0
%             for j0=minj0:maxj0
% %                 sigma = g*d0/pjg0;
%                 g0x = exp(-((norm((dataTrain(i,1)-dataTrain(j,1))+(dataTrain(i,2)-dataTrain(j,2))+(dataTrain(i,3)-dataTrain(j,3))))^2);
%                 f0x = (-