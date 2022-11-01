clc; clear all; close all;

% root of the Discriminant to find range of x:
% Discriminant: -4x^2-24x-16=0
r = roots([-4 -24 -16]);
x = min(r):0.0001:max(r);

y1 = (-(2*x+4)+sqrt(-4*x.^2-24*x-16))/2;
y2 = (-(2*x+4)-sqrt(-4*x.^2-24*x-16))/2;
plot(x, y1, 'k-', 'linewidth', 1.5)
hold on
plot(x, y2, 'b-', 'linewidth', 1.5)
xlabel('x'); ylabel('y');

% Now considering Second Equation of Ellipse:
% Finding range of x, solving x^2+6x+7?0 for x 
r1 = roots([1 6 7]);
x1 = min(r1):0.0001:max(r1);

y11 =  3*sqrt(4-2*(x1+3).^2);
y22 = -3*sqrt(4-2*(x1+3).^2);

plot(x1, y11, 'r-', 'linewidth', 1.5)
plot(x1, y22, 'g-', 'linewidth', 1.5)
grid on
grid minor

% Applying Newton-Raphson's method:
f1 = @(x) (-(2*x+4)+sqrt(-4*x.^2-24*x-16))/2;
f2 = @(x) (-(2*x+4)-sqrt(-4*x.^2-24*x-16))/2;
f3 = @(x)  3*sqrt(4-2*(x+3).^2);
f4 = @(x) -3*sqrt(4-2*(x+3).^2);

f_Br = @(x) f3(x) - f1(x);      % Black-Red Intersection.
f_br = @(x) f3(x) - f2(x);      % Blue-Red Intersection.
f_bg = @(x) f4(x) - f2(x);      % Blue-Green Intersection.

dx = 1e-7;
df = @(f,x) (f(x+dx) - f(x))/dx;

% First Point Black-Blue intersection
x = 0;
xp = 0;
ea = 1;
while ea>0.0001
    x = x - f_Br(x)/df(f_Br, x);
    ea = abs((x-xp)/x);
    xp = x;
end
pt_x1 = real(x);
pt_y1 = f1(pt_x1);
disp("Black-Blue Intersection: "+string(pt_x1)+" "+string(pt_y1));

axis square

% Second Point Black-Blue intersection
x = -2;
xp = 0;
ea = 1;
while ea>0.0001
    x = x - f_Br(x)/df(f_Br, x);
    ea = abs((x-xp)/x);
    xp = x;
end
pt_x2 = real(x);
pt_y2 = f1(pt_x2);
disp("Black-Blue Intersection: "+string(pt_x2)+" "+string(pt_y2));

% Third Point Blue-Red intersection
x = -3;
xp = -3;
ea = 1;
while ea>0.0001
    x = x - f_br(x)/df(f_br, x);
    ea = abs((x-xp)/x);
    xp = x;
end
pt_x3 = real(x);
pt_y3 = f2(pt_x3);
disp("Blue-Red Intersection: "+string(pt_x3)+" "+string(pt_y3));

% Fourth Point Blue-Red intersection
x = -3;
xp = -3;
ea = 1;
while ea>0.0001
    x = x - f_bg(x)/df(f_bg, x);
    ea = abs((x-xp)/x);
    xp = x;
end
pt_x4 = real(x);
pt_y4 = f2(pt_x4);
disp("Blue-Red Intersection: "+string(pt_x4)+" "+string(pt_y4));
labels = {"("+string(round(pt_x1, 3))+", "+string(round(pt_y1, 3))+")", ...
    "("+string(round(pt_x2,3))+", "+string(round(pt_y2, 3))+")", ...
    "("+string(round(pt_x3,3))+", "+string(round(pt_y3, 3))+")", ...
    "("+string(round(pt_x4,3))+", "+string(round(pt_y4, 3))+")"};
pt_x = [pt_x1 pt_x2 pt_x3 pt_x4];
pt_y = [pt_y1 pt_y2 pt_y3 pt_y4];

plot(pt_x, pt_y, 'O', 'linewidth', 2);
text(pt_x, pt_y, labels,'VerticalAlignment','bottom','HorizontalAlignment','left');

lgd = legend({'$\frac{-(2x+4)+\sqrt{-4x^2-24x-16}}{2}$', ...
    '$\frac{-(2x+4)-\sqrt{-4x^2-24x-16}}{2}$', ...
    '$3\sqrt{4-2(x+3)^2}$', ...
    '$-3\sqrt{4-2(x+3)^2}$', 'Intersection Points'},'Interpreter','latex');
lgd.FontSize = 12;