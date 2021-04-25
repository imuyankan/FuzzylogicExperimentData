load WIFIPDRFUZZYHEADING

%读取数据
head_difference=WIFIPDRFUZZYHEADING(:,28);%航向误差
pdr_heading=WIFIPDRFUZZYHEADING(:,5);%PDR航向
magnetic_heading=WIFIPDRFUZZYHEADING(:,4);%磁力计航向
kalman_heading=WIFIPDRFUZZYHEADING(:,3);%KALMAN航向

stepLength = WIFIPDRFUZZYHEADING(:,2);%步长
N=length(stepLength);%总步数
magHeadingDelta = zeros(N,0);
gyroHeadingDelta =zeros(N,0);
for i = 1:N
    if i==1
       magHeadingDelta(i,1) = 0
       gyroHeadingDelta(i,1) =0;
    else
        magHeadingDelta(i,1) = abs(magnetic_heading(i,1)) - abs(magnetic_heading(i-1,1));
        gyroHeadingDelta(i,1) = abs(pdr_heading(i,1)) - abs(pdr_heading(i-1,1));
    end 

    
    if magHeadingDelta(i,1)  > pi
       magHeadingDelta(i,1)  = -pi + mod(magHeadingDelta(i,1) ,pi);
    elseif magHeadingDelta(i,1)  < -pi
      magHeadingDelta(i,1) = pi + mod(magHeadingDelta(i,1) ,pi);
    end  
       if gyroHeadingDelta(i,1)  > pi
       gyroHeadingDelta(i,1)  = -pi + mod(gyroHeadingDelta(i,1) ,pi);
    elseif magHeadingDelta(i,1)  < -pi
      gyroHeadingDelta(i,1) = pi + mod(gyroHeadingDelta(i,1) ,pi);
    end  
    
end 


head_difference = abs(magHeadingDelta-gyroHeadingDelta);
%计算每一步PDR误差
oneStepPDRErrors =zeros(N,2)
for i = 1:N
    oneStepPDRErrors(i,1)=i;
% 
%     
%     if head_difference(i,1) > pi
%        head_difference(i,1) = -pi + mod(head_difference(i,1),pi);
%     elseif head_difference(i,1) < -pi
%       head_difference(i,1)= pi + mod(head_difference(i,1),pi);
%     end  
    oneStepPDRErrors(i,2)=stepLength(i,1)*abs(head_difference(i,1));
    
end 

save oneStepPDRErrors
%读取模糊控制器
wifipdrfuzzy2 = readfis('wifipdrfuzzy2.fis');


figure(50)
set(gcf,'units','centimeter','position',[5,5,8,8],'PaperPositionMode','auto');%设计图窗大小
set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
set(gcf,'color','w');%设置图窗颜色为白色
plotmf(wifipdrfuzzy2,'input',2)
set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Remaining Energy','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
ylabel('Degrees of memebership','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
 set(gca,'XTick',[0:0.2:1]) 
 set(gca,'YTick',[0:0.2:1])
 set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1);
 print('membership_input_remain_power','-depsc','-tiff', '-r600')
  
figure(51)

set(gcf,'units','centimeter','position',[5,5,8,8],'PaperPositionMode','auto');%设计图窗大小
set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
set(gcf,'color','w');%设置图窗颜色为白色
plotmf(wifipdrfuzzy2,'input',1)
set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('System Error','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
ylabel('Degrees of memebership','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
 set(gca,'XTick',[0:0.2:1]) 
 set(gca,'YTick',[0:0.2:1])
  set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1);
  print('membership_input_fusion_system_errors','-depsc','-tiff', '-r600')


figure(52)

set(gcf,'units','centimeter','position',[5,5,8,8],'PaperPositionMode','auto');%设计图窗大小
set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
set(gcf,'color','w');%设置图窗颜色为白色
plotmf(wifipdrfuzzy2,'output',1)
set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Probability of WiFi Scan','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
ylabel('Degrees of memebership','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
 set(gca,'XTick',[0:0.2:1]) 
 set(gca,'YTick',[0:0.2:1])
  set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1);
  print('membership_output_probability_ap_scan','-depsc','-tiff', '-r600')


figure(53)
 set(gcf,'units','centimeter','position',[5,5,10.5,8],'PaperPositionMode','auto');%设计图窗大小
set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
set(gcf,'color','w');%设置图窗颜色为白色
gensurf(wifipdrfuzzy2)
set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Remaining Energy','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
ylabel('System Error','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
zlabel('Probability of WiFi Scan','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
%  set(gca,'XTick',[0:0.2:1]) 
%  set(gca,'YTick',[0:0.2:1])
%   set(gca,'ZTick',[0:0.2:1])
  set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1);
  grid off
  print('fuzzy_logic_surfview','-depsc','-tiff', '-r600')

  figure(54)
set(gcf,'units','centimeter','position',[5,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
set(gcf,'color','w');%设置图窗颜色为白色
plot(head_difference,'-r*');
set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
ylabel('Heading Difference (rad)','FontSize',12,'FontName','Times New Roman','FontWeight','bold'); 
 set(gca,'XLim',[0 N+10])
 set(gca,'YLim',[0 0.8])
 set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1);
   set(gca,'Position',[0.076 0.14  0.89 0.84]);
    legend('Heading Difference')
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.676217231410294 0.792696629213483 0.258637634557689 0.0999999999999998]);
 print('heading_difference','-depsc','-tiff', '-r600')
  
%surfview(wifipdrfuzzy2)


  