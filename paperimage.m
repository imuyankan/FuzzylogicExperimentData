
% set(findall(gcf,'type','hggroup'),'FontSize',16);  %%设置数据游标（标尺）的字体大小
% 
% set(findall(gcf,'type','line'),'linewidth',2);%%设置全部线宽为2，默认为0.5
% 
% set(findall(gcf,'type','line'),'markersize',10);%%设置marker的大小为10，默认为6


%融合后的定位结果
 figure(1)
 set(gcf,'units','centimeter','position',[5,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色
 set(gca,'Position',[0.07 0.14  0.90 0.84]);
 p1 = scatter(fusion_loc(:,1),fusion_loc(:,2));
 set(p1,'LineWidth',1)
 set(p1,'MarkerEdgeColor',[  0   0  1])
 
 hold on
 p2 = scatter(fusion_pdr_wifi(:,1),fusion_pdr_wifi(:,2),20,'r*');
 set(p2,'LineWidth',1)
 set(p2,'MarkerEdgeColor',[  1   0  0])
 %title('Fuzzy Logic Based Fusion');

 %set(get(p1),'MarkerSize',20);
 g1=get(p1,'Parent');%对应p1所在的坐标轴
 set(g1,'Xlim',[-2 76]) 
 set(g1,'Ylim',[0 38])
 g2=get(p2,'Parent');%对应p1所在的坐标轴
 set(g2,'Xlim',[-2 78]) 
 set(g2,'Ylim',[-2 38])
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend([p1 p2],'Fusion Location','Initial Location of PDR');
 %'Orientation','horizontal',表示图例横放
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.570055094752171 0.286802214891813 0.300148581280574 0.126345970416058] );
 %xlabel('X (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Y (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 set(get(gca,'Xlabel'),'String','X (m)','FontSize',12,'FontName','Times New Roman'); 
 print('fusion_location_trace','-depsc','-tiff', '-r600')
 
 %wifi融合点显示
 figure(2)
 set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色

 [h1,h2]=plot_dir(fusion_loc(:,1),fusion_loc(:,2),'bo','b')

 hold on
 h3 = scatter(fusion_pdr_wifi(:,1),fusion_pdr_wifi(:,2),20,'r*');
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 g1=get(h1,'Parent');%对应p1所在的坐标轴
 set(g1,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold')
  set(g1,'Xlim',[-5 78]) 
 set(g1,'Ylim',[-5 38])
 %set(g1,'Position',[0.07 0.1344 0.9050 0.7906]);%这句是设置xy轴在图片中占的比例，可能需要自己微调。
 %set(g1,'Position',[0.02 0.1344 0.9950 0.7906]);%这句是设置xy轴在图片中占的比例，可能需要自己微调。
 set(gca,'Position',[0.005 0.14  1 0.84]);
  set(h1,'LineWidth',1)
  set(h2,'MarkerEdgeColor',[  0   0  1])
 
 %title('Fuzzy Logic Based Fusion ');
 legend('Fusion Location','Direction','Initial Location of PDR')
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.6,0.65,0.1,0.1]);
 %xlabel('X (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Y (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 set(get(gca,'Xlabel'),'String','X (m)','FontSize',12,'FontName','Times New Roman'); 
 grid off;
 print('fusion_result_with_arrow_direction','-depsc','-tiff', '-r600')
 
 %欧式距离
 figure(3)
 set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色
 set(gca,'Position',[0.076 0.14  0.89 0.84]);
 plot(eur_distance(:,:),'g*-','LineWidth',1);
 hold on; 
 plot(eur_distance_wifi(:,:),'bo-','LineWidth',1);
 hold on;
 plot(eur_distance_pdr(:,:),'r+-','LineWidth',1);
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Fusion Point (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Distance (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend('WiFi and PDR','WiFi and Last Fusion','PDR and Last Fusion');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.153401220528731 0.437045005149925 0.282420405384488 0.20505207771513]);
 print('euclidean_distance_among_the_methods','-depsc','-tiff', '-r600')
 
 %融合权重
 figure(4)
 set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
  set(gca,'Position',[0.076 0.14  0.89 0.84]);
 plot(weight(1:M,:),'r*-','LineWidth',1);
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Fusion Point (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Weight','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend('Weight');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.75,0.2,0.1,0.1]);
 print('fusion_weight','-depsc','-tiff', '-r600')
 
 %wifi PDR定位结果
 figure(5);
 set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
  set(gca,'Position',[0.076 0.14  0.89 0.84]);
 p1=scatter(wifi_loc(:,1),wifi_loc(:,2),20,'gx');
 hold on
 p2=scatter(pdr_loc(:,1),pdr_loc(:,2),20,'m+');
 hold on
 p3=scatter(fusion_loc(:,1),fusion_loc(:,2),20,'b');
 hold on
 p4=scatter(true_loc(:,1),true_loc(:,2),14,'.');
 hold on
 p5=scatter(fusion_pdr_wifi(:,1),fusion_pdr_wifi(:,2),20,'r*');
 set(p1,'LineWidth',1)
 set(p1,'MarkerEdgeColor',[  0   1  0])
 set(p2,'LineWidth',1)
 set(p2,'MarkerEdgeColor',[  1   0  1])
 set(p3,'LineWidth',1)
 set(p3,'MarkerEdgeColor',[  0   0  1])
 set(p4,'LineWidth',1)
 set(p4,'MarkerEdgeColor',[  0 0 0])
 set(p5,'LineWidth',1)
 set(p5,'MarkerEdgeColor',[  1 0 0])
 g1=get(p1,'Parent');%对应p1所在的坐标轴
 set(g1,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold')
 set(g1,'Xlim',[-2 78]) 
 set(g1,'Ylim',[-20 38])
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('X (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Y (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend('WiFi','PDR','Fuzzy Logic Based Fusion','Reference');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.169416058858641 0.200459251585326 0.700105323080211 0.0698618897024108],'Orientation','horizontal');
 print('comparation_of_different_localization_methods','-depsc','-tiff', '-r600')

  
%误差对比
 figure(6);
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
 set(gca,'Position',[0.076 0.14  0.89 0.84]);
 plot(errors_pdr,'r-','LineWidth',1);%PDR误差
%  hold on
%  plot(errors_newpdr,'b-','LineWidth',1);%PDR误差
  hold on
 plot(errors_wifi,'m-','LineWidth',1);%PDR误差

  hold on 
 plot(errors_compliloc,'k-','LineWidth',1);%WiFi PDR 互补误差
  hold on 
 plot(errors_pdrwififuzzy,'g-','LineWidth',1);%WiFi PDR 模糊控制误差
  set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Errors (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
  legend('PDR','WiFi','CF Fusion','Fuzzy Logic Based Fusion');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.31,0.76,0.1,0.1]);
 set(gca,'XLim',[0 N+10]);
  set(gca,'YLim',[0 25]);
 print('errors_comparation_of_different_localization_methods','-depsc','-tiff', '-r600')


%模糊输入变量
figure(7)
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
  set(gca,'Position',[0.076 0.14  0.89 0.84]);
plot(FuzzyInput(:,2),'-r*','LineWidth',1)
hold on
plot(FuzzyInput(:,3),'-bx','LineWidth',1)
set(gca,'YLim',[0 1.1]);
set(gca,'XLim',[0 N+10]);
  set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Inputs','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
legend('Normalized System Errors','Normalized Remaining Power')
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.557303375371452 0.704130580647152 0.368632949631634 0.126345970416058]);
 print('input_of_fuzzy_logic_controller','-depsc','-tiff', '-r600')

