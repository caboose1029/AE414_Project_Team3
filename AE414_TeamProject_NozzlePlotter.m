syms m;
x = linspace(0,308.2,3083);
x1 = find(abs(x-3.8) < 0.001);
gamma = 1.2;
P_0 = 2e6;

for i = 1:length(x)
    
    if x <= x1
        r(i) = 26.6 - sqrt(7.6^2 - x(i).^2);
    else
        r(i) = 20.0182 - 0.00928 .* (x(i) - 3.8) - 40.22 + (47.19 .* (x(i) - 3.8) + 1618).^0.5;
    end
    
    A(i) = pi*r(i)^2;
    A_t = A(1);
    A_s(i) = A(i)/A_t;

    [mach(i), P(i)] = flowisentropic(gamma,A_s(i),'sup');
    Pressure(i) = P(i)*P_0;
end

figure(1)
tiledlayout(3,1)

hold on;
ax1 = nexttile;
plot(ax1,x,r,x,-r,'color','black','LineWidth', 1);
%plot(ax1,x,-r,'color','black', 'LineWidth', 1);
yline(ax1,0,'-.b','Centerline');
xlim([0,308.2])
title(ax1,'Cross-Section of a Rocket Nozzle');
xlabel(ax1,'Length');
ylabel(ax1, 'Height Above Centerline');
hold off;

ax2 = nexttile;
plot(ax2,x,mach)
title(ax2, 'Mach')
ylabel(ax2, 'Mach Number')

ax3 = nexttile;
plot(ax3,x,Pressure)
title(ax3, 'Pressure')
