function hidevalues
% HIDEVALUES  Assisting file to the application called "sliders".
%             Hides the RGB and HSV values of the current reference
%             color.
%

ui_handles = get(gcf,'UserData');
set(ui_handles(13),'Visible','off')
set(ui_handles(14),'Visible','off')
set(ui_handles(15),'Visible','off')
set(ui_handles(16),'Visible','off')
set(ui_handles(17),'Visible','off')
set(ui_handles(18),'Visible','off')