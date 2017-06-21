function newT=appendRow2Table(oldt,newRowAsCell)
header=oldt.Properties.VariableNames;
T2=cell2table(newRowAsCell);
T2.Properties.VariableNames=header;
newT=[oldt;T2];
end