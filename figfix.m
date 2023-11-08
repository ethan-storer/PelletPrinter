function [fwidth, fheight] = figfix(style,fsize)
% figfix
% This function adjusts the font size and figure size
% 'style': string defining the figure style
%       'Print1' - single column print with W=4/3H
%       'Print2' - 2 column print out with W = 5/2H

% 'fsize': fontsize (number) in pts
set(gca,'ActivePositionProperty','Outerposition');

s = 1;

if exist('fsize','var')==0
    fsize = 20;
elseif exist('style','var')==1
    %the fontsize for the plot was defined in the function call
end

if exist('style','var')==0
    style  = 'ME333';  %if no style is applied, set default
elseif exist('style','var')==1
    %the style for the plot was defined in the function call
else
    disp('Is style defined or not???')
    return
end

switch style
    case 'ME270HW'
        fwidth = 4;
        fheight = 4;
    case 'Print1'
        % Standard Printout
        fwidth = 3.25;
        fheight = .75*fwidth;
    case 'Print2'
        % Wide Printout
        fwidth = 6.5;
        fheight = 0.4*fwidth;   %This is the figure height in inches
    case 'Print3'
        % Standard Printout
        fwidth = 2.9;
        fheight = 1.49;
    case 'Print4' %Single Column Tall
        fsize = 10;
        fwidth = 3.25 *s;
        fheight = 1.1 * fwidth;
    case 'Gold'
        % Golden ratio
        % fheight = 2/(1+sqrt(5))*fwidth;   %This is the figure height in inches
    case 'Pres1'
        fwidth = 4.5;
        fheight = 5;
    case 'Poster'
        fwidth = 6;
        fheight = .75*fwidth;
    case 'PosterTall'
        fwidth = 5;
        fheight = 5;
    case 'BigPic'
        fwidth = 5.5;
        fheight = 6;
    case {'ME270','ME333', 'ME373','ME490'}
        fwidth = 10;
        fheight = 6;
    case 'WordCloud'
        fwidth  = 8;
        fheight = 6; 
        case 'ES15'
        fwidth = 5;
        fheight = .75*fwidth;
    case 'ES16'
        fwidth = 4.;
        fheight = 4.;
    case 'ES_deltas'
        fwidth = 5.7;
        fheight = 5.4;
    otherwise
        disp('Select a "style"!')
        return
end


%% Adjust the Figure Size (formerly adjfigsize.m)
% This section adjusts the dimensions of the current figure based on the
% inputs:
% fwidth - This is the desired width of the figure in inches.  Must be
% defined in the calling script

figtouse = gcf;
set(gcf,'Units','inches');
Coord=get(figtouse,'Position');
% fwidth = 3.25;

% Note:
% Coord(1) is your x
% Coord(2) is your y
% Coord(3) is your width
% Coord(4) is your height

% Define modified dimensions
NewWidth = fwidth;
NewHeight = fheight;

% Then set the new handles.

set(figtouse,'Position',[Coord(1),Coord(2),NewWidth,NewHeight]);

%% Set Figure Colors
set(gca, 'Color', [1 1 1]); % Sets axes background
set(gcf, 'Color', [1 1 1]); % Sets figure background

if strcmp(style,  'WordCloud')
    whitebg(gcf,'k')
    set(gcf,'Color','none')
    set(gcf,'InvertHardcopy','off')
    hText = findall(findobj(gcf),'Type','text'); 
    set(hText,'BackgroundColor','none')
else
end
%%  Adjust the Font Size
% The following lines grab annotation, title, and axis label handles, then
% set the font size.
hText = findall(findobj(gcf),'Type','text'); 
set(hText,'FontSize',fsize);
alldatacursors = findall(gcf,'type','hggroup');
set(alldatacursors,'FontSize',fsize);
set(get(gca,'Ylabel'),'FontSize',fsize);
set(get(gca,'Xlabel'),'FontSize',fsize);
set(get(gca,'Title'),'FontSize',fsize);
set(gca,'FontSize',fsize);
try 
    ff = gcf;
    set(ff.Children(1),'FontSize',fsize)
    set(ff.Children(2),'FontSize',fsize)
catch
end

box on
movegui('onscreen')
return