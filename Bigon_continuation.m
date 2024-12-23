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

prob=DER_isol2ep(prob,'', @Main_Func,@Jacobian, Totle_initial, 'dx',0);%

[data, uidx] = coco_get_func_data(prob, 'DER.InIter.ep', 'data', 'uidx');
prob=coco_add_func(prob,'gamma',@ANGLE,[],'regular','gamma','uidx',xidx);

prob = coco_set(prob, 'cont', 'NPR',10 ,'PtMX', 1000,'h_min',10^-15,'h_max',0.02,'MaxRes', 0.5); 
prob = coco_set(prob,'corr', 'TOL' ,5e-5,'ItMX',50);
run=coco(prob, 'Basic_30', [], 1, {'dx','gamma'} ,[0,pi/2-0.1]);
%% Branch 1
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob=DER_BP2ep(prob,'','Basic_30',37);
prob=coco_add_func(prob,'gamma',@ANGLE,[],'regular','gamma','uidx',xidx);

prob = coco_set(prob, 'cont', 'NPR',100 ,'PtMX', 1000000,'h_min',10^-15,'h_max',0.5,'MaxRes', 20); 
prob = coco_set(prob,'corr', 'TOL' ,5e-5,'ItMX',50);
run=coco(prob, 'Branch 1_30', [], 1, {'dx' 'gamma'} ,[0,pi/2-0.1]);
%% Branch 2
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob=Bigon_DER_BP2ep(prob,'','Test5',24);
prob=coco_add_func(prob,'gamma',@ANGLE,[],'regular','gamma','uidx',xidx);

prob = coco_set(prob, 'cont', 'NPR',10 ,'PtMX', 1000000,'h_min',10^-15,'h_max',0.5,'MaxRes', 20); 
prob = coco_set(prob,'corr', 'TOL' ,5e-5,'ItMX',50);
run=coco(prob, 'Branch 2', [], 1, {'dx' 'gamma'} ,[0,pi/2-0.1]);