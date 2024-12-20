classdef Bigon_DOF_Manager
    properties
        N_Seg
    end
    methods(Access = public)
        function obj = Bigon_DOF_Manager(N_Seg)
            obj.N_Seg = N_Seg;
        end
        function [Seg_DOF,J_DOF] = Divide_subsystem(obj,X)

            Left_End_idx=[1:4*obj.N_Seg,4*obj.N_Seg+5:4*obj.N_Seg+11];
            Right_End_idx = [1:7,12:11+4*obj.N_Seg];
        
            Seg_idx = cell(2,1);

            Seg_idx{1} = Left_End_idx';
            Seg_idx{2} = Right_End_idx' + Seg_idx{1}(end)-11;
        
            Joint_idx{1}  = (1:11)'+Seg_idx{2}(1)-1;
        
            Seg_DOF = cell(2,1);
            for j =1 : 2
                for i=1:size(Seg_idx{j},1)
                    Seg_DOF{j}(i,1) = X(Seg_idx{j}(i,1));  
                end
            end
        
            J_DOF = cell(1,1);
            for i=1:size(Joint_idx{1},1)
                J_DOF{1}(i,1) = X(Joint_idx{1}(i,1));  
            end

        end
        function Totle_F = Assembly_Vector(obj,F_Seg,F_Joint)

            Left_End_idx=[1:4*obj.N_Seg,4*obj.N_Seg+5:4*obj.N_Seg+11];
            Right_End_idx = [1:7,12:11+4*obj.N_Seg];
        
            Seg_idx = cell(2,1);

            Seg_idx{1} = Left_End_idx';
            Seg_idx{2} = Right_End_idx' + Seg_idx{1}(end)-11;
        
            Joint_idx{1}  = (1:11)'+Seg_idx{2}(1)-1;
        
           Tot_SF = zeros(2*(4*(obj.N_Seg+1+1)-1)-3,2);
           Totle_F = zeros(2*(4*(obj.N_Seg+1+1)-1)-3,1);
           for j =1 : 2
                 for i=1:size(F_Seg{j},1)
                     Tot_SF(Seg_idx{j}(i,1),j) = F_Seg{j}(i,1);
                 end
                 Totle_F = Totle_F + Tot_SF(:,j);
           end 
        
           Tot_JF = zeros(2*(4*(obj.N_Seg+1+1)-1)-3,1);
           for i=1:11
               Tot_JF(Joint_idx{1}(i,1),1) = F_Joint{1}(i);
           end
           Totle_F = Totle_F + Tot_JF(:,1);

            
        end
        function Totle_J = Assembly_Jacobian(obj,J_Seg,J_Joint)

            Left_End_idx=[1:4*obj.N_Seg,4*obj.N_Seg+5:4*obj.N_Seg+11];
            Right_End_idx = [1:7,12:11+4*obj.N_Seg];
        
            Seg_idx = cell(2,1);

            Seg_idx{1} = Left_End_idx';
            Seg_idx{2} = Right_End_idx' + Seg_idx{1}(end)-11;
        
            Joint_idx{1}  = (1:11)'+Seg_idx{2}(1)-1;
        
        
            Totle_J = zeros(2*(4*(obj.N_Seg+1+1)-1)-3,2*(4*(obj.N_Seg+1+1)-1)-3);
            for k = 1:2
                Tot_SJ = zeros(2*(4*(obj.N_Seg+1+1)-1)-3,2*(4*(obj.N_Seg+1+1)-1)-3);
                for i=1:size(J_Seg{k},1)
                    for j = 1:size(J_Seg{k},2)
                        Tot_SJ(Seg_idx{k}(i),Seg_idx{k}(j)) = J_Seg{k}(i,j);
        
                    end
                end
                Totle_J = Totle_J + Tot_SJ;
            end
        
            

            Tot_JJ = zeros(2*(4*(obj.N_Seg+1+1)-1)-3,2*(4*(obj.N_Seg+1+1)-1)-3);
            for i=1:size(J_Joint{1},1)
                for j = 1:size(J_Joint{1},2)
                    Tot_JJ(Joint_idx{1}(i),Joint_idx{1}(j)) = J_Joint{1}(i,j);
    
                end
            end
            Totle_J = Totle_J + Tot_JJ;

            
        end
    end




end