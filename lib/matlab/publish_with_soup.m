function [ret] = publish_with_soup
%% Script publish_with_soup
%  
%  file:   publish_with_soup.m
%  author: Peter Polcz <ppolcz@gmail.com> 
%  
%  Created on 2017.08.05. Saturday, 01:28:25
%
%%

G = pglobals;

% Get active editor
active = matlab.desktop.editor.getActive;
f = pcz_resolvePath(active.Filename);

% Load persistent object from the base workspace
try c = evalin('base','persist'); catch; c = []; end
persist = pcz_persist(f.path, c);

% Publish options
opt.format = 'html';
opt.outputDir = persist.pub_absdir;
opt.stylesheet = [G.ROOT '/publish.xsl' ];

% Publis + tidy html code
pub_output = publish(f.path, opt); 

php = [G.VIEW_SCRIPTS '/' persist.pub_dirname '.php'];

%system([ 'tidy -im ' pub_output])
fprintf('\ngenerated output: \n%s\n\n', pub_output)

system([ G.SANITIZER ' ' persist.pub_absdir '/' f.bname '.html ' php ])

% Copy html code to clipboard
persist.pub_html = sprintf('<a class="" href="<?php echo base_url(''index.php/main/script/%s.php'') ?>">%s</a>', ...
    persist.pub_dirname, f.bname);
clipboard('copy', persist.pub_html);

% Update persist object of the base workspace
persist.pub_output = pub_output;
assignin('base', 'persist', persist)

subl(php)
% open(pub_output)


end