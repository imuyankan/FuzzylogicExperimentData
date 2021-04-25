%load WIFIPDRFUZZYHEADING
load wifipdrfuzzy20201217
%��ȡ����
wifi_loc=WIFIPDRFUZZYHEADING(:,10:11);%wifi��λ����
%pdr_loc=WIFIPDRFUZZYHEADING(:,31:32);%PDR��λ����
step_length=WIFIPDRFUZZYHEADING(:,2);%PDR����
pdr_heading=WIFIPDRFUZZYHEADING(:,5);%PDR����
magnetic_heading=WIFIPDRFUZZYHEADING(:,4);%�����ƺ���
kalman_heading=WIFIPDRFUZZYHEADING(:,3);%KALMAN����
N=length(step_length);%�ܲ���

true_heading =WIFIPDRFUZZYHEADING(:,29);%��ʵ����
true_loc=WIFIPDRFUZZYHEADING(:,30:31);%��ʵ��λ����
% FuzzyInput =zeros(N,3);%ģ���������������
% FuzzyInput(:,2:3) = WIFIPDRFUZZYHEADING(:,14:15);

new_heading=zeros(N,1);%У׼��ĺ���
%  WiFiInvoke=zeros(N,2);%wifi��λ�������
%  WiFiInvoke(:,2)=WIFIPDRFUZZYHEADING(:,17);
M=0;%����WiFi��λ�ܴ���
for i=1:N
    if WiFiInvoke(i,2) == 1
        M=M+1;
    end
end 
true_loc_at_WiFiInvoke=zeros(M,2);
%true_loc=WIFIPDRFUZZYHEADING(:,29:30);%��ʵ��λ����
eur_distance=zeros(M,1);%WiFi��PDR��ŷʽ����
eur_distance_wifi=zeros(M,1);%WiFi��λ����һ���ں϶�λ����
eur_distance_pdr=zeros(M,1);%PDR��λ����һ���ں϶�λ����
weight=zeros(M,1);%�ں�Ȩ��
fusion_loc=zeros(N,1);%�ں�λ��
fusion_pdr_wifi =zeros(N,1);%��wifi��λ�ںϺ�λ��
pdr_loc_at_fusion_point =zeros(M,2);%�ںϵ��PDR��λ
wifi_loc_at_fusion_point =zeros(M,2);
gyroHeadingIncrement =zeros(N,1);%ÿһ�������Ǻ�������
is_turn = WIFIPDRFUZZYHEADING(:,9);%�Ƿ����
wifiprob = wifiprobresult(:,2);%wifiִ�и���
%WiFiInvoke(:,2)=WIFIPDRFUZZYHEADING(:,17);
pdr_loc=zeros(N,2);%PDRλ��
%���������Ǻ���ÿһ������
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
% magHeadingIncrement =zeros(N,1);%ÿһ�������ƺ�������
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
% %��ȡ����
% head_difference=zeros(N,1);%�������
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
% %����ÿһ��PDR���
% oneStepPDRErrors =zeros(N,2)
% for i = 1:N
%     oneStepPDRErrors(i,1)=i;
%     oneStepPDRErrors(i,2)=stepLength(i,1)*abs(head_difference(i,1));
%     
% end 

%ֱ���ں�
alpha=0.8;
for i=1:N
    
       if i ==1 
            simplefusion(i,:) = (1-alpha)*wifi_loc(i,:);
       else
           
            simplefusion(i,1)=alpha*(simplefusion(i-1,1)+step_length(i)*cos(kalman_heading(i))) + (1-alpha)*wifi_loc(i,1);
            simplefusion(i,2)=alpha*(simplefusion(i-1,2)-step_length(i)*sin(kalman_heading(i))) + (1-alpha)*wifi_loc(i,2);        
        end
   
end 


%ͨ��WiFi��λУ������
straight_step=[];%ÿһ��ֱ��·���ڵ��õ�WiFi��λ
straight_line_cell = [];%ֱ�жε����ݣ�ÿ�д���һ��ֱ��·������һ�б�ʾֱ�й��̵�wifi��λ���꣬�ڶ��б�ʾֱ��·���Ŀ�ʼ�ͽ����������������б�ʾwifi��λ��Ϻ�ĺ���
straight_line_no=[];%ֱ�ж˿�ʼ��������
 
