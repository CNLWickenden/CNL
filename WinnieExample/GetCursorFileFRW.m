function Cursor = GetCursorFileFRW(CursorFileName, VR)

    disp(CursorFileName(end-18:end-7));

    %look for variables cursorColVars, then put them into our Cursor struct
    %with the name cursorVarNames
    cursorColVars = {'VR.target_num','VR.BC_flag','VR.cursor_position','VR.target_position','assumed_intention',...
        'VR.TargRad','timing.now','VR.loopTime','Joystick','VR.acts','MeanErrorOutput','VR.BlockNum','VR.in_target',...
        'SimData.FiringRates','SimData.Real','dVel','VR.elbow_angle','VR.shoulder_angle',...
        'RawPower','data.norm','I_acts','SimData.PoissonBinCounts','timing.DataLoop','timing.DataWaitLoop','timing.FullLoop',...
        'timing.DASLoop','VR.velIntent','VR.accIntent','VR.decoded_var','I_delta_acts','VR.OptoPos','VR.game_state'};
    cursorVarNames = {'targetNums','bcFlag','positions','targetPos','assumedInt','targetRad','timenow','looptime',...
        'joystick','acts','meanError','blockNums','inTarget','IdealFiringRates','RealFiringRates',...
        'Vel','elbow','shoulder','RawPower','NormData','idealActs','BinCounts',...
        'dataLoop','dataWaitLoop','fullLoop','dasLoop','velIntent','accIntent','decVar','idealDeltaActs','optoPos','gameState'};
    
    %now build the cursor struct
    rawData = dlmread(CursorFileName, '\t');
    
    for v=1:length(cursorColVars)
        idx = find(strcmp(cursorColVars{v},VR.CursorColumnRecord(:,2))==1);
        if ~isempty(idx)
            rawDataCols = VR.CursorColumnRecord{idx,1};
            Cursor.(cursorVarNames{v}) = rawData(:,rawDataCols(1):rawDataCols(2));
        end
    end
    
    Cursor.timeStep = rawData(:, 1); 
    Cursor.CursorFileName = CursorFileName;
end