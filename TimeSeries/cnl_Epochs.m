classdef cnl_Epochs < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        epochs = [] %Nx2 matrix, where n is the number of epochs
    end
    
    methods
        
        %make something 00001110000 and takes a vector of times return
        %timewindow first 1 = start last 1 = finish, ignore 0's and 1's
        %inbetween
        % Constructor
        % timeWindows - A Nx2 matrix of times [start,finish] or a vector of
        % time events
        function obj = cnl_Epochs(timeWindows,times)
            if(nargin == 2)
                if(~isvector(timeWindows) && ~isvector(times) && length(times) ~= length(timeWindows))
                    error('If using two arguments, the first argument must be a string of 0''s and 1''s and the second must be a vector of times equal in length to the string vector');
                else
                    obj.epochs = zerosAndOnesToEpochs(timeWindows,times);
                end
            else
                if((size(timeWindows,2) ~= 2) && (~isvector(timeWindows)))
                    error('The time windows must be a N x2 matrix or a vector of times');
                else
                    if(size(timeWindows,2) ==2)
                        obj.epochs = timeWindows;
                    else
                        obj.epochs = zeros((length(timeWindows)-1),2);
                        obj.epochs(:,1) = timeWindows(1:length(timeWindows) -1);
                        obj.epochs(:,2) = timeWindows(2:length(timeWindows));
                    end
                end
            end
        end
        
        
        %Returns the epochs
        function set.epochs(obj,epochs)
            if(size(epochs,2) ~= 2)
                error('The epoch must be a N x2 matrix');
            else
                obj.epochs = epochs;
            end
        end
    end    
end

