classdef cnl_Epochs < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties 
        epochs = [] %Nx2 matrix, where n is the number of epochs
    end
    
    methods 
       
        
        % Constructor
        % timeWindows - A Nx2 matrix of times [start,finish] or a vector of
        % time events
        function obj = cnl_Epochs(timeWindows) 
            if((length(timeWindows(1,:)) ~= 2) && (~isvector(timeWindows)))
                error('The time windows must be a N x2 matrix or a vector of times');
            else
                if(length(timeWindows(1,:)) ==2)
                    obj.epochs = timeWindows;
                else
                    obj.epochs = zeros((length(timeWindows)-1),2);
                    obj.epochs(:,1) = timeWindows(1:length(timeWindows) -1);
                    obj.epochs(:,2) = timeWindows(2:length(timeWindows));
                end
            end
        end
  
        
        %Returns the epochs
        function set.epochs(obj,epochs)
            if(length(epochs(1,:)) ~= 2)
                error('The epoch must be a N x2 matrix');
            else
                obj.epochs = epochs;
            end
        end
           
        
    end
    
    
end

