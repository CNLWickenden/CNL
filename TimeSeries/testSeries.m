load('C:\Documents and Settings\CNL\My Documents\GitHub\CNL\WinnieExample\WNR121121\P_WNR121121003');
ts = cnl_TimeSeries(P.Cursor.positions(1:100,:),P.Cursor.timenow(1:100,:));
ts.integrate();

ds = diff(ts.signal(:,1))./diff(ts.timeline);

figure
hold on
plot(ts.signal(:,1));
plot(ds,'r');