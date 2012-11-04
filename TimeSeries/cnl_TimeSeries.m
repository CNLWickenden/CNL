classdef cnl_TimeSeries < handle
    %A class for manipulating a time series 
    %   Binds together a multi-dimensional signal with a time vector, and
    %   provides methods for common time series manipulations
    
    properties
        timeline = [];%a vector of times
        signal = [];%a matrix RxC, where R = length(timeline), and C = dimensionality of the signal
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
                obj.timeline = (1:size(signal,1))';
            end
        end
        
        function set.signal(obj,signal)
            %the dimensions of signal cannot be changed when manually set by
            %the user
            if ~isempty(obj.signal) && ~isequal(size(obj.signal),size(signal))
                error('When setting the signal manually, the size cannot be changed. Create a new object instead.');
            end        
            obj.signal = signal;
        end % set.signal

        function set.timeline(obj,timeline)
            %the dimensions of timeline cannot be changed when manually set by
            %the user
            if ~isempty(obj.timeline) && ~isequal(size(obj.timeline),size(timeline))
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
        
        function idx = getIdxInEpochs(obj, epochs)
            %return a matrix of starting and ending indices corresponding
            %to the given epochs; can be used to do a custom trial by trial
            %analysis
%             idx=zeros(size(epochs,1),2);
%             for i=1:size(epochs,1)
%                 idx(i,1)= find(obj.timeline == epochs(i,1));
%                 idx(i,2)= find(obj.timeline == epochs(i,size(epochs(i,:)));
%             end
        end
        
        function newTS = resampleToTimeline(obj, newTimeline, interpFnc)
            %return a time series object resampled to the given time line
        end
        
        function data = computeByEpoch(obj, epochs, fnc)
            %apply the given fnc to the signal in each epoch; fnc can
            %return one variable, which is stored in a cell array 'data'
            %and passed as output
            %Ex: calculate the mean signal in each epoch
        end
        
        function modifySignalByEpoch(obj, epochs, fnc)
            %fnc acts on the signal and returns a modified signal, which is
            %stored back into obj.signal
            %this way, the signal can easily be modified on a trial by
            %trial basis by calling this function
        end
        
        function makeDesignMatrix(obj, epochs, lags, leads)
            %makes a 'design' matrix from the data in signal so that a
            %linear regression can be done using that data as a predictor
            %variable, using only the data in the time windows specified by
            %epcohs. Moreover, have the capability to include signal data
            %points in the past and in the future as part of the predictor
            %variables. If lags>0, use that many data points in the past;
            %if leads>0, use that many data points in the future. However,
            %use no data points where the full lags and leads cannot be
            %collected by sticking to data only in the specified epcohs.
        end
        
        function differentiate(obj, nPoint)
            %do an nPoint numerical differentiation on each column of the signal,
            %resulting in a new differentiated signal with the same timeline
        end
        
        function integrate(obj)
            %do trapezoidal numerical integration on each column of signal,
            %resulting in a new integrated signal on the same timeline
        end
    end
end

