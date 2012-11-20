events = cell(1000);
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