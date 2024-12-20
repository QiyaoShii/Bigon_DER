classdef Es_Grad_Hess
    properties
        ne
        refLen
        EA

    end
    methods(Access = public)
        function obj = Es_Grad_Hess(ne, refLen, EA)
            obj.ne = ne;
            obj.refLen = refLen;
            obj.EA = EA;
        end
        function [Fs] = GetFs(obj,x)
            
            %% Compute force
            Fs = x * 0;
            for c=1:obj.ne
                node0 = [x(4*(c-1)+1); x(4*(c-1)+2); x(4*(c-1)+3)]';
                node1 = [x(4*c+1); x(4*c+2); x(4*c+3)]';
                [dF] = ...
                    obj.gradEs(node0, node1,obj.refLen(c), obj.EA);
                
                ci = 4*(c-1)+1;
                cf = 4*(c-1)+3;
                Fs(ci:cf) = Fs(4*(c-1)+1:4*(c-1)+3) - dF(1:3);
                Fs(ci+4:cf+4) = Fs(4*c+1:4*c+3) - dF(4:6);
                
            end
        end
        function [Js] = GetJs(obj,x)
            %% Compute force
            %Fs = x * 0;
            Js = zeros(length(x), length(x));
            for c=1:obj.ne
                node0 = [x(4*(c-1)+1); x(4*(c-1)+2); x(4*(c-1)+3)]';
                node1 = [x(4*c+1); x(4*c+2); x(4*c+3)]';
                [dJ] = ...
                    obj.hessEs(node0, node1, ...
                    obj.refLen(c), obj.EA);
                
                ci = 4*(c-1)+1;
                cf = 4*(c-1)+3;
                % Fs(ci:cf) = Fs(4*(c-1)+1:4*(c-1)+3) - dF(1:3);
                % Fs(ci+4:cf+4) = Fs(4*c+1:4*c+3) - dF(4:6);
                
                Js(ci:cf, ci:cf) = Js(ci:cf, ci:cf) - dJ(1:3, 1:3);
                Js(ci+4:cf+4, ci+4:cf+4) = Js(ci+4:cf+4, ci+4:cf+4) - dJ(4:6, 4:6);
                Js(ci+4:cf+4, ci:cf) = Js(ci+4:cf+4, ci:cf)  - dJ(4:6, 1:3);
                Js(ci:cf, ci+4:cf+4) = Js(ci:cf, ci+4:cf+4)  - dJ(1:3, 4:6);    
            end
         end


    end
    methods(Access = private)
        function [dF] = gradEs(obj,node0, node1, ...
                             l_k, EA)
            %
            % Inputs:
            % node0: 1x3 vector - position of the first node
            % node1: 1x3 vector - position of the last node
            %
            % l_k: reference length (undeformed) of the edge
            % EA: scalar - stretching stiffness - Young's modulus times area
            %
            % Outputs:
            % dF: 6x1  vector - gradient of the stretching energy between node0 and node 1.
            % dJ: 6x6 vector - hessian of the stretching energy between node0 and node 1.
            
            %% Gradient of Es
            edge = (node1 - node0)'; % 3x1 edge vector
            edgeLen = norm(edge);
            tangent = edge / edgeLen;
            epsX = edgeLen/l_k - 1;
            dF_unit = EA * tangent * epsX;
            
            dF = zeros(6,1);
            dF(1:3) = - dF_unit;
            dF(4:6) =   dF_unit;
        
        end
        function [dJ] = hessEs(obj,node0, node1, ...
                               l_k, EA)
            %
            % Inputs:
            % node0: 1x3 vector - position of the first node
            % node1: 1x3 vector - position of the last node
            %
            % l_k: reference length (undeformed) of the edge
            % EA: scalar - stretching stiffness - Young's modulus times area
            %
            % Outputs:
            % dF: 6x1  vector - gradient of the stretching energy between node0 and node 1.
            % dJ: 6x6 vector - hessian of the stretching energy between node0 and node 1.
            
            %% Gradient of Es
            edge = (node1 - node0)'; % 3x1 edge vector
            edgeLen = norm(edge);
            % tangent = edge / edgeLen;
            % epsX = edgeLen/l_k - 1;
            % dF_unit = EA * tangent * epsX;
            % 
            % dF = zeros(6,1);
            % dF(1:3) = - dF_unit;
            % dF(4:6) =   dF_unit;
            
            %% Hessian of Es
            Id3 = eye(3);
            M = EA * ( ...
                (1/l_k - 1/edgeLen) * Id3 + ...
                1/edgeLen * (edge*edge')/ edgeLen^2 ...
                ); %Note edge * edge' must be 3x3
            
            dJ = zeros(6,6);
            dJ(1:3, 1:3) = M;
            dJ(4:6, 4:6) = M;
            dJ(1:3, 4:6) = - M;
            dJ(4:6, 1:3) = - M;
        
        end



    end
end