function imgOutput=locationUnExchange(imgInput,based)
[rows,clos]=size(imgInput);
imgOutput=imgInput;
sequence=GetHalton(rows+clos,based);
%�л���
seqClos=sequence(rows+1:end,1);
[~,sortOrder]=sort(seqClos);
[~,sortOrder]=sort(sortOrder);
%���ܣ�����sortOrder(i)�а��Ƶ���i��
for i=1:clos
    imgOutput(:,i)=imgInput(:,sortOrder(i));
end

imgTemp=imgOutput;

%�л���
%���ܣ�����sortOrder(i)�а��Ƶ���i��
seqRows=sequence(1:rows,1);
[~,sortOrder]=sort(seqRows);
[~,sortOrder]=sort(sortOrder);
for i=1:rows
    imgOutput(i,:)=imgTemp(sortOrder(i),:);
end