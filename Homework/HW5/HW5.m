 clc
 clear
 
 % Diary
 dfile ='MATLAB_Output_OM.txt';
 if exist(dfile, 'file') ; delete(dfile); end
 diary(dfile)
 diary on
 diary MATLAB_Output_OM.txt
 
 %Introduction
 fprintf('--------------------------------------------------------------\n');
 fprintf('Oscar Martinez \t Homework 5: Problems 1-3 \t STA 5106\n');
 fprintf('--------------------------------------------------------------\n');
 
 %-----Problem 1:-----
 fprintf('-----------Problem 1----------\n');
 
 %Part i
 fprintf('---Part (i): Simple Iterations---\n');
 
 %Define the function inline
 f = inline('0.9*sin(x)-x', 'x');
 
 x0 = pi/4;
 
 xa(1) = x0;
 gxa = f(xa(1))+xa(1);
 i = 1;
 while (abs(xa(i) - gxa) > 1e-6)
 gxa = xa(i);
 xa(i+1) = f(xa(i)) + xa(i);
 i = i+1;
 end
 %xa(i)
 i
 
 
 %Part ii
 fprintf('---Part (ii): Newton-Raphson---\n');
 
 % define the function
 h = inline('0.9*sin(x)-x', 'x');
 x0 = pi/4;
 dh = inline('0.9*cos(x)-1', 'x');
 
 %The N-R algorithm
 clear x;
 x0 = pi/4;
 x(1) = x0;
 gx = x(1)-h(x(1))/dh(x(1));
 i = 1;
 while (abs(x(i) - gx) > 1e-6)
 gx = x(i);
 x(i+1) = x(i) - h(x(i))/dh(x(i));
 i = i+1;
 end
 x
 i
 
 %Part iii
 fprintf('---Part (iii): Plot---\n');
 
 % plot the function
 t = -1:0.1:2;
 yt = f(t);
 figure(1);
 subplot(2,1,1);
 Y=plot(t,yt, 'c-');
 hold on;
 XP=[pi/4 xa(106) x(5)];
 YP=[f(pi/4) f(xa(11)) f(x(5))];
 labels = {'x0','I','N-R'};
 plot(XP,YP,'o');
 text(XP,YP,labels,'VerticalAlignment','bottom','HorizontalAlignment','left')
 Z=plot([-1 1], [0 0], 'r');
 grid on;
 grid minor;
 title('Problem 1')
 axis([-.4 1 -.5 .5]);
 set(gca, 'fontsize', 16);
 legend([Y Z],{'0.9*sin(x)-x','f(x)=0'})
 subplot(2,1,2);
 plot(x,'r');
 grid on;
 grid minor;
 hold on;
 plot(xa,'b');
 set(gca, 'fontsize', 16);
 axis([0 100 -.25 1])
 legend('Newton-Raphson','Iteration')
 hold off;
 
 
 %-----Problem 2:-----
 fprintf('----------Problem 2----------\n');
 clear x;
 
 %Define the function
 f2 = inline('x.^5 - 4.5*x.^4 +4.55*x.^3 + 2.675*x.^2 -3.3*x -1.4375', 'x');
 
 %Find the Roots
 p=[1 -4.5 4.55 2.675 -3.3 -1.4375];
 r=roots(p);
 
 %Find the multiplicity of root "rt"
 rt=-0.5; %Define the wanted root
 [s,t]=size(r);
 m=0;
 for j = 1:s
 if abs(rt-r(j)) < 1e-6
 m=m+1;
 end
 end
 m
 K=(m-1)/m
 
 %Begin the N-R Algorigthm
 x0 = -0.6;
 df2 = inline('5*x.^4 -4*4.5*x.^3 +3*4.55*x.^2 + 2*2.675*x -3.3', 'x');
 clear x;
 x(1) = x0;
 gx = x(1)-f2(x(1))/df2(x(1));
 i = 1;
 while (abs(x(i) - gx) > 1e-6)
 gx = x(i);
 x(i+1) = x(i) - f2(x(i))/df2(x(i));
 i = i+1;
 end
 x
 i
 
 %Alternate way to find K
 %Get E
 for j = 1:i-1
 E(j)=abs(x(j)-x(j+1));
 end
 %K~Ei+1/E
 for j = 1:i-2
 Kalt=min(E(j+1)/E(j));
 end
 Kalt %K=(m-1)/m
 Malt=1/(1-K) %1/(1-K)
 
 %Plot
 figure(2)
 t=[-5:0.1:5];
 yt=f2(t);
 Y=plot(t, yt);
 hold on;
 Z=plot([-5 5], [0 0], 'r');
 %plot(r, 0, 'go', r, f2(r), 'co', x(i), f2(x(i)), 'ro');
 XP2=[-0.6 x(i)];
 YP2=[f2(-0.6) f2(x(18))];
 labels = {'x0','N-R'};
 plot(XP2,YP2,'o');
 text(XP2,YP2,labels,'VerticalAlignment','bottom','HorizontalAlignment','right')
 axis([-2 2 -1 1]);
 legend([Y Z],{'5*x.^4 -4*4.5*x.^3 +3*4.55*x.^2 + 2*2.675*x -3.3','f(x)=0'});
 ax=gca;
 ax.FontSize=16;
 grid on;
 grid minor;
 title('Problem 2')
 hold off;
 
 
 %-----Problem 3:-----
 fprintf('----------Problem 3----------\n');
 
 clear
 %Load the data
 load hw5_3_data.mat
 [m,n]=size(X);
 
 theta0 = 7;
 
 
 %N-R Algo
 theta(1) = theta0;
 %LogL=LogL + x(i) - X(j)-2*log(1+exp(x(i)-X(j)));
 i = 1;
 dtheta = theta(1)+.5;
 while (abs(theta(i) - dtheta) > 1e-6)
 dtheta = theta(i);
 dLogL = sum(1-2*(exp(theta(i)-X)./(1+exp(theta(i)-X))));
 ddLogL = -2*sum(exp(theta(i)-X)./(1+exp(theta(i)-X)).^2);
 theta(i+1) = theta(i) - dLogL/ddLogL;
 i = i+1;
 end
 i
 theta(i)
 
 diary off
