classdef State
    %STATE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        s
        d
        speed
    end
    
    methods
        function obj = State(s,d,speed)
            %STATE
            obj.s = s;
            obj.d = d;
            obj.speed = speed;
            
        end
        
    end
end

