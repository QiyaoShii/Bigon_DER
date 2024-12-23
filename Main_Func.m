function F = Main_Func(X,p)

global N_Seg 
global Segments Joints
global Buffer
global EA EI1 EI2 GJ
global Totle_Mass
%% Initialization
Length=size(X,1);x=X(1:Length/2);u=X(Length/2+1:end);
% BCLeft = [0;0;0;0;(1/N_Seg)*cos(pi/(2*N_Seg)+p);0;(1/N_Seg)*sin(pi/(2*N_Seg)+p)];
% BCRight = [(1/N_Seg)*cos(pi-pi/(2*N_Seg)-p);0;(1/N_Seg)*sin(pi-pi/(2*N_Seg)-p);0;0;0;0];

BCLeft = [0;0;0;0;(1/N_Seg)*cos(p);0;(1/N_Seg)*sin(p)];
BCRight = [(1/N_Seg)*cos(pi-p);0;(1/N_Seg)*sin(pi-p);0;0;0;0];

% BCLeft = [0;0;0;0;(1/N_Seg)*cos(0);0;(1/N_Seg)*sin(0)];
% BCRight = [(1/N_Seg)*cos(pi-0);0;(1/N_Seg)*sin(pi-0);0;0;0;0];

%initialize x
x = [BCLeft;x;BCRight];

%initialize u
U = [zeros(7,1);u;zeros(7,1)];

%% Equations
DOF_system = Bigon_DOF_Manager(N_Seg);
[Seg_DOF,J_DOF] = Divide_subsystem(DOF_system,x);

%%segments equations
Seg_F = cell(2,1);
Buffer.m1 = cell(2,1);
Buffer.m2 = cell(2,1);
Buffer.refTIter = cell(2,1);

for i=1:2
    [Seg_F{i},Buffer.m1{i},Buffer.m2{i},Buffer.refTIter{i}] = Subsystem_equation(Seg_DOF{i},Segments{i}.d1,Segments{i}.DOF,Segments{i}.refT,...
                               Segments{i}.refLen,Segments{i}.voronoiRefLen,Segments{i}.kappaBar,Segments{i}.ne,EA,EI1,EI2,GJ);
end

%%joints equations
Joint_F = cell(1,1);
Buffer.Jm1 = cell(1,1);
Buffer.Jm2 = cell(1,1);
Buffer.JrefTIter = cell(1,1);

%%update kappa

    %%test code
    % if p>0.01
    %     sign=1;
    % 
    % end

Joints{1}.kappaBar(2,1)=2*tan(p);


i=1;
    [Joint_F{i},Buffer.Jm1{i},Buffer.Jm2{i},Buffer.JrefTIter{i}] = Subsystem_equation( J_DOF{i}, Joints{i}.d1, Joints{i}.DOF, Joints{i}.refT, ...
                            Joints{i}.refLen, Joints{i}.voronoiRefLen, Joints{i}.kappaBar,Joints{i}.ne,EA,100*EI1,1000*EI2,100*GJ);


%%totle equations
Totle_F = Assembly_Vector(DOF_system,Seg_F,Joint_F);

%%get rid of constrained equations
UnTotle_F = Totle_F(8:end-7);
UnTotle_Mass = Totle_Mass(8:end-7);
Unu = U(8:end-7);

%%output ODE
F=[
    Unu
    diag(UnTotle_Mass)\UnTotle_F - Unu %% there is a damp force 

    ];

end