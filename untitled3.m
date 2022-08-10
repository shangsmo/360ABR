m = zeros([1,361]);
n = zeros([1,361]);
o = zeros([1,361]);
for i=1:361
    m(i)=PSNR(1,1,i);
    n(i)=PSNR(30,1,i);
    o(i)=PSNR(66,1,i);
end
plot(m,'linewidth',2)
hold on;
plot(n,'linewidth',2);
hold on;
plot(o,'linewidth',2);
xlabel('Time(s)','FontSize',12)
ylabel('PSNR(db)','FontSize',12)
xlim([1,360]);
ylim([1,60]);
legend('The tile at the top left corner','The tile of the center position','The tile of the lower edge position','FontSize',12)
legend boxoff;