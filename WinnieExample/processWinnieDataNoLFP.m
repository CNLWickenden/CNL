function P = processWinnieDataNoLFP(fileInfo)
    cursorPath = [fileInfo.basePath fileInfo.subjectCode fileInfo.date ...
        '\' fileInfo.subjectCode fileInfo.date fileInfo.run '.cursor'];
    paramsPath = [fileInfo.basePath fileInfo.subjectCode fileInfo.date ...
        '\' fileInfo.subjectCode fileInfo.date fileInfo.run 'params\ParametersStart'];
    
    %load parameters
    load(paramsPath);
    
    %load cursor file
    P.Cursor = GetCursorFileFRW(cursorPath, VR);
    
    %extract firing rates
    P.fRates = exp(P.Cursor.RawPower);
    
    %process trials
    P.trl.goodOptoBins = find(abs(P.Cursor.positions(:,1)) < 1);
    P.trl.outerReaches = logicalToEpochs( P.Cursor.gameState'==3 );
    P.trl.centerReaches = logicalToEpochs( P.Cursor.gameState'==1 );
    sOuterIdx = (P.trl.outerReaches(:,2)-P.trl.outerReaches(:,1) <= 10);
    sCenterIdx = (P.trl.centerReaches(:,2)-P.trl.centerReaches(:,1) <= 10);
    P.trl.sOuterReaches = P.trl.outerReaches(sOuterIdx,:);
    P.trl.sCenterReaches = P.trl.centerReaches(sCenterIdx,:);
    oIdx = getEpochIdx(P.trl.sOuterReaches);
    cIdx = getEpochIdx(P.trl.sCenterReaches);
    tIdx = union(oIdx,cIdx);
    P.trl.goodIdx = intersect(tIdx,P.trl.goodOptoBins);
    
    %process targets for each trial
    uniqueTargs = unique(P.Cursor.targetPos,'rows');
    P.targList = uniqueTargs;
    P.trl.outerReachTargs = getTargetInTrial(P.targList,P.Cursor.targetPos,P.trl.outerReaches);
    P.trl.centerReachTargs = getTargetInTrial(P.targList,P.Cursor.targetPos,P.trl.centerReaches);
    P.trl.sOuterTargs = P.trl.outerReachTargs(sOuterIdx,:);
    P.trl.sCenterTargs = P.trl.centerReachTargs(sCenterIdx,:);
end

function targNums = getTargetInTrial(targList,targPos,trials)
    targNums = zeros(size(trials,1),1);
    for t=1:size(trials,1)
        midIdx = round(mean(trials(t,:)));
        targ = targPos(midIdx,:);
        targNums(t) = find(ismember(targList,targ,'rows')==1);
    end
end