classdef Maneuver
    %MANEUVER = Superclass for all maneuvers
    
    properties
        name
    end
    
    methods
        function obj = Maneuver(name)
            %MANEUVER Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = name;
        end
        
        function name = getName(obj)
            name = obj.name;
        end
        
    end
    
    methods (Static)
        function allActions = getAllActions()
            allActions = {FreeDrive('FD'),LaneChanging('LC'),EmergencyBrake('EB')};
        end
        
        function newStateDist = moveConstantSpeed(state, deltaT)
            
            mean = state.s + state.speed*deltaT;
            
            variance = deltaT;
            
            newStateDist = makedist('Normal','mu',mean, 'sigma',variance);
            
            
        end
        
        function UnsafetyValue = calculateUnsafety(EgoState,OtherVehicle_d,pd)
            
            if EgoState.d == OtherVehicle_d
                % On the same lane with the other vehicle
                
                UnsafetyValue = abs(pd.cdf(EgoState.s+2)-pd.cdf(EgoState.s-2)); % Assume ego vehicle is 4m long +-2m from center
                
            else
                % Not on the same lane
                UnsafetyValue = 0;
            end
            
        end
        
    end
    
    
    
    methods (Abstract)
        apply(obj)
    end
end

