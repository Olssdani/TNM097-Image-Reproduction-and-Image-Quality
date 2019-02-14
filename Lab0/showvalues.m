function showvalues(arg)
% SHOWVALUES  Assisting file to the application called "sliders".
%             Shows the RGB or HSV values of the reference color,
%             depending on the input argument. Allowed input arguments
%             are 'rgb' and 'hsv'.
%

map=colormap;
rgb=round(128*map(1,:));
hsv=round(128*rgb2hsv(map(1,:)));
if arg=='rgb'
  ui_handles = get(gcf,'UserData');
  % Assign the right values to the strings.
  set(ui_handles(13),'String',['R:',int2str(rgb(1))])
  set(ui_handles(14),'String',['G:',int2str(rgb(2))])
  set(ui_handles(15),'String',['B:',int2str(rgb(3))])
  % Show the values.
  set(ui_handles(13),'Visible','on')
  set(ui_handles(14),'Visible','on')
  set(ui_handles(15),'Visible','on')
elseif arg =='hsv'
  ui_handles = get(gcf,'UserData');
  % Assign the right values to the strings.
  set(ui_handles(16),'String',['H:',int2str(hsv(1))])
  set(ui_handles(17),'String',['S:',int2str(hsv(2))])
  set(ui_handles(18),'String',['V:',int2str(hsv(3))])
  % Show the values.
  set(ui_handles(16),'Visible','on')
  set(ui_handles(17),'Visible','on')
  set(ui_handles(18),'Visible','on')
end