%1.5PDR误差,电量10%，30%，100%情况下融合误差
 figure(300);
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
 set(gca,'Position',[0.076 0.14  0.89 0.83]);
 plot(errors_pdrwififuzzyCopy05_01,'r-','LineWidth',1);%PDR误差
 hold on
 plot(errors_pdrwififuzzyCopy05_03,'b-','LineWidth',1);%PDR误差
  hold on
 plot(errors_pdrwififuzzyCopy05_10,'g-','LineWidth',1);%PDR误差
  set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Errors (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
  legend('Power Level=10%','Power Level=30%','Power Level=100%');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold',  'Position',[0.5432865367006 0.751987476074121 0.260029711748126 0.184316474350679]);
  set(gca,'XLim',[0 N+10]);
 print('errors_comparation_of_different_parameter15_010310','-depsc','-tiff', '-r600')

 %%1.5PDR误差,电量10%，30%，100%情况下融合误差的CDF
figure(301);
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
 set(gca,'Position',[0.076 0.14  0.89 0.83]);
a=cdfplot(errors_pdrwififuzzyCopy05_01)
set( a, 'LineStyle', '-', 'Color', 'r','linewidth',1);
hold on
d=cdfplot(errors_pdrwififuzzyCopy05_03)
set( d, 'LineStyle', '-', 'Color', 'b','linewidth',1);
 
hold on
c=cdfplot(errors_pdrwififuzzyCopy05_10)
set( c, 'LineStyle', '-', 'Color', 'g','linewidth',1);
hold on
 
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Errors (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('CDF','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
  legend('Power Level=10%','Power Level=30%','Power Level=100%');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.663688974079211 0.189522932183595 0.260029711748126 0.164021159527163]);
 title(' ')
 grid off
 print('CDF_errors_of_different_parameter15_010310','-depsc','-tiff', '-r600')
 
 
%电量100%不同PDR误差情况下融合误差
 figure(302);
  set(gcf,'units','centimeter','position',[20,5,17.8,9.2],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
 set(gca,'Position',[0.076 0.14  0.89 0.83]);
 plot(errors_pdrwififuzzyCopy05_10,'r-','LineWidth',1);%PDR误差
 hold on
 plot(errors_pdrwififuzzyCopy20_10,'b-','LineWidth',1);%PDR误差
  hold on
 plot(errors_pdrwififuzzyCopy40_10,'g-','LineWidth',1);%PDR误差
 
  set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Errors (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
  legend('System Error Threshold=0.5','System Error Threshold=2.0','System Error Threshold=4.0');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.597794294283357 0.757264291728747 0.353768717864884 0.184316474350679]);
  set(gca,'XLim',[0 N+10]);
  set(gca,'Ylim',[0,9]);
 print('errors_comparation_of_different_parameter153045_100','-depsc','-tiff', '-r600')

 %电量100%不同PDR误差情况下融合误差的CDF
figure(303);
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
 set(gca,'Position',[0.076 0.14  0.89 0.83]);
a=cdfplot(errors_pdrwififuzzyCopy05_10)
set( a, 'LineStyle', '-', 'Color', 'r','linewidth',1);
hold on
d=cdfplot(errors_pdrwififuzzyCopy20_10)
set( d, 'LineStyle', '-', 'Color', 'b','linewidth',1);
 
hold on
c=cdfplot(errors_pdrwififuzzyCopy40_10)
set( c, 'LineStyle', '-', 'Color', 'g','linewidth',1);
hold on
 
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Errors (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('CDF','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
  legend('System Error Threshold=0.5','System Error Threshold=2.0','System Error Threshold=4.0');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.582628501953136 0.213845421499481 0.353768717864884 0.184316474350679]);
 title(' ')
 grid off
 print('CDF_errors_of_different_parameter153045_100','-depsc','-tiff', '-r600')
 
 
 errors05(1,1:3) = [mean(errors_pdrwififuzzyCopy05_01) max(errors_pdrwififuzzyCopy05_01) min(errors_pdrwififuzzyCopy05_01)]
 errors05(2,1:3) = [mean(errors_pdrwififuzzyCopy05_02) max(errors_pdrwififuzzyCopy05_02) min(errors_pdrwififuzzyCopy05_02)]
 errors05(3,1:3) = [mean(errors_pdrwififuzzyCopy05_03) max(errors_pdrwififuzzyCopy05_03) min(errors_pdrwififuzzyCopy05_03)]
 errors05(4,1:3) = [mean(errors_pdrwififuzzyCopy05_04) max(errors_pdrwififuzzyCopy05_04) min(errors_pdrwififuzzyCopy05_04)]
 errors05(5,1:3) = [mean(errors_pdrwififuzzyCopy05_05) max(errors_pdrwififuzzyCopy05_05) min(errors_pdrwififuzzyCopy05_05)]
 errors05(6,1:3) = [mean(errors_pdrwififuzzyCopy05_06) max(errors_pdrwififuzzyCopy05_06) min(errors_pdrwififuzzyCopy05_06)]
 errors05(7,1:3) = [mean(errors_pdrwififuzzyCopy05_07) max(errors_pdrwififuzzyCopy05_07) min(errors_pdrwififuzzyCopy05_07)]
 errors05(8,1:3) = [mean(errors_pdrwififuzzyCopy05_08) max(errors_pdrwififuzzyCopy05_08) min(errors_pdrwififuzzyCopy05_08)]
 errors05(9,1:3) = [mean(errors_pdrwififuzzyCopy05_09) max(errors_pdrwififuzzyCopy05_09) min(errors_pdrwififuzzyCopy05_09)]
 errors05(10,1:3) = [mean(errors_pdrwififuzzyCopy05_10) max(errors_pdrwififuzzyCopy05_10) min(errors_pdrwififuzzyCopy05_10)]


 errors(1,1:3) = [mean(errors_pdrwififuzzyCopy15_01) max(errors_pdrwififuzzyCopy15_01) min(errors_pdrwififuzzyCopy15_01)]
 errors(2,1:3) = [mean(errors_pdrwififuzzyCopy15_02) max(errors_pdrwififuzzyCopy15_02) min(errors_pdrwififuzzyCopy15_02)]
 errors(3,1:3) = [mean(errors_pdrwififuzzyCopy15_03) max(errors_pdrwififuzzyCopy15_03) min(errors_pdrwififuzzyCopy15_03)]
 errors(4,1:3) = [mean(errors_pdrwififuzzyCopy15_04) max(errors_pdrwififuzzyCopy15_04) min(errors_pdrwififuzzyCopy15_04)]
 errors(5,1:3) = [mean(errors_pdrwififuzzyCopy15_05) max(errors_pdrwififuzzyCopy15_05) min(errors_pdrwififuzzyCopy15_05)]
 errors(6,1:3) = [mean(errors_pdrwififuzzyCopy15_06) max(errors_pdrwififuzzyCopy15_06) min(errors_pdrwififuzzyCopy15_06)]
 errors(7,1:3) = [mean(errors_pdrwififuzzyCopy15_07) max(errors_pdrwififuzzyCopy15_07) min(errors_pdrwififuzzyCopy15_07)]
 errors(8,1:3) = [mean(errors_pdrwififuzzyCopy15_08) max(errors_pdrwififuzzyCopy15_08) min(errors_pdrwififuzzyCopy15_08)]
 errors(9,1:3) = [mean(errors_pdrwififuzzyCopy15_09) max(errors_pdrwififuzzyCopy15_09) min(errors_pdrwififuzzyCopy15_09)]
 errors(10,1:3) = [mean(errors_pdrwififuzzyCopy15_10) max(errors_pdrwififuzzyCopy15_10) min(errors_pdrwififuzzyCopy15_10)]
 
 errors30(1,1:3) = [mean(errors_pdrwififuzzyCopy30_01) max(errors_pdrwififuzzyCopy30_01) min(errors_pdrwififuzzyCopy30_01)]
 errors30(2,1:3) = [mean(errors_pdrwififuzzyCopy30_02) max(errors_pdrwififuzzyCopy30_02) min(errors_pdrwififuzzyCopy30_02)]
 errors30(3,1:3) = [mean(errors_pdrwififuzzyCopy30_03) max(errors_pdrwififuzzyCopy30_03) min(errors_pdrwififuzzyCopy30_03)]
 errors30(4,1:3) = [mean(errors_pdrwififuzzyCopy30_04) max(errors_pdrwififuzzyCopy30_04) min(errors_pdrwififuzzyCopy30_04)]
 errors30(5,1:3) = [mean(errors_pdrwififuzzyCopy30_05) max(errors_pdrwififuzzyCopy30_05) min(errors_pdrwififuzzyCopy30_05)]
 errors30(6,1:3) = [mean(errors_pdrwififuzzyCopy30_06) max(errors_pdrwififuzzyCopy30_06) min(errors_pdrwififuzzyCopy30_06)]
 errors30(7,1:3) = [mean(errors_pdrwififuzzyCopy30_07) max(errors_pdrwififuzzyCopy30_07) min(errors_pdrwififuzzyCopy30_07)]
 errors30(8,1:3) = [mean(errors_pdrwififuzzyCopy30_08) max(errors_pdrwififuzzyCopy30_08) min(errors_pdrwififuzzyCopy30_08)]
 errors30(9,1:3) = [mean(errors_pdrwififuzzyCopy30_09) max(errors_pdrwififuzzyCopy30_09) min(errors_pdrwififuzzyCopy30_09)]
 errors30(10,1:3) = [mean(errors_pdrwififuzzyCopy30_10) max(errors_pdrwififuzzyCopy30_10) min(errors_pdrwififuzzyCopy30_10)]
 
  errors20(1,1:3) = [mean(errors_pdrwififuzzyCopy20_01) max(errors_pdrwififuzzyCopy20_01) min(errors_pdrwififuzzyCopy20_01)]
 errors20(2,1:3) = [mean(errors_pdrwififuzzyCopy20_02) max(errors_pdrwififuzzyCopy20_02) min(errors_pdrwififuzzyCopy20_02)]
 errors20(3,1:3) = [mean(errors_pdrwififuzzyCopy20_03) max(errors_pdrwififuzzyCopy20_03) min(errors_pdrwififuzzyCopy20_03)]
 errors20(4,1:3) = [mean(errors_pdrwififuzzyCopy20_04) max(errors_pdrwififuzzyCopy20_04) min(errors_pdrwififuzzyCopy20_04)]
 errors20(5,1:3) = [mean(errors_pdrwififuzzyCopy20_05) max(errors_pdrwififuzzyCopy20_05) min(errors_pdrwififuzzyCopy20_05)]
 errors20(6,1:3) = [mean(errors_pdrwififuzzyCopy20_06) max(errors_pdrwififuzzyCopy20_06) min(errors_pdrwififuzzyCopy20_06)]
 errors20(7,1:3) = [mean(errors_pdrwififuzzyCopy20_07) max(errors_pdrwififuzzyCopy20_07) min(errors_pdrwififuzzyCopy20_07)]
 errors20(8,1:3) = [mean(errors_pdrwififuzzyCopy20_08) max(errors_pdrwififuzzyCopy20_08) min(errors_pdrwififuzzyCopy20_08)]
 errors20(9,1:3) = [mean(errors_pdrwififuzzyCopy20_09) max(errors_pdrwififuzzyCopy20_09) min(errors_pdrwififuzzyCopy20_09)]
 errors20(10,1:3) = [mean(errors_pdrwififuzzyCopy20_10) max(errors_pdrwififuzzyCopy20_10) min(errors_pdrwififuzzyCopy20_10)]
 

 
  errors40(1,1:3) = [mean(errors_pdrwififuzzyCopy40_01) max(errors_pdrwififuzzyCopy40_01) min(errors_pdrwififuzzyCopy40_01)]
 errors40(2,1:3) = [mean(errors_pdrwififuzzyCopy40_02) max(errors_pdrwififuzzyCopy40_02) min(errors_pdrwififuzzyCopy40_02)]
 errors40(3,1:3) = [mean(errors_pdrwififuzzyCopy40_03) max(errors_pdrwififuzzyCopy40_03) min(errors_pdrwififuzzyCopy40_03)]
 errors40(4,1:3) = [mean(errors_pdrwififuzzyCopy40_04) max(errors_pdrwififuzzyCopy40_04) min(errors_pdrwififuzzyCopy40_04)]
 errors40(5,1:3) = [mean(errors_pdrwififuzzyCopy40_05) max(errors_pdrwififuzzyCopy40_05) min(errors_pdrwififuzzyCopy40_05)]
 errors40(6,1:3) = [mean(errors_pdrwififuzzyCopy40_06) max(errors_pdrwififuzzyCopy40_06) min(errors_pdrwififuzzyCopy40_06)]
 errors40(7,1:3) = [mean(errors_pdrwififuzzyCopy40_07) max(errors_pdrwififuzzyCopy40_07) min(errors_pdrwififuzzyCopy40_07)]
 errors40(8,1:3) = [mean(errors_pdrwififuzzyCopy40_08) max(errors_pdrwififuzzyCopy40_08) min(errors_pdrwififuzzyCopy40_08)]
 errors40(9,1:3) = [mean(errors_pdrwififuzzyCopy40_09) max(errors_pdrwififuzzyCopy40_09) min(errors_pdrwififuzzyCopy40_09)]
 errors40(10,1:3) = [mean(errors_pdrwififuzzyCopy40_10) max(errors_pdrwififuzzyCopy40_10) min(errors_pdrwififuzzyCopy40_10)]
 

 errors45(1,1:3) = [mean(errors_pdrwififuzzyCopy45_01) max(errors_pdrwififuzzyCopy45_01) min(errors_pdrwififuzzyCopy45_01)]
 errors45(2,1:3) = [mean(errors_pdrwififuzzyCopy45_02) max(errors_pdrwififuzzyCopy45_02) min(errors_pdrwififuzzyCopy45_02)]
 errors45(3,1:3) = [mean(errors_pdrwififuzzyCopy45_03) max(errors_pdrwififuzzyCopy45_03) min(errors_pdrwififuzzyCopy45_03)]
 errors45(4,1:3) = [mean(errors_pdrwififuzzyCopy45_04) max(errors_pdrwififuzzyCopy45_04) min(errors_pdrwififuzzyCopy45_04)]
 errors45(5,1:3) = [mean(errors_pdrwififuzzyCopy45_05) max(errors_pdrwififuzzyCopy45_05) min(errors_pdrwififuzzyCopy45_05)]
 errors45(6,1:3) = [mean(errors_pdrwififuzzyCopy45_06) max(errors_pdrwififuzzyCopy45_06) min(errors_pdrwififuzzyCopy45_06)]
 errors45(7,1:3) = [mean(errors_pdrwififuzzyCopy45_07) max(errors_pdrwififuzzyCopy45_07) min(errors_pdrwififuzzyCopy45_07)]
 errors45(8,1:3) = [mean(errors_pdrwififuzzyCopy45_08) max(errors_pdrwififuzzyCopy45_08) min(errors_pdrwififuzzyCopy45_08)]
 errors45(9,1:3) = [mean(errors_pdrwififuzzyCopy45_09) max(errors_pdrwififuzzyCopy45_09) min(errors_pdrwififuzzyCopy45_09)]
 errors45(10,1:3) = [mean(errors_pdrwififuzzyCopy45_10) max(errors_pdrwififuzzyCopy45_10) min(errors_pdrwififuzzyCopy45_10)]
 
 meanerrorscf= mean(errors_compliloc)
 
%  figure(304)
% plot(errors(:,1),'-r*');hold on; 
% plot(errors(:,2),'-g*'); hold on;
% plot(errors(:,3),'-b*')
%  figure(305)
% plot(errors30(:,1),'-r*');hold on; 
% plot(errors30(:,2),'-g*'); hold on;
% plot(errors30(:,3),'-b*')
%  figure(306)
% plot(errors45(:,1),'-r*');hold on; 
% plot(errors45(:,2),'-g*'); hold on;
% plot(errors45(:,3),'-b*')

%  figure(307)
%  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
%  set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
%  set(gcf,'color','w');%设置图窗颜色为白色 
%  set(gca,'Position',[0.076 0.14  0.89 0.84]);
%  x=[10:10:100]
%  plot(x,errors05(:,1),'r*-','LineWidth',1);%PDR误差
%  hold on
%  plot(x,errors40(:,1),'bp-','LineWidth',1);%PDR误差
%   hold on
%  plot(x,errors45(:,1),'g+-','LineWidth',1);%PDR误差
%   set(gca,'XLim',[0 100]);
%   set(gca,'YLim',[0 5]); 
%  set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
%  xlabel('Power Level (%)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
%  ylabel('Mean Errors (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
%  legend('Error Threshold=0.5','Error Threshold=3.0','Error Threshold=4.5');
%  set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
%  print('errors_comparation_of_different_parameter103045_10to100','-depsc','-tiff', '-r600')
%  
 figure(308)
 set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
 set(gca,'Position',[0.076 0.14  0.89 0.83]);
 x=[10:10:100]
 plot(x,apscan05,'r*-','LineWidth',1);%PDR误差
 hold on
 plot(x,apscan20,'bp-','LineWidth',1);%PDR误差
  hold on
 plot(x,apscan40,'g+-','LineWidth',1);%PDR误差
%   set(gca,'XLim',[0 100]);
%   set(gca,'YLim',[1 40]); 
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Power Level (%)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('WiFi Scan Count','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend('System Error Threshold=0.5','System Error Threshold=2.0','System Error Threshold=4.0');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.638428944804357 0.60631800041869 0.2748885523157 0.184316474350679]);
 print('comparation_apscan_of_different_parameter103045_10to100','-depsc','-tiff', '-r600')
 
 energy_consumption05 = [ 11000,11000,12000,18000,18000,18000,18000,18000,18000,18000]'
 energy_consumption20 = [ 9000,9000,11000,16000,16000,16000,16000,16000,16000,16000]'
 energy_consumption40 = [ 8000,8000,9000,12000,12000,12000,12000,12000,12000,12000]'
 
 figure(309)
 set(gcf,'units','centimeter','position',[20,5,17.8,10],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
 set(gca,'Position',[0.076 0.14  0.89 0.80]);
 x=[10:10:100]
 plot(x,energy_consumption05,'r*-','LineWidth',1);%PDR误差
 hold on
 plot(x,energy_consumption20,'bp-','LineWidth',1);%PDR误差
  hold on
 plot(x,energy_consumption40,'g+-','LineWidth',1);%PDR误差
  set(gca,'XLim',[0 100]);
  set(gca,'YLim',[7000 20000]); 
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Power Level (%)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Energy Consumption ({\mu}Ah)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend('System Error Threshold=0.5','System Error Threshold=2.0','System Error Threshold=4.0');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.583453931012529 0.20540057768624 0.353640407323838 0.164021159527163]);
 print('comparation_energy_of_different_parameter103045_10to100','-depsc','-tiff', '-r600')
 
 
 figure(310)
 set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
 set(gca,'Position',[0.076 0.14  0.89 0.83]);
 x=[10:10:100]
 plot(x,errors05(:,1),'r*-','LineWidth',1);%PDR误差
 hold on
 plot(x,errors20(:,1),'bp-','LineWidth',1);%PDR误差
  hold on
 plot(x,errors40(:,1),'g+-','LineWidth',1);%PDR误差
  set(gca,'XLim',[0 100]);
  set(gca,'YLim',[0 5]); 
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Power Level (%)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Mean Errors (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend('System Error Threshold=0.5','System Error Threshold=2.0','System Error Threshold=4.0');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.641406643325707 0.237103179658925 0.274888552315699 0.184523804468058]);
 print('errors_comparation_of_different_parameter103045_10to100','-depsc','-tiff', '-r600')
 
 figure(311)
 set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
 set(gca,'Position',[0.078 0.14  0.89 0.84]);
 x=[10:10:100]
 plot(x,apscan05,'r*-','LineWidth',1);%PDR误差
 hold on
 plot(x,apscan20,'bp-','LineWidth',1);%PDR误差
  hold on
 plot(x,apscan40,'g+-','LineWidth',1);%PDR误差
%   set(gca,'XLim',[0 100]);
%   set(gca,'YLim',[1 40]); 
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Power Level (%)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('AP Scan Count','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend('System Error Threshold=0.5','System Error Threshold=2.0','System Error Threshold=4.0');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.638428944804357 0.60631800041869 0.2748885523157 0.184316474350679]);
 print('comparation_apscan_of_different_parameter103045_10to100','-depsc','-tiff', '-r600')
 
 
 figure(200)
 cdfplot(errors_pdrwififuzzyCopy05_01)
 hold on;
%   cdfplot(errors_pdrwififuzzyCopy05_02)
%   hold on;
%   cdfplot(errors_pdrwififuzzyCopy05_03)
%    hold on;
  cdfplot(errors_pdrwififuzzyCopy05_03)
   hold on;
%   cdfplot(errors_pdrwififuzzyCopy05_05)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy05_08)
%    hold on;
  cdfplot(errors_pdrwififuzzyCopy05_10)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy70_10)
   legend('10','30','100')
   %legend('05','20','40')
   
   
figure(201)
 cdfplot(errors_pdrwififuzzyCopy05_03)
%  hold on;
%   cdfplot(errors_pdrwififuzzyCopy10_10)
%   
   hold on;
  cdfplot(errors_pdrwififuzzyCopy20_03)
   hold on;
%   cdfplot(errors_pdrwififuzzyCopy30_10)
%    hold on;
  cdfplot(errors_pdrwififuzzyCopy40_03)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy50_10)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy60_10)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy70_10)
  %legend('05','10','20','30','40','50','60','70')
   legend('05','20','40')
  
   
   figure(202)
 cdfplot(newHeadingerror05_01)
%  hold on;
%   cdfplot(errors_pdrwififuzzyCopy10_10)
%   
   hold on;
  cdfplot(newHeadingerror05_03)
   hold on;
%   cdfplot(errors_pdrwififuzzyCopy30_10)
%    hold on;
  cdfplot(newHeadingerror05_10)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy50_10)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy60_10)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy70_10)
  %legend('05','10','20','30','40','50','60','70')
   legend('01','03','10')
   
    figure(203)
 plot(newHeadingerror05_01)
%  hold on;
%   cdfplot(errors_pdrwififuzzyCopy10_10)
%   
   hold on;
  plot(newHeadingerror05_03)
   hold on;
%   cdfplot(errors_pdrwififuzzyCopy30_10)
%    hold on;
  plot(newHeadingerror05_10)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy50_10)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy60_10)
%    hold on;
%   cdfplot(errors_pdrwififuzzyCopy70_10)
  %legend('05','10','20','30','40','50','60','70')
   legend('01','03','10')