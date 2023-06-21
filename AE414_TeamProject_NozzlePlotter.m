syms m;
x = linspace(0,308.2,3083);
x1 = find(abs(x-3.8) < 0.001);
gamma = 1.2;
P_a = 0.101e6;
P_01 = 2e6;
P_02 = 1.5e6;
T_0 = 2400;
M_hat = 12;
R_hat = 8314.3;

R = R_hat / M_hat;

for i = 1:length(x)
    
    if x <= x1
        r(i) = 26.6 - sqrt(7.6^2 - x(i).^2);
    else
        r(i) = 20.0182 - 0.00928 .* (x(i) - 3.8) - 40.22 + (47.19 .* (x(i) - 3.8) + 1618).^0.5;
    end
    
    A(i) = pi*r(i)^2;
    A_t = A(1);
    A_s(i) = A(i)/A_t;

    [mach(i), T(i), P(i), rho(i)] = flowisentropic(gamma,A_s(i),'sup');
    
    P1(i) = P(i)*P_01;
    P2(i) = P(i)*P_02;
    T_e(i) = T(i)*T_0;

end

% Calculations with P_0 = 2 MPa
M_e1 = mach(length(x));
P_e1 = P1(length(x));
T_e1 = T_e(length(x));
rho_e1 = rho(length(x));
A_e1 = A(length(x)) / 10000;

u_e1 = M_e1 * sqrt(gamma * R * T_e1);

mdot_e1 = rho_e1 * u_e1 * A_e1;

T1 = mdot_e1 * u_e1 + (P_e1 - P_a) * A_e1;

% Calculations with P_0 = 1.5 MPa
P_sep = 0.35 * P_a;
loc = find(abs(P2-P_sep) < 0.1);

M_e2 = mach(length(loc));
P_e2 = P1(length(loc));
T_e2 = T_e(length(loc));
rho_e2 = rho(length(loc));
A_e2 = A(length(loc)) / 10000;

u_e2 = M_e1 * sqrt(gamma * R * T_e2);

mdot_e2 = rho_e2 * u_e2 * A_e2;

T2 = mdot_e2 * u_e2 + (P_e2 - P_a) * A_e2;


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
plot(ax3,x,P1)
title(ax3, 'Pressure')
