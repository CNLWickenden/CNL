classdef cnl_TimeSeries < handle
    %A class for manipulating a time series
    %   Binds together a multi-dimensional signal with a time vector, and
    %   provides methods for common time series manipulations
    
    properties
        timeline = [];%a vector of times
        signal = [];%a matrix RxC, where R = length(timeline), and C = dimensionality of the signal
    end
    
    methods
        function obj = cnl_TimeSeries(signal,timeline)
            if nargin > 1
                %make sure timeline is a vector
                if ~isvector(timeline)
                    error('Timeline must be a vector');
                end
                %check that the dimensions of timeline and signal match
                %CHANGE BACK TO SIZE
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
        end
        
        function set.timeline(obj,timeline)
            %the dimensions of timeline cannot be changed when manually set by
            %the user
            if ~isempty(obj.timeline) && ~isequal(size(obj.timeline),size(timeline))
                error('When setting the timeline manually, the size cannot be changed. Create a new object instead.');
            end
            obj.timeline = timeline;
        end
        
        %return a time series object with only the data points that
        %occur within the specified time epochs
        %to do so we'll build a vector of the correct indices
        
        %FIXED AND TESTED
        function newTS = getSeriesInEpochs(obj, epochs)
            idx = zeros(size(epochs.epochs));
            for e=1:size(epochs.epochs,1)
                [~, idx] = find(obj.timeline >= epochs.epochs(e,1) & obj.timeline <= epochs.epochs(e,2));
            end
            
            %now return a handle to a new time series object with only
            %those points
            newTS = cnl_TimeSeries(obj.signal(:,idx), obj.timeline(idx));
        end
        
        
        %return a matrix of starting and ending indices corresponding
        %to the given epochs; can be used to do a custom trial by trial
        %analysis
        %only returns the indicies pointing to the first closest found
        %time
        
        %ABLE TO PASS IN EPOCHS OBJECT
        function timeFound = getIdxInEpochs(obj, epochs)
            timeFound = binarySearch(obj,epochs.epochs);
        end
        
        
        function idx = getIdxInEpochs2(obj, epochs)
            idx=zeros(length(epochs),2);
            for i=1:size(epochs,1)
                [~, idx(i,1)] = min(abs(obj.timeline - epochs(i,1)));
                [~, idx(i,2)] = min(abs(obj.timeline(idx(i,1):length(obj.timeline)) - epochs(i,2)));
            end
        end
        
        
        %return a time series object resampled to the given time line
        %use signals and timeline to figure out new signal at newTimelines
        %times, return new time series based off of an interp
        function newTS = resampleToTimeline(obj, newTimeline, interpFnc)
            
        end
        
        %apply the given fnc to the signal in each epoch; fnc can
        %return one variable, which is stored in a cell array 'data'
        %and passed as output
        %Ex: calculate the mean signal in each epoch
        %possible for loop in cell area
        function data = computeByEpoch(obj, epochs, fnc)
            indices = getIdxInEpochs(obj,epochs);
            temp = fnc(obj.signal(indices(:,1),indices(:,2)));
            
%             data = cell(numEpochs,1)
%             data{x} = fnc()
        end
        %fnc acts on the signal and returns a modified signal, which is
        %stored back into obj.signal
        %this way, the signal can easily be modified on a trial by
        %trial basis by calling this function
        %
        function modifySignalByEpoch(obj, epochs, fnc)
        end
        
        %makes a 'design' matrix from the data in signal so that a
        %linear regression can be done using that data as a predictor
        %variable, using only the data in the time windows specified by
        %epcohs. Moreover, have the capability to include signal data
        %points in the past and in the future as part of the predictor
        %variables. If lags>0, use that many data points in the past;
        %if leads>0, use that many data points in the future. However,
        %use no data points where the full lags and leads cannot be
        %collected by sticking to data only in the specified epcohs.
        function makeDesignMatrix(obj, epochs, lags, leads)
        end
        
        %do an nPoint numerical differentiation on each column of the signal,
        %resulting in a new differentiated signal with the same timeline
        function differentiate(obj, nPoint)
        end
        
        %TODO: ability to do multivariable signal
        %TODO: Compare to trapz or cumtrapz
        %do trapezoidal numerical integration on each column of signal,
        %resulting in a new integrated signal on the same timeline
        function integrate(obj)
            
            s=0;
            %Will Ignore the first value in the signal (error)
            %I was messing around with the values using TestData (dSet)
            %When I set signal equal to the first set of values in
            %cursorVel and timeline equal to binTime and the run the function:
            %I get an average difference of -3.9094e-004 for the difference
            %in the integrated values and the actual cursorPos values in
            %the TestData. I just need to fix the parameters of the
            %function and make work efficently.
            for i=1:(length(obj.timeline)-1)
                    s=s+(.5)*(obj.timeline(i+1)-obj.timeline(i))*(obj.signal(i)+obj.signal(i+1));
                    obj.signal(i+1)=s;
            end
            
            
        end
    end
end

