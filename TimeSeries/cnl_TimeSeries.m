classdef cnl_TimeSeries < handle
    %A class for manipulating a time series 
    %   Binds together a multi-dimensional signal with a time vector, and
    %   provides methods for common time series manipulations
    
    properties
        timeline %a vector of times
        signal %a matrix RxC, where R = length(timeline), and C = dimensionality of the signal
    end

    methods

        function obj = cnl_TimeSeries(signal, timeline)
            if nargin > 1
                %make sure timeline is a vector
                if ~isvector(timeline)
                    error('Timeline must be a vector');
                end
                
                %check that the dimensions of timeline and signal match
                if length(timeline) ~= size(signal,1)
                    error('Timeline must have the same length as the number of rows in the signal');
                end
                
                obj.signal = signal;
                obj.timeline = timeline;
            else
                %only signal is specified; create a default timeline
                obj.signal = signal;
                obj.timeline = 1:size(signal,1);
            end
        end
        
        function set.signal(obj,signal)
            %the dimensions of signal cannot be changed when manually set by
            %the user
            if ~isequal(size(obj.signal),size(signal))
                error('When setting the signal manually, the size cannot be changed. Create a new object instead.');
            end        
            obj.signal = signal;
        end % set.signal

        function set.timeline(obj,timeline)
            %the dimensions of timeline cannot be changed when manually set by
            %the user
            if ~isequal(size(obj.timeline),size(timeline))
                error('When setting the timeline manually, the size cannot be changed. Create a new object instead.');
            end        
            obj.timeline = timeline;
        end % set.timeline
        
        function newTS = getSeriesInEpochs(obj, epochs)
            %return a time series object with only the data points that
            %occur within the specified time epochs
            
            %to do so we'll build a vector of the correct indices
            idx = [];
            for e=1:size(epochs,1)
                idx = [idx find(obj.timeline >= epochs(e,1) & obj.timeline <= epochs(e,2))];
            end
            
            %now return a handle to a new time series object with only
            %those points
            newTS = cnl_TimeSeries(obj.signal(idx,:), obj.timeline(idx));
        end
        
        function newTS = resampleToTimeline(obj, newTimeline, @interpFnc)
            newTS = interpFnc(obj.timeline, obj.signal, 
        end
    end
end

