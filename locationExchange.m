function imgOutput=locationExchange(imgInput,based)
[rows,clos]=size(imgInput);
imgOutput=imgInput;
sequence=GetHalton(rows+clos,based);
%�л���
seqRows=sequence(1:rows,1);
[~,sortOrder]=sort(seqRows);
[~,sortOrder]=sort(sortOrder);
%���ܣ�����i�а��Ƶ���sortOrder(i)��
for i=1:rows
    imgOutput(sortOrder(i),:)=imgInput(i,:);
end

imgTemp=imgOutput;

%�л���
%���ܣ�����i�а��Ƶ���sortOrder(i)��
seqClos=sequence(rows+1:end,1);
[~,sortOrder]=sort(seqClos);
[~,sortOrder]=sort(sortOrder);
for i=1:clos
    imgOutput(:,sortOrder(i))=imgTemp(:,i);
end