%load WIFIPDRFUZZYHEADING
load wifipdrfuzzy20201217
%读取数据
wifi_loc=WIFIPDRFUZZYHEADING(:,10:11);%wifi定位坐标
%pdr_loc=WIFIPDRFUZZYHEADING(:,31:32);%PDR定位坐标
step_length=WIFIPDRFUZZYHEADING(:,2);%PDR步长
pdr_heading=WIFIPDRFUZZYHEADING(:,5);%PDR航向
magnetic_heading=WIFIPDRFUZZYHEADING(:,4);%磁力计航向
kalman_heading=WIFIPDRFUZZYHEADING(:,3);%KALMAN航向
N=length(step_length);%总步数

true_heading =WIFIPDRFUZZYHEADING(:,29);%真实航向
true_loc=WIFIPDRFUZZYHEADING(:,30:31);%真实定位坐标
% FuzzyInput =zeros(N,3);%模糊控制器输入变量
% FuzzyInput(:,2:3) = WIFIPDRFUZZYHEADING(:,14:15);

new_heading=zeros(N,1);%校准后的航向
%  WiFiInvoke=zeros(N,2);%wifi定位调用情况
%  WiFiInvoke(:,2)=WIFIPDRFUZZYHEADING(:,17);
M=0;%调用WiFi定位总次数
for i=1:N
    if WiFiInvoke(i,2) == 1
        M=M+1;
    end
end 
true_loc_at_WiFiInvoke=zeros(M,2);
%true_loc=WIFIPDRFUZZYHEADING(:,29:30);%真实定位坐标
eur_distance=zeros(M,1);%WiFi和PDR的欧式距离
eur_distance_wifi=zeros(M,1);%WiFi定位和上一次融合定位距离
eur_distance_pdr=zeros(M,1);%PDR定位和上一次融合定位距离
weight=zeros(M,1);%融合权重
fusion_loc=zeros(N,1);%融合位置
fusion_pdr_wifi =zeros(N,1);%与wifi定位融合后位置
pdr_loc_at_fusion_point =zeros(M,2);%融合点的PDR定位
wifi_loc_at_fusion_point =zeros(M,2);
gyroHeadingIncrement =zeros(N,1);%每一步陀螺仪航向增量
is_turn = WIFIPDRFUZZYHEADING(:,9);%是否拐弯
wifiprob = wifiprobresult(:,2);%wifi执行概率
%WiFiInvoke(:,2)=WIFIPDRFUZZYHEADING(:,17);
pdr_loc=zeros(N,2);%PDR位置
%计算陀螺仪航向每一步增量
for i=1:N
    if i==1
        gyroHeadingIncrement(i,1)=0;
    else 
        gyroHeadingIncrement(i,1)=pdr_heading(i,1)-pdr_heading(i-1,1)
        if gyroHeadingIncrement(i,1) > pi
            gyroHeadingIncrement(i,1) = -pi + mod(gyroHeadingIncrement(i,1),pi);
        elseif gyroHeadingIncrement(i,1) < -pi
            gyroHeadingIncrement(i,1) = pi + mod(gyroHeadingIncrement(i,1),pi);
        end         
        
    end
end 
% 
% magHeadingIncrement =zeros(N,1);%每一步磁力计航向增量
% for i=1:N
%     if i==1
%         magHeadingIncrement(i,1)=0;
%     else 
%         magHeadingIncrement(i,1)=magnetic_heading(i,1)-magnetic_heading(i-1,1)
%         if magHeadingIncrement(i,1) > pi
%             magHeadingIncrement(i,1) = -pi + mod(magHeadingIncrement(i,1),pi);
%         elseif magHeadingIncrement(i,1) < -pi
%             magHeadingIncrement(i,1) = pi + mod(magHeadingIncrement(i,1),pi);
%         end         
%         
%     end
% end 
% %读取数据
% head_difference=zeros(N,1);%航向误差
% for i=1:N
%     if i==1
%         head_difference(i,1)=0;
%     else 
%         head_difference(i,1)=gyroHeadingIncrement(i,1)-magHeadingIncrement(i-1,1)
%         if head_difference(i,1) > pi
%             head_difference(i,1) = -pi + mod(head_difference(i,1),pi);
%         elseif head_difference(i,1) < -pi
%             head_difference(i,1) = pi + mod(head_difference(i,1),pi);
%         end         
%         
%     end
% end 
% %计算每一步PDR误差
% oneStepPDRErrors =zeros(N,2)
% for i = 1:N
%     oneStepPDRErrors(i,1)=i;
%     oneStepPDRErrors(i,2)=stepLength(i,1)*abs(head_difference(i,1));
%     
% end 

