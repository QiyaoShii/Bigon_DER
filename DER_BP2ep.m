function prob = DER_BP2ep(prob, oid, varargin)
global natR alpha N_Seg NC
global Segments Joints

tbid   = coco_get_id(oid, 'DER');   % Create toolbox instance identifier
str    = coco_stream(varargin{:});  % Convert varargin to stream of tokens for argument parsing
Newtonoid = coco_get_id(tbid, 'InIter'); % Create segment object instance identifier

read_data=coco_read_solution('',varargin{1},varargin{2});
data = struct();
Segments = read_data{3,2}.Segments;
Joints = read_data{3,2}.Joints;
data.Segments = Segments;
data.Joints = Joints;
data.currentX = read_data{3,2}.currentX;  

prob = ode_BP2ep(prob,Newtonoid,str); % Construct 'coll' instance

data.tbid = 'reference_frame';
data = coco_func_data(data); % Convert to func_data class for shared access
prob = coco_add_slot(prob, tbid, @frame_update, data, 'update'); 
prob = coco_add_slot(prob, tbid, @coco_save_data, data, 'save_full');

end

function data = frame_update(prob, data, cseg, varargin)
global N_Seg 
global Segments Joints

X  = cseg.src_chart.x;

Length=size(X,1);x=X(1:(Length-2)/2);
% BCLeft = [0;0;0;0;(1/N_Seg)*cos(pi/(2*N_Seg)+X(end-1));0;(1/N_Seg)*sin(pi/(2*N_Seg)+X(end-1))];
% BCRight = [(1/N_Seg)*cos(pi-pi/(2*N_Seg)-X(end-1));0;(1/N_Seg)*sin(pi-pi/(2*N_Seg)-X(end-1));0;0;0;0];

BCLeft = [0;0;0;0;(1/N_Seg)*cos(X(end-1));0;(1/N_Seg)*sin(X(end-1))];
BCRight = [(1/N_Seg)*cos(pi-X(end-1));0;(1/N_Seg)*sin(pi-X(end-1));0;0;0;0];

data.currentX = [BCLeft;x;BCRight];  

DOF_system = Bigon_DOF_Manager(N_Seg);
[Seg_DOF,J_DOF] = Divide_subsystem(DOF_system,data.currentX);

for i = 1:2
    [Segments{i}.d1,Segments{i}.d2] = computeTimeParallel(Segments{i}.d1, Segments{i}.DOF, Seg_DOF{i});
    [Segments{i}.tangent] = computeTangent(Seg_DOF{i});
    [Segments{i}.m1,Segments{i}.m2] = computeMaterialDirectors(Segments{i}.d1, Segments{i}.d2, Seg_DOF{i}(4:4:end));
    Segments{i}.DOF = Seg_DOF{i};

end
data.Segments = Segments;


[Joints{1}.d1,Joints{1}.d2] = computeTimeParallel(Joints{1}.d1, Joints{1}.DOF, J_DOF{1});
[Joints{1}.m1,Joints{1}.m2] = computeMaterialDirectors(Joints{1}.d1, Joints{1}.d2, J_DOF{1}(4:4:end));
Joints{1}.DOF = J_DOF{1};
data.Joints = Joints;
% Joints{1}.kappaBar(2,2)=2*tan(X(end-1));
end