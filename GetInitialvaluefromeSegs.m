function X0 = GetInitialvaluefromeSegs(N_Seg,DOF)

% the index of each segmens DOF in global DOF 
    Left_End_idx=[1:4*N_Seg,4*N_Seg+5:4*N_Seg+11];
    Right_End_idx = [1:7,12:11+4*N_Seg];

    Seg_idx = cell(2,1);

    Seg_idx{1} = Left_End_idx';
    Seg_idx{2} = Right_End_idx' + Seg_idx{1}(end)-11;
   
   buffer_X0 = zeros(2*(4*(N_Seg+1+1)-1)-3,2);
   X0 = zeros(2*(4*(N_Seg+1+1)-1)-3,1);   

DOF{2}(5:7,1) = 0;

for j=1:1:2
    for i=1:size(DOF{j},1)
        buffer_X0(Seg_idx{j}(i,1),j) = DOF{j}(i,1);
    end
    
    X0 = X0 + buffer_X0(:,j);
end


end