%set(gca,'XLim',[0 N+10]);


 %误差的CDF
figure(8);
  set(gcf,'units','centimeter','position',[20,5,17.8,10],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
set(gca,'Position',[0.11 0.11  0.85 0.85]);
a=cdfplot(errors_pdr)
set( a, 'LineStyle', '-', 'Color', 'r','linewidth',1);
% hold on
% d=cdfplot(errors_newpdr)
% set( d, 'LineStyle', '-', 'Color', 'b','linewidth',1);
 
hold on
c=cdfplot(errors_wifi)
set( c, 'LineStyle', '-', 'Color', 'm','linewidth',1);
hold on
c=cdfplot(errors_compliloc)
set( c, 'LineStyle', '-', 'Color', 'k','linewidth',1);
hold on
b=cdfplot(errors_pdrwififuzzy)
set( b, 'LineStyle', '-', 'Color', 'g','linewidth',1);
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Errors (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('CDF','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
legend('PDR','WiFi','CF Fusion','Fuzzy Logic Based Fusion');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 title(' ')
 grid off
 print('CDF_errors_of_different_localization_methods','-depsc','-tiff', '-r600')

%WiFi调用的的概率
figure(9)
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
   set(gca,'Position',[0.076 0.14  0.89 0.84]);
a= plot(wifiprob,'-r*')
set( a, 'LineStyle', '-', 'Color', 'r','linewidth',1);
% hold on
% plot(WiFiInvoke(:,2),'-b*')
legend( 'Output of Fuzzy Inference System')
set(gca,'YLim',[0.0 1]);
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Probability','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.510614471475102 0.243297343164794 0.408766375401856 0.0999999999999998]);
 set(gca,'XLim',[0 N+10]); 
 print('output_of_fuzzy_logic_controller','-depsc','-tiff', '-r600')


%航向对比
figure(10)
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
    set(gca,'Position',[0.076 0.14  0.89 0.84]);
plot(pdr_heading,'co-','LineWidth',1);
hold on;
plot(magnetic_heading,'mp-','LineWidth',1);
hold on;
plot(kalman_heading,'g+-','LineWidth',1);
% hold on;
%  plot(newHeading,'rx-','LineWidth',0.5);
hold on;
plot(true_heading,'b.-','LineWidth',1);

legend('Gyroscope-based Heading','Magnetic-based Heading', 'Kalman-based Heading','Reference')
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Heading (rads)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold', 'Position',[0.107789334509238 0.690978917031709 0.328380378358964 0.2422869782853]);
set(gca,'XLim',[0 N+10]);
 print('comparation_of_heading','-depsc','-tiff', '-r600')


 %校准航向后的PDR和原来PDR对比
  %wifi PDR定位结果
 figure(11);
 set(gcf,'units','centimeter','position',[20,5,17.8,12],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
    set(gca,'Position',[0.076 0.11  0.89 0.85]);
 p2=scatter(pdr_loc(:,1),pdr_loc(:,2),20,'m+');
 hold on
 p3=scatter(newpdr_loc(:,1),newpdr_loc(:,2),20,'b');
 hold on
 p4=scatter(true_loc(:,1),true_loc(:,2),14,'kp','LineWidth',1);
 hold on
 set(p2,'LineWidth',1)
 set(p2,'MarkerEdgeColor',[  1   0  1])
 set(p3,'LineWidth',1)
 set(p3,'MarkerEdgeColor',[  0   0  1])
 set(p4,'LineWidth',1)
 set(p4,'MarkerEdgeColor',[  0 0 0])
 g1=get(p2,'Parent');%对应p1所在的坐标轴
 set(g1,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold')
 set(g1,'Xlim',[-2 78]) 
 set(g1,'Ylim',[-20 38])
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('X (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Y (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend('PDR','PDR After WiFi-assisted Heading','Reference');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.526389305287803 0.505770926980983 0.306092117507603 0.136563872910281]);
 print('comparation_of_pdr_and_heading-corrected_pdr','-depsc','-tiff', '-r600')

 
 
%   %wifi融合点显示
%  figure(11)
%  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
%  set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
%  set(gcf,'color','w');%设置图窗颜色为白色
%    set(gca,'Position',[0.076 0.14  0.89 0.84]);
%  [h1,h2]=plot_dir(fusion_loc(:,1),fusion_loc(:,2),'bo','b')
%  hold on
%  h3 = scatter(fusion_pdr_wifi(:,1),fusion_pdr_wifi(:,2),20,'r*');
%  set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
%  g1=get(h1,'Parent');%对应p1所在的坐标轴
%  set(g1,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold')
%  set(g1,'Xlim',[-2 78]) 
%  set(g1,'Ylim',[-2 38])
%  
%   set(h1,'LineWidth',1)
%   set(h2,'MarkerEdgeColor',[  0   0  1])
%  
%  %title('Fuzzy Logic Based Fusion ');
%  legend('Fusion Location','Direction','Initial Location of PDR')
%  set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.0896711182191076 0.712367746812406 0.328499523861411 0.2422869782853]);
%  %xlabel('X (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
%  ylabel('Y (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
%  set(get(gca,'Xlabel'),'String','X (m)','FontSize',12,'FontName','Times New Roman'); 
%  grid off
%  print('fusion_result_with_arrow_direction','-depsc','-tiff', '-r600')

 
 
 %wifi融合点显示
 figure(12)
 set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色
 set(gca,'Position',[0.01 0.14  1 0.84]);
 [h1,h2]=plot_dir1(fusion_pdr_wifi(:,1),fusion_pdr_wifi(:,2),'r*','b')
 hold on
 a=scatter(pdr_loc_at_fusion_point(:,1),pdr_loc_at_fusion_point(:,2),40,'go');
 hold on
 b=scatter(wifi_loc_at_fusion_point(:,1),wifi_loc_at_fusion_point(:,2),40,'p','filled');
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 g1=get(h1,'Parent');%对应p1所在的坐标轴
 set(g1,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold')
 set(g1,'Xlim',[-2 78]) 
 set(g1,'Ylim',[-2 38])
 
  set(h1,'LineWidth',1)
  set(h2,'MarkerEdgeColor',[  0   0  1])
  set(b,'MarkerEdgeColor',[1 0.5 0])
    set(b,'MarkerFaceColor',[1 0.5 0])

 legend('Fuison Results','Direction','PDR in Fusion Step','WiFi in Fusion Step')
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold', 'Position',[0.548821330340794 0.546680213372062 0.264583327264389 0.2422869782853]);
 %xlabel('X (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Y (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 set(get(gca,'Xlabel'),'String','X (m)','FontSize',12,'FontName','Times New Roman');
 grid off
 axes('position',[0.21 0.35 0.3 0.2]);  % 控制小图大小和位置
 axis([0 15 -2 3]);%坐标范围设置
  hold on 
  plot_dir1(fusion_pdr_wifi(1:2,1),fusion_pdr_wifi(1:2,2),'r*','b')
  hold on
  scatter(pdr_loc_at_fusion_point(1:2,1),pdr_loc_at_fusion_point(1:2,2),40,'go');
  hold on
  scatter(wifi_loc_at_fusion_point(1:2,1),wifi_loc_at_fusion_point(1:2,2),40,'p','filled');
  grid off
 set(gca,'LineWidth',1);
  rectangle('Position', [0.472624176267008 0.157631086142321 0.0525112359550562 0.09513108614232],'EdgeColor','b','LineWidth',1);
  print('comparation_among_wifi_at_fusion_step_and_pdr_and_fusion_location','-depsc','-tiff', '-r600')

%  
 
%  %13
%  figure(13)
%  set(gcf,'units','centimeter','position',[20,5,17.8,8],'PaperPositionMode','auto');%设计图窗大小
%  set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
%  set(gcf,'color','w');%设置图窗颜色为白色
%  [h1,h2]=plot_dir(fusion_pdr_wifi(:,1),fusion_pdr_wifi(:,2),'r*','b')
%  hold on
%  scatter(pdr_loc_at_fusion_point(:,1),pdr_loc_at_fusion_point(:,2),60,'go');
%  hold on
%  scatter(wifi_loc_at_fusion_point(:,1),wifi_loc_at_fusion_point(:,2),60,'mp','filled');
%  set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
%  g1=get(h1,'Parent');%对应p1所在的坐标轴
%  set(g1,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold')
%  set(g1,'Xlim',[3.8 14]) 
%  set(g1,'Ylim',[-1 4.5])
%  
%   set(h1,'LineWidth',1)
%   set(h2,'MarkerEdgeColor',[  0   0  1])
%  
% 
%  legend('Fuison Results','Direction','PDR at Fusion Step','WiFi at Fusion Step')
%  set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.65,0.65,0.1,0.1]);
%  %xlabel('X (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
%  ylabel('Y (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
%  set(get(gca,'Xlabel'),'String','X (m)','FontSize',12,'FontName','Times New Roman'); 
%  grid off
% 
%  print('detail_comparation_among_wifi_at_fusion_step_and_pdr_and_fusion_location','-depsc','-tiff', '-r600')
%  
 
%  figure(14)
%  
%  x=1:1:M;
%  y=ones(M,1);
% [ax,h1,h2]= plotyy(x,eur_distance(:,:),x,y-weight(1:M,:));
% set(h1,'linestyle','-','marker','*','color','r');
% set(h2,'linestyle','-','marker','o','color','b');
%  legend('Distance of WiFi and PDR','Weight');
%  
%  set(gcf,'position',[42,80,1200,730],'PaperPositionMode','auto');%设计图窗大小
% set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
% set(gcf,'color','w');%设置图窗颜色为白色
%  






%融合后的定位结果
 figure(15)
 set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色
%  set(gca,'Position',[.13 .13 .80 .8]);%这句是设置xy轴在图片中占的比例，可能需要自己微调。
  set(gca,'Position',[0.076 0.14  0.89 0.84]);
 p1 = scatter(true_loc_at_turn_point(:,1),true_loc_at_turn_point(:,2),20,'ob');
 set(p1,'LineWidth',1)
 set(p1,'MarkerEdgeColor',[  0   0  1])
 
 hold on
 p2 = scatter(true_loc_at_WiFiInvoke(:,1),true_loc_at_WiFiInvoke(:,2),20,'r*');
 set(p2,'LineWidth',1)
 set(p2,'MarkerEdgeColor',[  1   0  0])
 %title('Fuzzy Logic Based Fusion');

 %set(get(p1),'MarkerSize',20);
 g1=get(p1,'Parent');%对应p1所在的坐标轴
 set(g1,'Xlim',[-2 76]) 
 set(g1,'Ylim',[0 38])
 g2=get(p2,'Parent');%对应p1所在的坐标轴
 set(g2,'Xlim',[-2 78]) 
 set(g2,'Ylim',[-2 38])
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend([p1 p2],'Turn Step','WiFi Step');
 %'Orientation','horizontal',表示图例横放
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.652228827701458 0.661231776696733 0.164933132115658 0.126345970416058]);
 xlabel('X (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Y (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 print('turn_point_and_wifi_invoking_point','-depsc','-tiff', '-r600')
 
 
 %融合后的定位结果
 figure(16);
 set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
  set(gca,'Position',[0.076 0.14  0.89 0.84]);
 p1=scatter(wifi_loc(:,1),wifi_loc(:,2),20,'g*');
 hold on
 p2=scatter(pdr_loc(:,1),pdr_loc(:,2),20,'b+');
 hold on
 p3=scatter(simplefusion(:,1),simplefusion(:,2),20,'r');
 hold on
 p4=scatter(true_loc(:,1),true_loc(:,2),14,'kp','LineWidth',1);
%  hold on
%  p5=scatter(fusion_pdr_wifi(:,1),fusion_pdr_wifi(:,2),20,'r*','LineWidth',1);
 set(p1,'LineWidth',1)
 set(p1,'MarkerEdgeColor',[  0   1  0])
 set(p2,'LineWidth',1)
 set(p2,'MarkerEdgeColor',[  1   0  1])
 set(p3,'LineWidth',1)
 set(p3,'MarkerEdgeColor',[  0   0  1])
 set(p4,'LineWidth',1)
 set(p4,'MarkerEdgeColor',[  0 0 0])
%  set(p5,'LineWidth',1)
%  set(p5,'MarkerEdgeColor',[  1 0 0])
 g1=get(p1,'Parent');%对应p1所在的坐标轴
 set(g1,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold')
 set(g1,'Xlim',[-2 78]) 
 set(g1,'Ylim',[-20 38])
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('X (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Y (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 legend('WiFi','PDR','Fuzzy Logic Based Fusion','Reference');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','position',[0.127993917822426 0.147246023965963 0.327013100684736 0.242286978285299]);
 print('comparation_of_cf_localization_methods','-depsc','-tiff', '-r600')
 
 
 
 
 pdr_headingerror = abs(pdr_heading-true_heading);
 magnetic_headingerror =abs(magnetic_heading-true_heading);
 kalman_headingerror =abs(kalman_heading-true_heading);
 newHeadingerror=abs(newHeading-true_heading);
 for i=1:N
   if pdr_headingerror(i,1) > pi
      pdr_headingerror(i,1) = -pi + mod(pdr_headingerror(i,1),pi);
   elseif pdr_headingerror(i,1) < -pi
      pdr_headingerror(i,1) = pi + mod(pdr_headingerror(i,1),pi);
   end   
   
   if magnetic_headingerror(i,1) > pi
      magnetic_headingerror(i,1) = -pi + mod(magnetic_headingerror(i,1),pi);
   elseif magnetic_headingerror(i,1) < -pi
      magnetic_headingerror(i,1) = pi + mod(magnetic_headingerror(i,1),pi);
   end   
    if kalman_headingerror(i,1) > pi
      kalman_headingerror(i,1) = -pi + mod(kalman_headingerror(i,1),pi);
   elseif kalman_headingerror(i,1) < -pi
      kalman_headingerror(i,1) = pi + mod(kalman_headingerror(i,1),pi);
    end   
    if newHeadingerror(i,1) > pi
      newHeadingerror(i,1) = -pi + mod(newHeadingerror(i,1),pi);
   elseif newHeadingerror(i,1) < -pi
      newHeadingerror(i,1) = pi + mod(newHeadingerror(i,1),pi);
   end      
 end 
 %航向误差对比
figure(17)
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
    set(gca,'Position',[0.076 0.14  0.89 0.84]);
plot(abs(pdr_headingerror),'r-','LineWidth',1);
hold on;
plot(abs(magnetic_headingerror),'g-','LineWidth',1);
hold on;
plot(abs(kalman_headingerror),'b-','LineWidth',1);
% hold on;
%  plot(abs(newHeadingerror),'r-','LineWidth',0.5);
legend('Gyroscope-based Heading','Magnetic-based Heading', 'Asynchronous Kalman-based Heading')
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Heading Errors (rads)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
set(gca,'XLim',[0 N+10]);
set(gca,'YLim',[0 1]);
 print('comparation_of_heading_errors','-depsc','-tiff', '-r600')
 
 % 每一步累积的陀螺仪角速度
 accumulatedStepGyroscope = WIFIPDRFUZZYHEADING(:,6);
 
 

figure(18)
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
   % set(gca,'Position',[0.076 0.14  0.89 0.84]);
plot(accumulatedStepGyroscope,'r*-','LineWidth',1);

legend('Accumulated Angle Rate')
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Sum Angle Rate (rads)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold', 'Position',[0.576043917673588 0.175332175753379 0.315007421848147 0.0683754664814372]);

 print('accumulatedstepgyroscope','-depsc','-tiff', '-r600')
% h=imrect; pos=wait(h);
% rectangle('Position',pos,'EdgeColor','b','LineWidth',1);




figure(19)
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
    set(gca,'Position',[0.076 0.14  0.89 0.84]);
plot(abs(kalman_headingerror),'r*-','LineWidth',1);
hold on;
 plot(abs(newHeadingerror),'b+-','LineWidth',1);
legend( 'Kalman-based Heading','WiFi-assisted Heading')
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Heading Errors (rads)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.644378412324878 0.807050375582855 0.301634465337332 0.126345970416058]);
set(gca,'XLim',[0 N+10]);
 print('comparation_of_2heading_errors','-depsc','-tiff', '-r600')

 
 %航向对比
figure(20)
set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
set(gcf,'color','w');%设置图窗颜色为白色 
set(gca,'Position',[0.076 0.14  0.89 0.84]);
% plot(pdr_heading,'co-','LineWidth',1);
% hold on;
plot(kalman_heading,'g+-','LineWidth',1);
hold on;
 plot(newHeading,'rx-','LineWidth',0.5);
hold on;
plot(true_heading,'b.-','LineWidth',1);

legend('Kalman-based Heading','WiFi-assisted Heading','Reference')
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Heading (rads)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold','Position',[0.127103131426001 0.734150397422435 0.301634465337331 0.184316474350679]);
set(gca,'XLim',[0 N+10]);
 print('comparation_of_2heading','-depsc','-tiff', '-r600')
 
 
  %误差的CDF
figure(21);
set(gcf,'units','centimeter','position',[20,5,17.8,10],'PaperPositionMode','auto');%设计图窗大小
set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
set(gcf,'color','w');%设置图窗颜色为白色 
set(gca,'Position',[0.11 0.11  0.85 0.85]);
a=cdfplot(abs(kalman_headingerror))
set( a, 'LineStyle', '-', 'Color', 'r','linewidth',1);
hold on
c=cdfplot(abs(newHeadingerror))
set( c, 'LineStyle', '-', 'Color', 'm','linewidth',1);
 
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Errors (m)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('CDF','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
legend('Kalman-based Heading','WiFi-assisted Heading');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold', 'Position',[0.639921332914704 0.786151898939563 0.301634465337331 0.112433859437862]);
 title(' ')
 grid off
 print('CDF_errors_of_2heading_errors','-depsc','-tiff', '-r600')
 
 
 
 for i=1:N-1
    stepheading_diff(i,1) = kalman_heading(i+1,1) - kalman_heading(i,1);
    if stepheading_diff(i,1) > pi
      stepheading_diff(i,1) = -pi + mod(stepheading_diff(i,1),pi);
   elseif stepheading_diff(i,1) < -pi
      stepheading_diff(i,1) = pi + mod(stepheading_diff(i,1),pi);
   end   
end 
for i=1:N-1
    stepgyroheading_diff(i,1) = pdr_heading(i+1,1) - pdr_heading(i,1);
    if stepgyroheading_diff(i,1) > pi
      stepgyroheading_diff(i,1) = -pi + mod(stepgyroheading_diff(i,1),pi);
   elseif stepgyroheading_diff(i,1) < -pi
      stepgyroheading_diff(i,1) = pi + mod(stepgyroheading_diff(i,1),pi);
   end       
end 

for i=1:N-1
    stepmagnheading_diff(i,1) = magnetic_heading(i+1,1) - magnetic_heading(i,1);
    if stepmagnheading_diff(i,1) > pi
      stepmagnheading_diff(i,1) = -pi + mod(stepmagnheading_diff(i,1),pi);
   elseif stepmagnheading_diff(i,1) < -pi
      stepmagnheading_diff(i,1) = pi + mod(stepmagnheading_diff(i,1),pi);
   end       
end 

figure(22)
  set(gcf,'units','centimeter','position',[20,5,17.8,8.9],'PaperPositionMode','auto');%设计图窗大小
 set(gcf,'ToolBar','none','ReSize','off'); %移除工具条
 set(gcf,'color','w');%设置图窗颜色为白色 
    set(gca,'Position',[0.076 0.14  0.89 0.84]);
plot(abs(stepgyroheading_diff),'c-','LineWidth',1);
hold on;
plot(abs(stepmagnheading_diff),'m-','LineWidth',1);
hold on;
plot(abs(stepheading_diff),'g-','LineWidth',1);
% hold on;
%  plot(abs(newHeadingerror),'r-','LineWidth',0.5);
legend('Gyroscope-based Heading','Magnetic-based Heading', 'Kalman-based Heading')
 set(gca,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 xlabel('Step','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 ylabel('Heading Errors (rads)','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
 set(legend,'Linewidth',1,'FontSize',12,'FontName','Times New Roman','FontWeight','bold');
set(gca,'XLim',[0 N+10]);
 
 print('comparation_of_heading_errors_diff','-depsc','-tiff', '-r600')