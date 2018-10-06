function [ret] = pcz_dispFunction(varargin)
%% 
%  
%  file:   pcz_dispFunction.m
%  author: Polcz Péter <ppolcz@gmail.com> 
%  
%  Created on 2017.02.03. Friday, 13:44:19
%

%% make it back-compatible

if nargin == 0
    varargin = {''};
end

if nargin > 0 && iscell(varargin{1})
    varargin = varargin{1};
end

%%

global SCOPE_DEPTH VERBOSE

if ~VERBOSE
    return
end

% [ST,I] = dbstack;
% 
% for i = 2:SCOPE_DEPTH
%     fprintf('│   ')
% end

msg = sprintf(varargin{:});

% if numel(ST) > I    
%     if ~isempty(msg)
%         disp(['│   - ' msg])
%     else
%         disp '│   '
%     end
% else
%     disp(['- ' msg ])
% end


depth = SCOPE_DEPTH;

prefix = '';
if depth >= 1
    tab = '│   ';
    prefix = repmat(tab,[1 depth]);
end

if ~isempty(msg)
    disp([ prefix '- ' msg])
else
    disp([ prefix ' '])
end

if nargout > 0
    ret  = [];
end

end