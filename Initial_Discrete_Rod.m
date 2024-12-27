classdef Initial_Discrete_Rod
    properties(GetAccess = private)

    end
    properties
        refLen
        voronoiRefLen
        mass
        kappaBar
        nv
        ne


        DOF
        Nodes
        tangent
        d1
        d2
        m1
        m2
        refT
    end
    methods
        function obj = Initial_Discrete_Rod(Nodes)
            obj.nv = size(Nodes,1);
            obj.Nodes = Nodes;
            obj.ne = obj.nv -1 ;
            obj.refT =zeros(obj.ne,1);
            obj = obj.Nodes2DOF();
            obj = obj.computeTangent();
            obj = obj.Inital_d1d2();
            obj = obj.computeMaterialDirectors();
            obj = obj.Inital_RefLen();
            obj = obj.Inital_Mass();
            obj = obj.getkappa();
        end
        function obj = Nodes2DOF(obj)
            obj.DOF = zeros(4*obj.nv-1,1);
            for c=1:obj.nv
                obj.DOF( 4 * (c-1) + 1) = obj.Nodes(c,1);
                obj.DOF( 4 * (c-1) + 2) = obj.Nodes(c,2);
                obj.DOF( 4 * (c-1) + 3) = obj.Nodes(c,3);
            end
            obj.DOF( 4:4:end) = 0;
        end
        function obj = computeTangent(obj)

        obj.tangent = zeros(obj.ne,3); % tangent
        for c=1:obj.ne
            dx = obj.DOF(4*c+1:4*c+3) - obj.DOF( 4*(c-1) + 1: 4*(c-1) + 3);
            obj.tangent(c,:) = dx / norm(dx);
        end
        
        end
        function obj = Inital_d1d2(obj)

        t0 = obj.tangent(1,:);
        t1 = [0 -1  0];
        d1Tmp = cross(t0, t1);
        if (abs(d1Tmp) < 1.0e-6)
            t1 = [0 0 -1];
            d1Tmp = cross(t0, t1);
        end
        
            d1Tmp = (d1Tmp - dot(d1Tmp, t0) * t0);
            d1Tmp = d1Tmp / norm(d1Tmp);
        
        obj.d1(1,:) = d1Tmp;
        
        d1_l = obj.d1(1,:);
        obj.d2(1,:) = cross(t0, d1_l);
        for c=2:obj.ne
            t1 = obj.tangent(c,:);
            d1_l = parallel_transport(d1_l, t0, t1);
            d1_l = (d1_l - dot(d1_l, t1) * t1);
            d1_l = d1_l / norm(d1_l);
            obj.d1(c,:) = d1_l;
            d2_l = cross(t1, d1_l);
            obj.d2(c,:) = d2_l;
            t0 = t1;
        
        end
        end
        function obj = computeMaterialDirectors(obj)
        theta0 = obj.DOF(4:4:end);
        obj.m1 = zeros(obj.ne,3);
        obj.m2 = obj.m1;
        for c=1:obj.ne
            cs = cos(theta0(c));
            ss = sin(theta0(c));
            d1_l = obj.d1(c,:);
            d2_l = obj.d2(c,:);
            obj.m1(c,:) = cs * d1_l + ss * d2_l;
            obj.m2(c,:) = - ss * d1_l + cs * d2_l;
        end
        end
        function obj = Inital_RefLen(obj)
        
        
        obj.refLen = zeros(obj.ne, 1);
        % for c=1:obj.ne
        %     dx = obj.Nodes(c+1, :) - obj.Nodes(c, :);
        %     obj.refLen(c) = norm(dx);
        % end
        for c=1:obj.ne
            obj.refLen(c) = 1/obj.ne;
        end
        obj.voronoiRefLen = zeros(obj.nv, 1);
        for c=1:obj.nv
            if c==1
                obj.voronoiRefLen(c) = 0.5 * obj.refLen(c);
            elseif c==obj.nv
                obj.voronoiRefLen(c) = 0.5 * obj.refLen(c-1);
            else
                obj.voronoiRefLen(c) = 0.5 * (obj.refLen(c-1) + obj.refLen(c));
            end
        end

        end
        function obj = Inital_Mass(obj)

        w = 0.002;   %rectangle cross-section
        t = 0.0002;
        
        sum=0.0;
        for i=1:1:10
        sum=sum+1.0./(2.0.*i-1).^5.*tanh(pi.*(2.0.*i-1).*(w/t)./2);
        end 
        shape=(1.0-192.0/((w/t)*pi^5)*sum)/3.0;
        rho = 1000;
        Y = 10e8;
       
        dm = 2*(1+0.33)/(Y*shape.*t^2) * rho * obj.refLen;
        obj.mass = zeros(3*obj.nv+obj.ne, 1);
        for c=1:obj.ne
            if c==1
                obj.mass( 4 * (c-1) + 1 : 4 * (c-1) + 3) = dm(c)/2;
            else
                obj.mass( 4 * (c-1) + 1 : 4 * (c-1) + 3) = (dm(c-1)+dm(c))/2;
            end
        end
                obj.mass( 4 * (obj.nv-1) + 1 : 4 * (obj.nv-1) + 3) = dm(obj.ne)/2;
        
        for c=1:obj.ne
            obj.mass( 4 * c ) = dm(c)/12 * (w^2+t^2);  % rectangle slice moment of inertial
            
        end

        end
        function obj = getkappa(obj)

        
        % Computer Kappa
        obj.kappaBar = zeros(obj.nv, 2);
        % for c=2:obj.ne
        % 
        %     node0 = obj.DOF(4*(c-2)+1:4*(c-2)+3);
        %     node1 = obj.DOF(4*(c-1)+1:4*(c-1)+3);
        %     node2 = obj.DOF(4*(c-0)+1:4*(c-0)+3);
        %     m1e = obj.m1(c-1,:);
        %     m2e = obj.m2(c-1,:);
        %     m1f = obj.m1(c,:);
        %     m2f = obj.m2(c,:);
        % 
        %     kappaL = computekappa(node0, node1, node2, m1e, m2e, m1f, m2f );
        % 
        %     obj.kappaBar(c,1) = kappaL(1);
        %     obj.kappaBar(c,2) = kappaL(2);
        % end

        end
    end

end