%直接融合
alpha=0.8;
for i=1:N
    
       if i ==1 
            simplefusion(i,:) = (1-alpha)*wifi_loc(i,:);
       else
           
            simplefusion(i,1)=alpha*(simplefusion(i-1,1)+step_length(i)*cos(kalman_heading(i))) + (1-alpha)*wifi_loc(i,1);
            simplefusion(i,2)=alpha*(simplefusion(i-1,2)-step_length(i)*sin(kalman_heading(i))) + (1-alpha)*wifi_loc(i,2);        
        end
   
end 


%通过WiFi定位校正航向
straight_step=[];%每一段直行路径内调用的WiFi定位
straight_line_cell = [];%直行段的数据，每行代表一段直行路径，第一列表示直行过程的wifi定位坐标，第二列表示直行路径的开始和结束步计数，第三列表示wifi定位拟合后的航向
straight_line_no=[];%直行端开始结束步数
 
t=0;%直行步数
m=1;%直行段数量
n=1;
j=1;%记录wifi定位数量
k=1;
buildDecAngle =0.0768;
q=1;
for i=1:N
    %如果没有发生拐弯
    if is_turn(i,1) == 0 && i<N
        t=t+1;
        %如果有WiFi定位，记录wifi定位结果
        if WiFiInvoke(i,2) == 1
             straight_step(j,1)=i;
             straight_step(j,2)=wifi_loc(i,1);
             straight_step(j,3)=wifi_loc(i,2);
             j=j+1;
        end 
 
    %如果发生拐弯或结束     
    elseif  is_turn(i,1) == 1 || i==N
        %上一步没有发生拐弯
        if lastIsTurn == 0 
            %保存直行段wifi定位、直行段开始和结束点到直行段元组
            straight_line_cell{m,1} = straight_step;
            straight_line_cell{m,2} = [i-t,i-1];
%           straight_line_cell{m,4} = turn_point; 
%           计算直行每一步X、Y轴与上一步的增量
            df_step = diff(straight_step);
            %如果有三个wifi定位点，计算每一步与上一步相对的斜率
%             if length(df_step) >=2
%                slope_step = atan(abs(df_step(:,3)./df_step(:,2)));
%                %求斜率的平均值和方差
%                average_slope_step = mean(slope_step);
%                var_slope_step = var(slope_step);
%                %如果斜率在均值附近3*sigma范围，则保留
%                 q=1;
%                 for z=1:length(slope_step)
%                         if abs(slope_step(z,1)) < average_slope_step +3* var_slope_step
%                             new_straight_step(q,:) = straight_step(z,:)
%                             q=q+1;
%                         end 
%                  end 
%                
%             end 

%             %保存新的直行段WiFi定位到直行段元组
%             straight_line_cell{m,4} = new_straight_step;
         
            %如果直行段wifi定位数大于2，计算斜率，计算角度
           if  length(straight_step)> 5
                    p(k,:)= polyfit(straight_step(:,2),straight_step(:,3),1);
                    %deltaX = straight_step(row,2) -straight_step(1,2);
                    %deltaY = straight_step(row,3) -straight_step(1,3);
                    fit_angle = atan(p(k,1));
                    diff_step(k,:)= sum(diff(straight_step))
                    angle =abs(p(k,1));
                    if diff_step(k,2) >0 && diff_step(k,3)  < 0
                        wifi_heading = -atan2(-angle,1);
                    elseif diff_step(k,2) >0 && diff_step(k,3) > 0
                        wifi_heading = -atan2(angle,1);    
                    elseif diff_step(k,2) <0 && diff_step(k,3) > 0
                        wifi_heading = - atan2(angle,-1); 
                     elseif diff_step(k,2) <0 && diff_step(k,3) < 0
                        wifi_heading = -atan2(-angle,-1);  
                    elseif diff_step(k,2) ==0 && diff_step(k,3)  > 0
                        wifi_heading = -0.5*pi;
                    elseif diff_step(k,2) ==0 && diff_step(k,3)  < 0
                        wifi_heading = 0.5*pi;
                    elseif diff_step(k,2) >0 && diff_step(k,3)  == 0
                        wifi_heading = 0;
                    elseif diff_step(k,2) <0 && diff_step(k,3)  == 0
                        wifi_heading = -pi;    
                    end 
                    %计算直行段的航向
                    for x=i-t:i-1
                        newHeading(x,1) = wifi_heading;
                    end
                    straight_line_cell{m,3} = wifi_heading; 
                    k=k+1;
           else
               %如果没有直行段航向校准，则航向为陀螺仪航向
                    for j=i-t:i-1
                        if j == 1
                             newHeading(j,1) = kalman_heading(j,1);
                        else
                            
                            %newHeading(j,1) =newHeading(j-1,1) +gyroHeadingIncrement(j,1);
                            newHeading(j,1) =kalman_heading(j,1);
                                    
                        end 
                    end               
    
           end 
           %设置当前拐弯步航向为上一步航向加上陀螺仪航向增量
           newHeading(i,1) = newHeading(i - 1,1) + gyroHeadingIncrement(i,1);
           straight_step =[];
           new_straight_step=[];
            df_step = [];
            slope_step = [];
            average_slope_step =[];
            q=1;
           j=1;
           t=1;
           m=m+1;
  
        elseif lastIsTurn == 1 %如果上一步为拐弯，则航向为陀螺仪航向
           newHeading(i,1) = newHeading(i - 1,1) + gyroHeadingIncrement(i,1);  
 ;
        end 
        
        
    end 
    lastIsTurn =  is_turn(i,1);
