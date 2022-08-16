clear,clc,close all
syms s
d = 0.1;
F{1} = 1-d*s/2==0;
F{2} = 1+d*s/2==0;
F{3} = 1-d*s/2+(d*s)^2/12==0;
F{4} = 1+d*s/2+(d*s)^2/12==0;
F{5} = 1-d*s/2+3*(d*s)^2/28-(d*s)^3/84+(d*s)^4/1680==0;
F{6} = 1+d*s/2+3*(d*s)^2/28+(d*s)^3/84+(d*s)^4/1680==0;
F{7} = 1-d*s/2+3*(d*s)^2/35-(d*s)^3/60+(d*s)^4/624-(d*s)^5/9360+(d*s)^6/205920-(d*s)^7/7207200+(d*s)^8/518918400==0;
F{8} = 1+d*s/2+3*(d*s)^2/35+(d*s)^3/60+(d*s)^4/624+(d*s)^5/9360+(d*s)^6/205920+(d*s)^7/7207200+(d*s)^8/518918400==0;
figure
j=1;
n = [1 2 4 8];
for i=1:2:7 
    h(i) = subplot(2,2,j);
    zrs = solve(F{i});
    ples = solve(F{i+1});
    plot(real(zrs),imag(zrs),'o',"MarkerSize",6)
    hold on,xline(0),yline(0),grid on
    plot(real(ples),imag(ples),'x',"MarkerSize",6)
    xlim(double([min(real(ples))*1.2 max(real(zrs))*1.2]))
    if max(imag(zrs))~=0
        ylim(double([min(imag(ples))*1.2 max(imag(zrs))*1.2]))
    end
    xlabel("$\mathcal{R}$","Interpreter","latex")
    ylabel("$\mathcal{I}$","Interpreter","latex")
    eval("title('$n="+n(j)+"$','Interpreter','latex')")
    j = j+1;
end


