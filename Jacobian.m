function J = Jacobian(X, p)

global natR alpha
global N_Seg NC
global EA EI1 EI2 GJ
global Segments Joints
global Buffer
global Totle_Mass
%% Initialization
Length=size(X,1);x=X(1:Length/2);u=X(Length/2+1:end);
BCLeft = [0;0;0;0;(1/N_Seg)*cos(p);0;(1/N_Seg)*sin(p)];
BCRight = [(1/N_Seg)*cos(pi-p);0;(1/N_Seg)*sin(pi-p);0;0;0;0];

% BCLeft = [0;0;0;0;(1/N_Seg)*cos(0);0;(1/N_Seg)*sin(0)];
% BCRight = [(1/N_Seg)*cos(pi-0);0;(1/N_Seg)*sin(pi-0);0;0;0;0];

%initialize x
x = [BCLeft;x;BCRight];

%initialize u
U = [zeros(7,1);u;zeros(7,1)];

%% Jacobian
DOF_system = Bigon_DOF_Manager(N_Seg);
 [Seg_DOF,J_DOF] = Divide_subsystem(DOF_system,x);


%%Segments Jacobian
Seg_J = cell(2,1);
for i = 1:2
    Seg_J{i} = Subsystem_Jacobian( Seg_DOF{i}, Buffer.m1{i}, Buffer.m2{i}, Buffer.refTIter{i},...
            Segments{i}.refLen, Segments{i}.voronoiRefLen, Segments{i}.kappaBar, Segments{i}.ne,EA,EI1,EI2,GJ );
end

%%Joint Jacobian
Joints_J = cell(1,1);
i=1;
    Joints_J{i} = Subsystem_Jacobian( J_DOF{i}, Buffer.Jm1{i}, Buffer.Jm2{i}, Buffer.JrefTIter{i},...
                         Joints{i}.refLen, Joints{i}.voronoiRefLen, Joints{i}.kappaBar,Joints{i}.ne,EA,100*EI1,1000*EI2,100*GJ);



%%totle Jacobian
Totle_J = Assembly_Jacobian(DOF_system,Seg_J,Joints_J);



%%get rid of constrained blocks of the Jacobian
UnTotle_J = Totle_J(8:end-7,8:end-7);
UnTotle_Mass = Totle_Mass(8:end-7);
Unu = U(8:end-7);

%%output ODE
J=[    
    zeros(size(diag(Unu),1),size(UnTotle_J,2)) eye(size(Unu,1))
    diag(UnTotle_Mass)\UnTotle_J  -eye(size(Unu,1))

    ];

end