t=0;%ֱ�в���
m=1;%ֱ�ж�����
n=1;
j=1;%��¼wifi��λ����
k=1;
buildDecAngle =0.0768;
q=1;
for i=1:N
    %���û�з�������
    if is_turn(i,1) == 0 && i<N
        t=t+1;
        %�����WiFi��λ����¼wifi��λ���
        if WiFiInvoke(i,2) == 1
             straight_step(j,1)=i;
             straight_step(j,2)=wifi_loc(i,1);
             straight_step(j,3)=wifi_loc(i,2);
             j=j+1;
        end 
 
    %���������������     
    elseif  is_turn(i,1) == 1 || i==N
        %��һ��û�з�������
        if lastIsTurn == 0 
            %����ֱ�ж�wifi��λ��ֱ�жο�ʼ�ͽ����㵽ֱ�ж�Ԫ��
            straight_line_cell{m,1} = straight_step;
            straight_line_cell{m,2} = [i-t,i-1];
%           straight_line_cell{m,4} = turn_point; 
%           ����ֱ��ÿһ��X��Y������һ��������
            df_step = diff(straight_step);
            %���������wifi��λ�㣬����ÿһ������һ����Ե�б��
%             if length(df_step) >=2
%                slope_step = atan(abs(df_step(:,3)./df_step(:,2)));
%                %��б�ʵ�ƽ��ֵ�ͷ���
%                average_slope_step = mean(slope_step);
%                var_slope_step = var(slope_step);
%                %���б���ھ�ֵ����3*sigma��Χ������
%                 q=1;
%                 for z=1:length(slope_step)
%                         if abs(slope_step(z,1)) < average_slope_step +3* var_slope_step
%                             new_straight_step(q,:) = straight_step(z,:)
%                             q=q+1;
%                         end 
%                  end 
%                
%             end 

%             %�����µ�ֱ�ж�WiFi��λ��ֱ�ж�Ԫ��
%             straight_line_cell{m,4} = new_straight_step;
         
            %���ֱ�ж�wifi��λ������2������б�ʣ�����Ƕ�
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
                    %����ֱ�жεĺ���
                    for x=i-t:i-1
                        newHeading(x,1) = wifi_heading;
                    end
                    straight_line_cell{m,3} = wifi_heading; 
                    k=k+1;
           else
               %���û��ֱ�жκ���У׼������Ϊ�����Ǻ���
                    for j=i-t:i-1
                        if j == 1
                             newHeading(j,1) = kalman_heading(j,1);
                        else
                            
                            %newHeading(j,1) =newHeading(j-1,1) +gyroHeadingIncrement(j,1);
                            newHeading(j,1) =kalman_heading(j,1);
                                    
                        end 
                    end               
    
           end 
           %���õ�ǰ���䲽����Ϊ��һ��������������Ǻ�������
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
  
        elseif lastIsTurn == 1 %�����һ��Ϊ���䣬����Ϊ�����Ǻ���
           newHeading(i,1) = newHeading(i - 1,1) + gyroHeadingIncrement(i,1);  
 ;
        end 
        
        
    end 
    lastIsTurn =  is_turn(i,1);
end 
%����PDR����
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
%����У׼������PDR����
for i=1:N
    if i==1
        newpdr_loc(i,1) = 4.48 + step_length(i,1)*cos(new_heading(i,1));
        newpdr_loc(i,2) = 0.9 - step_length(i,1)*sin(new_heading(i,1));
    else
        newpdr_loc(i,1) =   newpdr_loc(i-1,1)+ step_length(i,1)*cos(new_heading(i,1));
        newpdr_loc(i,2) =   newpdr_loc(i-1,2) - step_length(i,1)*sin(new_heading(i,1));
    end 
end 


