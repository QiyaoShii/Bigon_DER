function Initialvalue = Initialization_bigon()
global N_Seg  
global rho Y EA GJ EI1 EI2
global Segments Joints 
global Totle_Mass
%%discrete message
N_Seg = 30;

%geometry parameters
w = 0.0004;   %rectangle cross-section
t = 0.0002;

%mechaincs property
sum=0.0;
for i=1:1:10
sum=sum+1.0./(2.0.*i-1).^5.*tanh(pi.*(2.0.*i-1).*(w/t)./2);
end 

shape=(1.0-192.0/((w/t)*pi^5)*sum)/3.0;
a=(1+0.33)/(6*shape);
b=(1+0.33)/(6*shape)*(w/t)^2;

EA = 2*(1+0.33)/(shape*t^2)/1000000;
EI1 =b;
EI2 =a;
GJ=1;

rho = 1000;
Y = 10e6;
%%create geometry
[Seg_Nodes,J_Nodes] = Initial_shape(N_Seg);

%%create discrete elastic rods
for i=1:2

    Segments{i} = Initial_Discrete_Rod(Seg_Nodes{i});
end



%%create Joint_segment

Joints{1} = Initial_Discrete_Rod(J_Nodes{1});

%%Initial value for solving ODE
Mass=cell(2,1);DOF=cell(2,1);
for i = 1:2
    DOF{i} = Segments{i}.DOF;
    Mass{i} = Segments{i}.mass; 
end

Totle_Mass = GetInitialvaluefromeSegs(N_Seg,Mass);
X0 = GetInitialvaluefromeSegs(N_Seg,DOF);


Initialvalue = [X0(8:end-7);zeros(size(X0,1)-14,1)];

end
