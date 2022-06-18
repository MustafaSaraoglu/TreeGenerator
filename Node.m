classdef Node
    %NODE Every node of a tree contains the state/action information,
    %source/target properties
    
    properties
        sourceNodeID
        sourceEdgeName
        id
        state
        actions
        targetNodeID
        UnsafetyValue
    end
    
    methods
        function obj = Node(sourceNodeID,sourceEdgeName,id,state,actions,UnsafetyValue)
            %NODE Construct an instance of this class
            %   Detailed explanation goes here
            obj.sourceNodeID = sourceNodeID;
            obj.sourceEdgeName = sourceEdgeName;
            obj.id = id;
            obj.state = state;
            obj.actions = actions;
            obj.targetNodeID = [];
            obj.UnsafetyValue = UnsafetyValue;
        end
        
        function newNode = expand(obj,action,deltaT,count,VehiclesOther,OtherVehicleStateDistributions)
            
            newState = action{1}.apply(obj.state,deltaT);
            
            newUnsafetyValues = [];
            for idx = 1:length(OtherVehicleStateDistributions)
                OtherVehicleStateDistribution = OtherVehicleStateDistributions(idx);
                newUnsafetyValue = Maneuver.calculateUnsafety(newState,VehiclesOther(idx).d,OtherVehicleStateDistribution);
                newUnsafetyValues = [newUnsafetyValues newUnsafetyValue];
            end
            
            newUnsafetyValue = max(newUnsafetyValues);

            newNode = Node(obj.id,action,count,newState,obj.actions,newUnsafetyValue);
            
        end
        
    end
end

