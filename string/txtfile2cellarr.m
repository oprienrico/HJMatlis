function [ cellarr_out ] = txtfile2cellarr(file_path,txt_sep)
%[ cellarr_out ] = txtfile2cellarr(file_path [,txt_sep])
%   read a txt file and parse it in a cell array with the txt separator
%   specified (default is '\t' (TAB))

    if ~exist('txt_sep','var')
        txt_sep='\t';
    end
    
    br = java.io.BufferedReader(java.io.FileReader(file_path));
    A={}; 
    err_f=false;
    try
        line = java.lang.String;
        c=0;
        while ~is_null(line)
            if c>0
                fields_found=line.split(txt_sep, -1);
                A{c}=cell(fields_found);
            end
            c=c+1;
            line = br.readLine();

        end
    catch
        br.close();
        error('error while reading');
        return
    end
    
    br.close();

    max_width=0;
    for i=1:length(A)
        if max_width<length(A{i})
            max_width=length(A{i});
        end
    end

    cellarr_out=cell(length(A),max_width);
    for i=1:length(A)
        for j=1:length(A{i})
            cellarr_out{i,j}=A{i}{j};
        end
    end
end

function flag=is_null(value)
    if isempty(value)
        if strcmp(value,'')
            flag=false;
        else
            flag=true;
        end
    else
        flag=false;
    end        
end
