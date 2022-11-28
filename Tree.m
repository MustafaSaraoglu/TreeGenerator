classdef Tree
    %TREE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        digraph
        visualization
    end
    
    methods
        function obj = Tree(RootNodes,leafNodes)
            %TREE Construct an instance of this class
            %   Detailed explanation goes here
            AllNodes = [RootNodes leafNodes];

            sourceNodes = [AllNodes.sourceNodeID];
            
            targetNodes = [AllNodes.id];
            targetNodes(1) = [];
            
            G = digraph(sourceNodes,targetNodes);
            p = plot(G,"layout","layered"); % Plot
            
            % Edit the plot
            edgeLabels = cellfun(@getName, [AllNodes.sourceEdgeName],'UniformOutput',false);
            p.EdgeLabel = edgeLabels;
            
            UnsafeNodes = AllNodes([AllNodes.UnsafetyValue] > 0.02); % Unsafety value - Min
            p.highlight([UnsafeNodes.id],"NodeColor","red") % Mark unsafe nodes
            
            SafeNodes = leafNodes([leafNodes.UnsafetyValue] <0.0001);
            
            %% Find the safe nodes or the node
            % If there is no safe node (a node with an unsafety value that is smaller than the threshold value)
            if isempty(SafeNodes) 
                [val, idx]=min([leafNodes.UnsafetyValue]); % Find the node with the minimum unsafety value
                
                SafeNodes = leafNodes(idx);
                
            else
                %% Find the best node among the safest nodes
                [val, idx] = max([cat(1,SafeNodes.state).s]); % Performance value - Max

                
            end
            
            p.highlight(leafNodes(idx).id,"NodeColor","green") % Mark safe node green,
            disp(['Best Node ID: ',num2str(leafNodes(idx).id),', total distance: ',num2str(val)])
            

            %% Mark all safe actions and states
            allDecisionNodes = Tree.getAlltheParentNodes(leafNodes(idx),AllNodes);
            allsafe = [allDecisionNodes.id];
            
            p.highlight([allDecisionNodes.id],"NodeColor","green") % Mark safe node green,
            p.highlight(allsafe(2:end),allsafe(1:end-1));
            %p.highlight(allsafe(2:end),allsafe(1:end-1),"EdgeColor","green","EdgeFontSize",8) % Mark all the edges leading to the safe node green
            p.MarkerSize = 8;
            % Assign
            obj.digraph = G;
            obj.visualization =p;
        end
        

        
        
    end
    
    methods (Static)
        function allDecisionNodes = getAlltheParentNodes(safeNode,AllNodes)
            
            allDecisionNodes = safeNode;
            while true
                
                parentNode = AllNodes(safeNode.sourceNodeID); 
                allDecisionNodes = [allDecisionNodes parentNode];
                if isempty(parentNode.sourceNodeID)
                    break
                else
                    safeNode = parentNode;
                end
            end

        end
    end
end

