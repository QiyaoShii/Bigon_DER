clear all;clc
%%
global N_Seg
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

prob=DER_isol2ep(prob,'', @Main_Func,@Jacobian, Totle_initial, 'gamma',0);%

[data, uidx] = coco_get_func_data(prob, 'DER.InIter.ep', 'data', 'uidx');
prob=coco_add_func(prob,'gamma',@ANGLE,[],'regular','alpha','uidx',xidx);
prob = coco_add_event(prob, 'UZ', 'gamma', 5*pi/6/2);
prob = coco_add_event(prob, 'UZ', 'gamma', pi/6/2);

prob = coco_set(prob, 'cont', 'NPR',10 ,'PtMX', 1000,'h_min',10^-15,'h_max',0.02,'MaxRes', 0.5); 
prob = coco_set(prob,'corr', 'TOL' ,5e-5,'ItMX',50);
run=coco(prob, 'Basic_30', [], 1, {'gamma','alpha'} ,[0,pi/2-0.04]);
%% Branch 1
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob=DER_BP2ep(prob,'','Basic_30',24);
prob=coco_add_func(prob,'gamma',@ANGLE,[],'regular','alpha','uidx',xidx);
prob = coco_add_event(prob, 'UZ', 'gamma', pi/4);
prob = coco_add_event(prob, 'UZ', 'gamma', 2*pi/3);

prob = coco_set(prob, 'cont', 'NPR',100 ,'PtMX', 5000,'h_min',0.01,'h_max',0.05,'MaxRes', 2); 
prob = coco_set(prob,'corr', 'TOL' ,5e-5,'ItMX',500);
run=coco(prob, 'Branch 1_30', [], 1, {'gamma','alpha'} ,[0,pi/2-0.01]);

%% Branch 2
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob=DER_BP2ep(prob,'','Basic_30',17);
prob=coco_add_func(prob,'gamma',@ANGLE,[],'regular','alpha','uidx',xidx);
prob = coco_add_event(prob, 'UZ', 'gamma', pi/6);
prob = coco_add_event(prob, 'UZ', 'gamma', 2*pi/3);

prob = coco_set(prob, 'cont', 'NPR',100 ,'PtMX', 5000,'h_min',0.01,'h_max',0.5,'MaxRes', 2); 
prob = coco_set(prob,'corr', 'TOL' ,5e-5,'ItMX',500);
run=coco(prob, 'Branch 2_30', [], 1, {'gamma','alpha'} ,[0,pi/2-0.01]);
% %% Branch 3
% prob = coco_prob();
% prob = coco_set(prob, 'ode', 'vectorized', false);
% 
% prob=DER_BP2ep(prob,'','Basic_30',16);
% prob=coco_add_func(prob,'gamma',@ANGLE,[],'regular','alpha','uidx',xidx);
% prob = coco_add_event(prob, 'UZ', 'gamma', pi/6);
% prob = coco_add_event(prob, 'UZ', 'gamma', 2*pi/3);
% 
% prob = coco_set(prob, 'cont', 'NPR',100 ,'PtMX', 5000,'h_min',0.01,'h_max',0.5,'MaxRes', 200); 
% prob = coco_set(prob,'corr', 'TOL' ,5e-5,'ItMX',500);
% run=coco(prob, 'Branch 3_30', [], 1, {'gamma','alpha'} ,[0,pi/2-0.01]);

%% Test stability
index=7;
indices = find(real(bd_data{3, 2}{index, 15}  ) > 0);
for i=1:size(indices,1)
    bd_data{3, 2}{index, 15}(indices(i),1)
end
numComplex = numel(indices);
%%
%% test
