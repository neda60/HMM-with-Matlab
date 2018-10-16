function [] = wk_fposition(fpos,X,Y)
% pos = wk_fposition(fpos)
% resize the fig to quarter of screen (in width and hight),
% and put it in the required position (quarter of screen)
%
% fpos is: 'TL', 'TR', 'BL', 'BR' 
% for Top-left, Top-Right, Bottom-Left, and Bottom-Right
 
% Wael Khreich: 27 August 2008 - 09:31:41

if nargin<2
    X = 1;
end
if nargin<3
     Y = 1;
end

scrsz = get(0,'ScreenSize');
w = scrsz(3);
h = scrsz(4);
w = w*X;
h = h*Y;
switch upper(fpos)
    case 'TL' % Top-Left
        % pos = [1, w/2, w/2, h/2];
        pos = [2, w/2, w/2, h/2];  
    case 'TR' % Top-Right
        pos = [w/2, w/2, w/2, h/2];
    case 'BL' % Bottom-Left
        % pos = [1, 1, w/2, h/2];
        pos = [2, 2, w/2, h/2];     
    case 'BR' % Bottom-Right
        pos = [w/2, 1, w/2, h/2];
	otherwise
		pos = [360,280,560,420];
		fprintf(1,'!!! figure position is set to default !!!\n')
end
set(gcf,'Position',pos); % default units

