x = linspace(0,308.2,3083);
x1 = find(abs(x-3.8) < 0.001);
r = [];

for i = 1:x1
    r(i) = 26.6 - sqrt(7.6^2 - x(i).^2);
end

for i = (x1 +1):3083
    r(i) = 20.0182 - 0.00928 .* (x(i) - 3.8) - 40.22 + (47.19 .* (x(i) - 3.8) + 1618).^0.5;
end

figure(1)

hold on

plot(x,r,'color','black','LineWidth', 1);
plot(x,-r,'color','black', 'LineWidth', 1);
yline(0,'-.b','Centerline');
xlim([0,308.2])

title('Cross-Section of a Rocket Nozzle');
xlabel('Length');
ylabel('Height Above Centerline');

hold off