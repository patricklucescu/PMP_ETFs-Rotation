close all
clear all
clc


Import;

A = Data(:, 2:end); % take only the numbers excluding dates
A = table2array(A); % convert
A = str2double(A); % convert

col = find(all(isnan(A),1));

% [row, col] = find(isnan(A)); % find column that are NaN

A(:,col)=[]; %erase them

col = col + 1;

b = sum(A,2); % sum along rows

index = find(b==0); % find rows that sum up to 0

Data(index,:)=[]; % erase them

Data(:,col) = [];

clear A b col row index

Data.("Dates") = dateshift(Data.("Dates"), 'start', 'day');
Data.("Dates").Format = 'dd-MM-yyyy';
for i = 2:length(Data.Properties.VariableNames)
    Data.Properties.VariableNames(i) = strrep(Data.Properties.VariableNames(i), "USEquity", "");
end
clear i