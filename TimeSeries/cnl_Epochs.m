classdef cnl_Epochs < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties 
        epochs = [] %Nx2 matrix, where n is the number of epochs
    end
    
    methods 
       
        
        % Constructor
        % timeWindows - A Nx2 matrix of times [start,finish]
        function obj = cnl_Epochs(timeWindows) 
            if(length(timeWindows(1,:)) ~= 2)
                error('The time windows must be a N x2 matrix');
            else
                obj.epochs = timeWindows;
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

