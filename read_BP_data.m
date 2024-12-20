function [bd,BP,Mo,Num_BP,numPositiveElements] = read_BP_data(input1)
%   read bd.mat file and some useful information
%   Detailed explanation goes here
j=0;
bd = coco_bd_read(input1);
Num_bd=size(bd);
for i=1:1:Num_bd(1)
    k=bd{i,7};
    if isequal(k ,'BP')
     j=j+1;
     BP(j)=bd{i,8};
     Mo(j)=bd{i,12};
     positiveElements = real(bd{i-1,15}) > 0;
     numPositiveElements(j) = sum(positiveElements(:));
     Num_BP(j)=i;
    end
end
if  j==0

    Num_BP=Num_bd(1);
    Mo='none'
    BP='none';
    
else
     positiveElements = real(bd{end,15}) > 0;
     numPositiveElements(j+1) = sum(positiveElements(:));
     Num_BP=[Num_BP,Num_bd(1)];

end

end