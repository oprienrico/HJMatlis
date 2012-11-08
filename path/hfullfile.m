function fpath = hfullfile(varargin)
%fullpath = hfullfile(folder, filename)

if length(varargin) < 2
	error('you do not need this function to do that');
	return;
end

%sub functions
option_found = @(x, y) hstrcmp(x, y, 'mixall');
num_back = @(s) length(regexp(s,'\.\./'));

%options available
options_available_unix = {'unixlike','-unix'};
options_available_a = {'absolute','-a'};
num_option_found = 0;

%defaults
outpath = ''; %default 'relative', so its empty
separator = filesep; %getting system dependant fileseparator

%OPTIONS MANAGEMENT
vars = varargin;
if option_found(options_available_unix, vars)
    vars(find(hstrcmp(options_available_unix, vars, 'matchsecond')))=[];%delete used options
    separator = '/';
end
if option_found(options_available_a, vars)
	vars(find(hstrcmp(options_available_a, vars, 'matchsecond')))=[];%delete used options
	outpath = strcat(pwd,separator);
end

if length(vars)<1
	error('not enough folders specified');
	return;
end

%GETTING DIRS
dirs_raw = vars;
clear vars;


for i = 1:length(dirs_raw)
	
	extracted_dirs = regexp(dirs_raw{i},'\\|/','split');
	if i==1
		outpath=relative_path(outpath, extracted_dirs{1}, separator);
		extracted_dirs(1)=[];
	end

	%endarr = length(dirs)-nback
	for j = 1:length(extracted_dirs)
		outpath=fix_back_relative_path(outpath, extracted_dirs{j}, separator);
	end
end

fpath = outpath;

function outPath = relative_path(oldPath, newPath, separator)
	if isempty(newPath)
		outpath = oldPath;
	elseif isempty(oldPath)
		outpath = newPath;
	else
		outpath = strcat(oldPath, separator, newPath);
	end
		%deleting multiple separators
	outpath = regexprep(outpath, '//', '/');
	outpath = regexprep(outpath, '///', '/');
	outpath = regexprep(outpath, '\\\\', '\');
	outpath = regexprep(outpath, '\\\\\\', '\');

	outPath = outpath;

function outPath = fix_back_relative_path(oldPath, newPath, separator)
	if isempty(newPath)
		outpath = oldPath;
	elseif isempty(oldPath)
		outpath = newPath;
	elseif strcmp(newPath, '..')
		outpath = parent_folder(oldPath, 1);
	else
		outpath = strcat(oldPath, separator, newPath);
	end
		%deleting multiple separators
	outpath = regexprep(outpath, '//', '/');
	outpath = regexprep(outpath, '///', '/');
	outpath = regexprep(outpath, '\\\\', '\');
	outpath = regexprep(outpath, '\\\\\\', '\');

	outPath = outpath;