fusion_pdr_wifi=zeros(M,2); %����WiFi��λ��WiFi��λ��PDR�ں�λ������
j=1;%����WiFi��λ���ں�λ�õ�
%���������wifi��λ����λ��Ϊ��һ���ں�λ����Ϊ��ʼλ�ã�����PDR����
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
    %���wifi��λ�����ã����ں�λ��    
    elseif WiFiInvoke(i,2) ==1
        %���Ϊ��һ������PDRΪ��ʼλ�üӵ�һ������
        if i ==1 
            corrected_heading(i) = new_heading(i);
            pdr_x=4.48+step_length(i)*cos(corrected_heading(i));
            pdr_y=0.9-step_length(i)*cos(corrected_heading(i));

        else%����Ϊ��һ��λ�ü���PDR����
            corrected_heading(i) = new_heading(i);
            pdr_x = fusion_loc(i-1,1)+step_length(i)*cos(corrected_heading(i));
            pdr_y = fusion_loc(i-1,2)-step_length(i)*sin(corrected_heading(i));
            
        end

        
        %�����һ�����ںϵ�λ��Ϊ��ʼλ��
        if j==1
           fusion_pdr_wifi(1,:)=[4.48,0.9];
           wifi_loc_at_fusion_point(j,:) =   fusion_pdr_wifi(1,:);
           pdr_loc_at_fusion_point(j,:) = [4.48,0.9];
        end 
        %PDR��WiFi��λ�ľ���
        eur_distance(j)=sqrt((pdr_x - wifi_loc(i,1))^2+(pdr_y - wifi_loc(i,2))^2);
        %WiFi����һ���ںϵ�ľ���
        eur_distance_wifi(j)=sqrt((fusion_pdr_wifi(j,1) - wifi_loc(i,1))^2+(fusion_pdr_wifi(j,2) - wifi_loc(i,2))^2);
        %PDR����һ���ںϵ�ľ���
        eur_distance_pdr(j)=sqrt((fusion_pdr_wifi(j,1) - pdr_x)^2+(fusion_pdr_wifi(j,2) - pdr_y)^2);
        %Kֵ����     
        %k= (1/eur_distance_pdr(j)+1/eur_distance)/(1/eur_distance_wifi(j)+1/eur_distance_pdr(j)+1/eur_distance);
        %k= (1/eur_distance_pdr(j)+1/eur_distance(j))/(1/eur_distance_wifi(j)+1/eur_distance_pdr(j)+1/eur_distance(j));
        k= abs(eur_distance_wifi(j)- eur_distance_pdr(j))/(eur_distance_pdr(j)+ eur_distance_wifi(j));

        weight(j)=1-k;
        %�ں�λ��   
        fusion_loc(i,:) =  weight(j)* wifi_loc(i,:)+ (1-weight(j)) * [pdr_x pdr_y];
        j=j+1;
        %�ںϵ�λ��
        fusion_pdr_wifi(j,:)=fusion_loc(i,:);
        pdr_loc_at_fusion_point(j,:) = [pdr_x,pdr_y];
        wifi_loc_at_fusion_point(j,:) = wifi_loc(i,:);    
            
        
    end 

end 

%���
pdr = true_loc(1:N-1,:) - pdr_loc(1:N-1,:);
errors_pdr=sqrt(sum( pdr.*pdr,2 ));%PDR���

%���
newpdr = true_loc(1:N-1,:) - newpdr_loc(1:N-1,:);
errors_newpdr=sqrt(sum( newpdr.*newpdr,2 ));%PDR���

wifi2 = true_loc(1:N-1,:)  - wifi_loc(1:N-1,:);
errors_wifi=sqrt(sum( wifi2.*wifi2,2 ));%WiFi���

pdrwififuzzy = true_loc(1:N-1,:)  - fusion_loc(1:N-1,:) ;
errors_pdrwififuzzy=sqrt(sum(pdrwififuzzy.*pdrwififuzzy,2));%WiFiPDRģ���������

newpdr = true_loc(1:N,:) - newpdr_loc(1:N,:);
errors_newpdr=sqrt(sum( newpdr.*newpdr,2 ));%У׼������PDR���


compliloc  =  true_loc(1:N-1,:)  - simplefusion(1:N-1,:);
errors_compliloc=sqrt(sum( compliloc.*compliloc,2 ));%�����˲����
%��ʵλ�ö�Ӧ�Ĺ�����wifi���õ�
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


%��ͬ������APɨ�����
apscan05 = [ 34 34 34 42 89 89 89 87 89 89]';
apscan40 = [ 4 4 4 5 14 14 14 14 14 14]';
apscan400 = [ 0 0 0 1 1 1 1 1 1 1]';
apscan15 = [ 12 12 14 35 35 35 35 35 35 35]';
apscan20 = [ 9 9 11 27 27 27 27 26 27 27]';
apscan30 = [ 6 6 7 18 18 18 18 18 18 18]';
apscan45 = [ 4 4 5 12 12 12 12 12 12 12]';
% ���00-600���������ٷֱ�1%--100%
%���00 05 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 200 
%00 400 500 600  611
%���� 01 02 03 04 05 06 07 08 09 10 001
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