end 
%计算PDR航向
new_heading =newHeading;
for i=1:N
    if i==1
        pdr_loc(i,1) = 4.48 + step_length(i,1)*cos(kalman_heading(i,1));
        pdr_loc(i,2) = 0.9 - step_length(i,1)*sin(kalman_heading(i,1));
    else
        pdr_loc(i,1) =   pdr_loc(i-1,1)+ step_length(i,1)*cos(kalman_heading(i,1));
        pdr_loc(i,2) =   pdr_loc(i-1,2) - step_length(i,1)*sin(kalman_heading(i,1));
    end 
end 
%计算校准航向后的PDR航向
for i=1:N
    if i==1
        newpdr_loc(i,1) = 4.48 + step_length(i,1)*cos(new_heading(i,1));
        newpdr_loc(i,2) = 0.9 - step_length(i,1)*sin(new_heading(i,1));
    else
        newpdr_loc(i,1) =   newpdr_loc(i-1,1)+ step_length(i,1)*cos(new_heading(i,1));
        newpdr_loc(i,2) =   newpdr_loc(i-1,2) - step_length(i,1)*sin(new_heading(i,1));
    end 
end 


fusion_pdr_wifi=zeros(M,2); %调用WiFi定位后WiFi定位和PDR融合位置坐标
j=1;%调用WiFi定位后融合位置点
%如果不存在wifi定位，则位置为上一次融合位置作为初始位置，加上PDR增量
for i=1:N
    if WiFiInvoke(i,2) == 0 
        
        if i ==1 
            corrected_heading(i) = new_heading(i);
            fusion_loc(i,1)=4.48 + step_length(i)*cos(corrected_heading(i));
            fusion_loc(i,2)=0.9 -step_length(i)*sin(corrected_heading(i));
        else
            corrected_heading(i) =new_heading(i);
            fusion_loc(i,1)=fusion_loc(i-1,1) + step_length(i)*cos(corrected_heading(i));
            fusion_loc(i,2)=fusion_loc(i-1,2) - step_length(i)*sin(corrected_heading(i));        
        end
    %如果wifi定位被调用，则融合位置    
    elseif WiFiInvoke(i,2) ==1
        %如果为第一步，则PDR为初始位置加第一步增量
        if i ==1 
            corrected_heading(i) = new_heading(i);
            pdr_x=4.48+step_length(i)*cos(corrected_heading(i));
            pdr_y=0.9-step_length(i)*cos(corrected_heading(i));

        else%否则，为上一步位置加上PDR增量
            corrected_heading(i) = new_heading(i);
            pdr_x = fusion_loc(i-1,1)+step_length(i)*cos(corrected_heading(i));
            pdr_y = fusion_loc(i-1,2)-step_length(i)*sin(corrected_heading(i));
            
        end

        
        %如果第一步则融合点位置为初始位置
        if j==1
           fusion_pdr_wifi(1,:)=[4.48,0.9];
           wifi_loc_at_fusion_point(j,:) =   fusion_pdr_wifi(1,:);
           pdr_loc_at_fusion_point(j,:) = [4.48,0.9];
        end 
        %PDR和WiFi定位的距离
        eur_distance(j)=sqrt((pdr_x - wifi_loc(i,1))^2+(pdr_y - wifi_loc(i,2))^2);
        %WiFi和上一次融合点的距离
        eur_distance_wifi(j)=sqrt((fusion_pdr_wifi(j,1) - wifi_loc(i,1))^2+(fusion_pdr_wifi(j,2) - wifi_loc(i,2))^2);
        %PDR和上一次融合点的距离
        eur_distance_pdr(j)=sqrt((fusion_pdr_wifi(j,1) - pdr_x)^2+(fusion_pdr_wifi(j,2) - pdr_y)^2);
        %K值计算     
        %k= (1/eur_distance_pdr(j)+1/eur_distance)/(1/eur_distance_wifi(j)+1/eur_distance_pdr(j)+1/eur_distance);
        %k= (1/eur_distance_pdr(j)+1/eur_distance(j))/(1/eur_distance_wifi(j)+1/eur_distance_pdr(j)+1/eur_distance(j));
        k= abs(eur_distance_wifi(j)- eur_distance_pdr(j))/(eur_distance_pdr(j)+ eur_distance_wifi(j));

        weight(j)=1-k;
        %融合位置   
        fusion_loc(i,:) =  weight(j)* wifi_loc(i,:)+ (1-weight(j)) * [pdr_x pdr_y];
        j=j+1;
        %融合点位置
        fusion_pdr_wifi(j,:)=fusion_loc(i,:);
        pdr_loc_at_fusion_point(j,:) = [pdr_x,pdr_y];
        wifi_loc_at_fusion_point(j,:) = wifi_loc(i,:);    
            
        
    end 

