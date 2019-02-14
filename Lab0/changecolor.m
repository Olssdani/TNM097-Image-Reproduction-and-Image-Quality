function changecolor(n)
% CHANGECOLOR  Assisting file to the application called "sliders".
%              This function is called when ever any of the six
%              sliders in the application is moved. It updates
%              the colormap and the value strings to the right
%              of the sliders
%

% Calculation of the next proper slider value.
CurVal = get(gco,'Value');
OldVal = get(gco,'UserData');
if OldVal+1<CurVal | OldVal-1>CurVal
  NewVal = round(CurVal);
else
  NewVal = OldVal+sign(CurVal-OldVal);
end
% Assigning the calculated value to the slider.
set(gco,'Value',NewVal,'UserData',NewVal);
% Assigning the calculated value to the value string,
% to the right of the slider.
ui_handles = get(gcf,'UserData');
set(ui_handles(6+n),'String',num2str(NewVal));

% Assigning a new proper colormap. First position is the reference
% color. Second is the current RGB color. And the third position in
% the colormap is the current HSV color, converted to RGB.
map=colormap;
ref=map(1,:);
rgb=map(2,:);
hsv=rgb2hsv(map(3,:));
maxvalue=128;
if n==1
  rgb(1)=NewVal/maxvalue;
elseif n==2
  rgb(2)=NewVal/maxvalue;
elseif n==3
  rgb(3)=NewVal/maxvalue;
elseif n==4
  hsv(1)=NewVal/maxvalue;
elseif n==5
  hsv(2)=NewVal/maxvalue;
elseif n==6
  hsv(3)=NewVal/maxvalue;
end
colormap([ref;rgb;hsv2rgb(hsv);map(4:size(map,1),:)]);
