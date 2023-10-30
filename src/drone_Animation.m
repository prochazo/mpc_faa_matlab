function animation = drone_Animation(x,y,z,roll,pitch,yaw, time, ref)
% This Animation code is for QuadCopter. Written by Jitendra Singh  https://www.mathworks.com/matlabcentral/fileexchange/97192-quadcopter-model-matlab-code-for-animation
%% Define design parameters
figure('DefaultAxesFontSize',11)
D2R = pi/180;
R2D = 180/pi;
b   = 0.6;   % the length of total square cover by whole body of quadcopter in meter
a   = b/3;   % the legth of small square base of quadcopter(b/4)
H   = 0.06;  % hight of drone in Z direction (4cm)
H_m = H+H/2; % hight of motor in z direction (5 cm)
r_p = b/4;   % radius of propeller
%% Conversions
ro = 45*D2R;                   % angle by which rotate the base of quadcopter
Ri = [cos(ro) -sin(ro) 0;
      sin(ro) cos(ro)  0;
       0       0       1];     % rotation matrix to rotate the coordinates of base 
base_co = [-a/2  a/2 a/2 -a/2; % Coordinates of Base 
           -a/2 -a/2 a/2 a/2;
             0    0   0   0];
base = Ri*base_co;             % rotate base Coordinates by 45 degree 
to = linspace(0, 2*pi);
xp = r_p*cos(to);
yp = r_p*sin(to);
zp = zeros(1,length(to));
%% Define Figure plot
 fig1 = figure('pos', [0 50 800 600]);
 ax1 = axes;
 hg   = gca;
 axis equal;
 title("Drone's trajectory", 'FontSize', 25)
 plot3(ax1, ref(:,1),ref(:,2), ref(:,3),'r', 'LineWidth',2)
 xlabel(ax1,'x (m)', 'FontSize', 20);
 ylabel(ax1, 'y (m)', 'FontSize', 20);
 zlabel(ax1,'z (m)', 'FontSize', 20);
 grid on;
 hold(gca, 'on');
 
xlim([-60 20.0])
ylim([-66 20])
zlim([0.0 2.0])
view([40.71 25.54])
axis equal;
 
 fig2 = figure('pos', [0 50 800 600]);
 ax2 = axes;
 hg2  = gca;
 grid on;
 axis equal;
 title("Drone's trajectory")
 xlabel('x (m)');
 ylabel('y (m)');
 zlabel('z (m)');
 hold(gca, 'on');
 
 xlim([-74.4 34.6])
 ylim([-65.9 20.1])
 xlim([-10.7 10.9])
 ylim([-3.4 13.6])
 
%% Design Different parts
% design the base square
 drone(1) = patch([base(1,:)],[base(2,:)],[base(3,:)],'r');
 drone(2) = patch([base(1,:)],[base(2,:)],[base(3,:)+H],'r');
 alpha(drone(1:2),0.7);
% design 2 parpendiculer legs of quadcopter 
 [xcylinder ycylinder zcylinder] = cylinder([H/2 H/2]);
 drone(3) =  surface(b*zcylinder-b/2,ycylinder,xcylinder+H/2,'facecolor','b');
 drone(4) =  surface(ycylinder,b*zcylinder-b/2,xcylinder+H/2,'facecolor','b') ; 
 alpha(drone(3:4),0.6);
% design 4 cylindrical motors 
 drone(5) = surface(xcylinder+b/2,ycylinder,H_m*zcylinder+H/2,'facecolor','r');
 drone(6) = surface(xcylinder-b/2,ycylinder,H_m*zcylinder+H/2,'facecolor','r');
 drone(7) = surface(xcylinder,ycylinder+b/2,H_m*zcylinder+H/2,'facecolor','r');
 drone(8) = surface(xcylinder,ycylinder-b/2,H_m*zcylinder+H/2,'facecolor','r');
 alpha(drone(5:8),0.7);
% design 4 propellers
 drone(9)  = patch(xp+b/2,yp,zp+(H_m+H/2),'c','LineWidth',0.5);
 drone(10) = patch(xp-b/2,yp,zp+(H_m+H/2),'c','LineWidth',0.5);
 drone(11) = patch(xp,yp+b/2,zp+(H_m+H/2),'p','LineWidth',0.5);
 drone(12) = patch(xp,yp-b/2,zp+(H_m+H/2),'p','LineWidth',0.5);
 alpha(drone(9:12),0.3);
%% create a group object and parent surface
  combinedobject = hgtransform('parent',hg );
  set(drone,'parent',combinedobject)
%  drawnow
 
 for i = 1:length(x)
  
     ba = plot3(ax1, x(1:i),y(1:i),z(1:i), ':','Color','b','LineWidth',2);
%      text(1,1,1,['current time: ' num2str(time(i)) 's'],'FontSize',20);
     
     ba2 = plot3(ax2, x(1:i),y(1:i),z(1:i), ':','Color','b','LineWidth',2);
%      plot(ax2, ref(i,1),ref(i,2),':','Color','r','LineWidth',1.5)
   
     translation = makehgtform('translate',...
                               [x(i) y(i) z(i)]);
     %set(combinedobject, 'matrix',translation);
     rotation0 = makehgtform('zrotate',deg2rad(45)); % this rotate drones coordinate axis for roll pitch yaw
     rotation1 = makehgtform('xrotate',(roll(i)));
     rotation2 = makehgtform('yrotate',(pitch(i)));
     rotation3 = makehgtform('zrotate',yaw(i));
%      scaling = makehgtform('scale',1-i/20);
     set(combinedobject,'matrix',...
          translation*rotation3*rotation2*rotation1*rotation0);
      %movieVector(i) =  getframe(fig1);
        %delete(b);
     drawnow
   % pause(0.2);
 end
