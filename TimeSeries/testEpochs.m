load('C:\Documents and Settings\CNL\My Documents\GitHub\CNL\WinnieExample\WNR121121\P_WNR121121003');

threeIdx = P.Cursor.gameState==3;
oneIdx = P.Cursor.gameState==1;

centerIdx = P.Cursor.gameState;
centerIdx(threeIdx) = 0;

outerIdx = P.Cursor.gameState;
outerIdx(oneIdx) = 0;
outerIdx(threeIdx) = 1;

outerReaches = cnl_Epochs(outerIdx,P.Cursor.timenow);
centerReaches = cnl_Epochs(centerIdx,P.Cursor.timenow);

zerosAndOnesToEpochs(outerIdx,P.Cursor.timenow);