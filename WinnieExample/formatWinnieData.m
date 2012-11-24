%SET CORRECT BASE PATH HERE
fileInfo.basePath = 'C:\Users\Frank\Documents\1_BigData\';
fileInfo.subjectCode = 'WNR';
date = {'121121'};
run = {'003'};

for f=1:length(date)
    fileInfo.date = date{f};
    fileInfo.run = run{f};
    P = processWinnieDataNoLFP(fileInfo);
    save([fileInfo.basePath fileInfo.subjectCode fileInfo.date '\P_' fileInfo.subjectCode fileInfo.date fileInfo.run],'P');
end
