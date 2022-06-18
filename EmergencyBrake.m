classdef EmergencyBrake < Maneuver
    %EmergencyBrake Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Static)
        
        function nextState = apply(state,deltaT)
            %EmergencyBrake - Apply some deceleration
            speed = state.speed - 2;
            
            s = state.s + speed * deltaT;
            d = state.d;
            
            nextState = State(s,d,speed);
        end
    end
end



