function [epochs] = binarySearch(obj,epochs)
  timeFound =zeros(size(epochs,1),2);
            for row=1:size(epochs,1)
                for col=1:2
                    if(col == 2)
                        start = last;
                    else
                        start = 1;
                    end
                    last = length(obj.timeline);
                    
                    %TODO: MAKE BINARY SEARCH FUNCTION
                    %SEE IF YOU CAN FIND MEX FILE FOR BINARY SEARCH
                    while(start <= last)
                        middle= floor((last + start)/2);
                        if(epochs(row,col) < obj.timeline(middle))
                            last = middle -1;
                        elseif(epochs(row,col) > obj.timeline(middle))
                            start = middle +1;
                        else
                            timeFound(row,col) = obj.timeline(middle);
                            break
                        end
                    end
                    %WRITE IN FEWER LINES?
                    if(timeFound(row,col) == 0)
                        index = find(min([(abs(obj.timeline(last) - epochs(row,col))) (abs(obj.timeline(start) - epochs(row,col)))]));
                        if(index == 1)
                            timeFound(row,col) = last;
                        else
                            timeFound(row,col) = start;
                        end
                    end
                end
            end
end

