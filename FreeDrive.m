classdef FreeDrive < Maneuver
    %FREEDRIVE Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Static)
        
        function nextState = apply(state,deltaT)
            %FreeDrive - Apply some acceleration
            speed = state.speed + 2;
            
            s = state.s + speed * deltaT;
            d = state.d;
            
            nextState = State(s,d,speed);
        end
    end
end

