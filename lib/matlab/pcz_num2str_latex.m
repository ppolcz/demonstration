function [ret] = pcz_num2str_latex(varargin)
%% 
%  
%  file:   pcz_num2str_latex.m
%  author: Polcz Péter <ppolcz@gmail.com> 
%  
%  Created on 2016.12.04. Sunday, 20:00:15
%

o.format = '%g';
o.del1 = ' & ';
o.del2 = ' \\\\ ';
o.pref = '';
o.beginning = '\\bmqty{ ';
o.ending = ' }';
o.round = 4;

first = 1;
while first <= nargin && isnumeric(varargin{first}), first = first+1; end
o = parsepropval(o,varargin{first:end});

nr = first-1;

if nargout > 0
    ret = cell(nr);
end

for i = 1:nr
%     fprintf('%s = ', inputname(i));
    
    o.var = varargin{i};
    if o.round > 0 
        o.var = round(o.var,o.round);
    end        

    str = pcz_num2str_fixed(o.var,o.format, o.del1, o.del2, o.pref, o.beginning, o.ending);
    
    if nargout > 0
        ret{i} = str;
    else
        disp(str)
    end

end

if nargout > 0
    if numel(ret) == 1
        ret = ret{1};
    end
end
end