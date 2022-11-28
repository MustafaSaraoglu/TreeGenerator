%% States
VehicleEgo = State(10,0,10);
VehiclesOther = [State(24,0,2) State(20,3.7,8) State(0,0,13)];


%% Horizon
deltaT = 1;
maxDepth = 6;
count = 1;


% All maneuvers
allActions = Maneuver.getAllActions;



RootNodes = []; % fully expanded nodes
UnsafeNodes =[];
% Create the root node
n1 = Node([],[],count,VehicleEgo,allActions, 0);
count = count + 1;

leafNodes = n1;

for k =1:maxDepth
    
    OtherVehicleStateDistributions =[];
    for VehicleOther = VehiclesOther
        OtherVehicleStateDistribution = Maneuver.moveConstantSpeed(VehicleOther,deltaT*k);
        OtherVehicleStateDistributions = [OtherVehicleStateDistributions OtherVehicleStateDistribution];
        
    end
    
    
    for leafNode = leafNodes
        
        newleafNodes =[];
        
        if leafNode.UnsafetyValue < 0.02
            % Only the safe states
            
            for act = allActions
                % expand 
                newLeafNode = leafNode.expand(act,deltaT,count,VehiclesOther,OtherVehicleStateDistributions);
                
                
                newleafNodes = [newleafNodes newLeafNode];
                count = count + 1;
            end
            
        else
            UnsafeNodes = [UnsafeNodes leafNode];
            % Unsafe states
            disp(['SrcID: ',num2str(leafNode.sourceNodeID),'->Act:',leafNode.sourceEdgeName{1}.getName,'-> Node', num2str(leafNode.id),' ', 'Unsafety Value: ',num2str(leafNode.UnsafetyValue)])
            
            
        end
        

        
        RootNodes = [RootNodes leafNode];
        leafNodes = [leafNodes newleafNodes];
        
        leafNodes(1) = [];
        
        
        
        % Add all the new leaf nodes to an array to expand in the next depth
    end
end

count = count - 1;

tree = Tree(RootNodes,leafNodes);



