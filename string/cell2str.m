function [str_val] = cell2str(cell_val)
%[str_val] = cell2str(cell_val)
%convert single cell value to string (useful to parse some outputs in one
%liner code)
str_val=cell_val{1};
end