end 

%误差
pdr = true_loc(1:N-1,:) - pdr_loc(1:N-1,:);
errors_pdr=sqrt(sum( pdr.*pdr,2 ));%PDR误差

%误差
newpdr = true_loc(1:N-1,:) - newpdr_loc(1:N-1,:);
errors_newpdr=sqrt(sum( newpdr.*newpdr,2 ));%PDR误差

wifi2 = true_loc(1:N-1,:)  - wifi_loc(1:N-1,:);
errors_wifi=sqrt(sum( wifi2.*wifi2,2 ));%WiFi误差

pdrwififuzzy = true_loc(1:N-1,:)  - fusion_loc(1:N-1,:) ;
errors_pdrwififuzzy=sqrt(sum(pdrwififuzzy.*pdrwififuzzy,2));%WiFiPDR模糊控制误差

newpdr = true_loc(1:N,:) - newpdr_loc(1:N,:);
errors_newpdr=sqrt(sum( newpdr.*newpdr,2 ));%校准航向后的PDR误差


compliloc  =  true_loc(1:N-1,:)  - simplefusion(1:N-1,:);
errors_compliloc=sqrt(sum( compliloc.*compliloc,2 ));%互补滤波误差
%真实位置对应的拐弯点和wifi调用点
j=1;
m=1;
for i=1:N
    if is_turn(i,1) == 1
        true_loc_at_turn_point(j,1:2) =  true_loc(i,:);
        true_loc_at_turn_point(j,3) =  i;
        j=j+1
    end 
    if WiFiInvoke(i,2) ==1
        true_loc_at_WiFiInvoke(m,1:2) =  true_loc(i,:);
        true_loc_at_WiFiInvoke(m,3) = i;
        m=m+1        
    end 
end


%不同参数下AP扫描次数
apscan05 = [ 34 34 34 42 89 89 89 87 89 89]';
apscan40 = [ 4 4 4 5 14 14 14 14 14 14]';
apscan400 = [ 0 0 0 1 1 1 1 1 1 1]';
apscan15 = [ 12 12 14 35 35 35 35 35 35 35]';
apscan20 = [ 9 9 11 27 27 27 27 26 27 27]';
apscan30 = [ 6 6 7 18 18 18 18 18 18 18]';
apscan45 = [ 4 4 5 12 12 12 12 12 12 12]';
% 误差00-600——电量百分比1%--100%
%误差00 05 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 200 
%00 400 500 600  611
%电量 01 02 03 04 05 06 07 08 09 10 001
%  errors_newpdrCopy05_03= errors_newpdr;
%  errors_pdrwififuzzyCopy05_03= errors_pdrwififuzzy;
%  wifiprobresultCopy05_03=wifiprobresult;
newHeadingerror  = abs(newHeading-true_heading);
for i=1:N
      
       if newHeadingerror(i,1) > pi
            newHeadingerror(i,1) = -pi + mod(newHeadingerror(i,1),pi);
        elseif newHeadingerror(i,1) < -pi
            newHeadingerror(i,1) = pi + mod(newHeadingerror(i,1),pi);
        end         
          
end 


%newHeadingerror05_01= newHeadingerror;
