events = cell(1000,1);
placeholder = zeros(1,1000);
for i=1:1000
    for j=1:1000
        holder = randi([0,1]);
        if(holder ==1)
            placeholder(j) = '1';
        else
            placeholder(j) = '0';
        end
    end
    events{i} = placeholder;
end


timewindow = 1:1000;
totalTime = 0;
timesrun = 0;
for i=1:1000
    tic;
    cnl_Epochs(events{i},timewindow);
    totalTime = totalTime + toc;
end
disp(totalTime);


eventStrings = randi([0 1],1000,1000);
timeLine = 1:1000;
computeTimes = zeros(1000,3);
for e=1:1000
    tic
    e1 = logicalToEpochs(eventStrings(e,:));
    computeTimes(e,1) = toc;
    
    tic
    e2 = zerosAndOnesToEpochs(eventStrings(e,:),timeLine);
    computeTimes(e,2) = toc;
    
    tic     
    e3 = zerosAndOnesToEpochs2(eventStrings(e,:),timeLine);
    computeTimes(e,3) = toc;
end