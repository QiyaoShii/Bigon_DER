clear all;clc
%%
global N_Seg   NC
global rho Y EA GJ EI1 EI2
global Segments Joints
Totle_initial=Initialization_bigon();
%% Get the index of monitor parameter

Left_End_idx=[1:4*N_Seg,4*N_Seg+5:4*N_Seg+11];
Right_End_idx = [1:7,12:11+4*N_Seg];

Seg_idx = cell(2,1);

Seg_idx{1} = Left_End_idx';
Seg_idx{2} = Right_End_idx' + Seg_idx{1}(end)-11;

Joint_idx{1}  = (1:11)'+Seg_idx{2}(1)-1;

xidx=Seg_idx{1}(end-7+1)-7:Seg_idx{1}(end-7+3)-7;

%% continuation
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob=DER_isol2ep(prob,'', @Main_Func,@Jacobian, Totle_initial, 'dx',0);%

[data, uidx] = coco_get_func_data(prob, 'DER.InIter.ep', 'data', 'uidx');
prob=coco_add_func(prob,'gamma',@ANGLE,[],'regular','gamma','uidx',xidx);

prob = coco_set(prob, 'cont', 'NPR',10 ,'PtMX', 1000000,'h_min',10^-15,'h_max',0.02,'MaxRes', 0.5); 
prob = coco_set(prob,'corr', 'TOL' ,5e-5,'ItMX',50);
run=coco(prob, 'Test5', [], 1, {'dx','gamma'} ,[0,pi/2-0.1]);
%% BP1
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob=DER_BP2ep(prob,'','Test5',65);

prob=coco_add_func(prob,'gamma',@ANGLE,[],'regular','gamma','uidx',xidx);

prob = coco_set(prob, 'cont', 'NPR',10 ,'PtMX', 1000000,'h_min',10^-15,'h_max',0.5,'MaxRes', 20); 
prob = coco_set(prob,'corr', 'TOL' ,5e-5,'ItMX',50);
run=coco(prob, 'B1', [], 1, {'dx' 'gamma'} ,[0,pi/2-0.1]);
%%
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob=Bigon_DER_BP2ep(prob,'','Test5',24);
% prob=Bigon_DER_BPl2ep(prob,'', @Bigon_Main_Func, @Bigon_Jacobian_srptin, Totle_initial, 'dx',0);%@Bigon_Jacobian_srptin, 

%prob = coco_add_pars(prob, 'pars',Seg_idx{5,1}(end-5,1),  'S5end_dy' , 'active' );,'MaxRes', 500

prob = coco_set(prob, 'cont', 'NPR',10 ,'PtMX', 1000000,'h_min',10^-15,'h_max',0.5,'MaxRes', 20); 
prob = coco_set(prob,'corr', 'TOL' ,5e-5,'ItMX',50);
run=coco(prob, 'Test6', [], 1, {'dx'} ,[0,pi/2-0.1]);
%% test
clear all
sol5=coco_read_solution('Test6',37);
DOF1=sol5{3,2}.Segments{1,1}.DOF;
DOF2=sol5{3,2}.Segments{1,2}.DOF;
% plot3(DOF1(1:4:4*N_Seg-1),DOF1(2:4:4*N_Seg-1),DOF1(3:4:4*N_Seg-1))

i = 1;
for j = 1: (size(sol5{3,2}.Segments{i}.DOF,1)+1)/4-1
sol5{3,2}.Segments{i}.Nodes(j,1) = sol5{3,2}.Segments{i}.DOF(4*(j-1)+1);
sol5{3,2}.Segments{i}.Nodes(j,2) = sol5{3,2}.Segments{i}.DOF(4*(j-1)+2);
sol5{3,2}.Segments{i}.Nodes(j,3) = sol5{3,2}.Segments{i}.DOF(4*(j-1)+3);
end

for j = 1:size(sol5{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol5{3,2}.Segments{i}.Nodes(j,1) +k.*1/250.*sol5{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol5{3,2}.Segments{i}.Nodes(j,2) +k.*1/250.*sol5{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol5{3,2}.Segments{i}.Nodes(j,3) +k.*1/250.*sol5{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor','b','EdgeColor','none');hold on


i=2;

for j = 2: (size(sol5{3,2}.Segments{i}.DOF,1)+1)/4
sol5{3,2}.Segments{i}.Nodes(j,1) = sol5{3,2}.Segments{i}.DOF(4*(j-1)+1);
sol5{3,2}.Segments{i}.Nodes(j,2) = sol5{3,2}.Segments{i}.DOF(4*(j-1)+2);
sol5{3,2}.Segments{i}.Nodes(j,3) = sol5{3,2}.Segments{i}.DOF(4*(j-1)+3);
end


for j = 2:size(sol5{3,2}.Segments{i}.Nodes,1)
    for k=-4:1:4
        Rx(j-1,k+5)=sol5{3,2}.Segments{i}.Nodes(j,1) +k.*1/250.*sol5{3,2}.Segments{i}.m1(j-1,1);
        Ry(j-1,k+5)=sol5{3,2}.Segments{i}.Nodes(j,2) +k.*1/250.*sol5{3,2}.Segments{i}.m1(j-1,2);
        Rz(j-1,k+5)=sol5{3,2}.Segments{i}.Nodes(j,3) +k.*1/250.*sol5{3,2}.Segments{i}.m1(j-1,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor','b','EdgeColor','none');hold on

axis equal
hold on
% plot3(DOF2(5:4:4*N_Seg+3),DOF2(6:4:4*N_Seg+3),DOF2(7:4:4*N_Seg+3))
% axis equal
% % view([0,1,0])