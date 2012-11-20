function [epochs] = zerosAndOnesToEpochs2(events,times)

startTimes = zeros(round(length(events)/2),1); %least possible columns would be alternating 1's 0's which is round(length/2)
lastTimes = zeros(round(length(events)/2),1); %preallocates a estimated size for the vector
col = 1;
startIdx = 1;
numberOfTimes = 0; % keeps the count of the number of epochs in the vectors
lastIdx = length(events);
while(startIdx < lastIdx) % go until start == end
    if(events(startIdx) == '1') % checks if found a 1 at the index
        if(events(startIdx +1) == '0')% have only one bin time(not most likely gonna happen)
            startTimes(col) = times(startIdx);
            lastTimes(col) = times(startIdx);
            startIdx = startIdx + 2;
            numberOfTimes = numberOfTimes +1;
            col = col + 1;
        else % found another one so start counting
            lastOne = startIdx +1;
            while(lastOne <length(events) && events(lastOne+1) == '1') % makes sure it hasn't reached the end and checks for 1's
                lastOne= lastOne +1;
            end
            startTimes(col) = times(startIdx);
            lastTimes(col) = times(lastOne);
            startIdx = lastOne + 2;
            col = col +1;
            numberOfTimes = numberOfTimes +1;
        end
    else 
        startIdx = startIdx +1; % if finds a zero, check next index for one
    end
end
if(startIdx == lastIdx) % checks the case of ending with 'xxx01' again most likely wouldn't happen
    if(events(lastIdx - 1) == '0')
        startTimes(col) = times(lastIdx);
        lastTimes(col) = times(lastIdx);
        numberOfTimes = numberOfTimes +1;
    end
end
epochs = [startTimes(1:numberOfTimes) lastTimes(1:numberOfTimes)]; %makes sure it doesnt copy any 0's into the epochs object
end


