classdef LaneChanging < Maneuver
    %LaneChanging Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Static)
        
        function nextState = apply(state,deltaT)
            %LaneChanging - Apply some acceleration
            speed = state.speed;
            
            s = state.s + speed * deltaT;
            
            d = state.d;
            
            if d==0
                % Right Lane
                d = 3.7;
            else
                % Left Lane
                d = 0;
            end
            
            
            nextState = State(s,d,speed);
        end
    end
end

