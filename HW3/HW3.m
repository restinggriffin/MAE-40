%% 3a
clear,clc,close all
syms V1 Vn vp V2 V3 va vb vc R r f M1 M2 M3 ma mb mc Vout I1 I2 I3 ia ib ic IR io
%equations from Kirchhoff's laws and approximation for op amp with negative
%feedback
eqn(1) = V1-Vn==I1*R/M1;
eqn(2) = V2-Vn==I2*R/M2;
eqn(3) = V3-Vn==I3*R/M3;
eqn(4) = I1+I2+I3==IR;
eqn(5) = Vn-Vout==IR*R;
eqn(6) = va-vp==ia*r/ma;
eqn(7) = vb-vp==ib*r/mb;
eqn(8) = vc-vp==ic*r/mc;
eqn(9) = ia+ib+ic==io;
eqn(10) = vp==io*r/abs(f);
eqn(11) = Vn==vp;
eqn(12) = f==ma+mb+mc-M1-M2-M3-1;
eqn(13) = f<0;
temp = "eqn(1)"; %so I don't need to type the long line.
for i=2:13 
    temp = temp+",eqn("+num2str(i)+")";
end
eval("sol = solve("+temp+",I1,I2,I3,ia,ib,ic,vp,Vn,Vout,f,R,r);") %solve the 13 equations
%included other variables in solve so MATLAB won't include them in the answer. 
Vout_sol = simplify(sol.Vout) %only interested in Vout

%% 3b
clear,clc,close all
syms V1 Vn vp V2 V3 va vb vc R r f M1 M2 M3 ma mb mc Vout I1 I2 I3 ia ib ic IR Io
%equations from Kirchhoff's laws and approximation for op amp with negative
%feedback
eqn(1) = V1-Vn==I1*R/M1;
eqn(2) = V2-Vn==I2*R/M2;
eqn(3) = V3-Vn==I3*R/M3;
eqn(4) = I1+I2+I3==IR+Io;
eqn(5) = Vn-Vout==IR*R;
eqn(6) = va-vp==ia*r/ma;
eqn(7) = vb-vp==ib*r/mb;
eqn(8) = vc-vp==ic*r/mc;
eqn(9) = ia+ib+ic==0;
eqn(10) = Vn==Io*r/f;
eqn(11) = Vn==vp;
eqn(12) = f==ma+mb+mc-M1-M2-M3-1;
eqn(13) = f>0;
temp = "eqn(1)"; %so I don't need to type the long line.
for i=2:13 
    temp = temp+",eqn("+num2str(i)+")";
end
eval("sol = solve("+temp+",I1,I2,I3,ia,ib,ic,vp,Vn,Vout,IR,Io,f,R,r);") %solve the 13 equations
%included other variables in solve so MATLAB won't include them in the answer. 
Vout_sol = simplify(sol.Vout)%only interested in Vout
%% 4
clear,clc,close all
syms C s R R1 R2 Vin A a
%The 13 equations in matrix form
A = [1 0 0 0 0 0 0 0 C*s 0 0 0 0
     0 R 0 0 0 0 0 0 0 1 0 0 0
     0 0 1 0 0 0 0 0 -C*s 0 C*s 0 0
     0 0 0 R 0 0 0 0 0 -1 1 0 0
     0 0 0 0 1 0 0 0 0 -2*C*s 0 0 0
     0 0 0 0 0 R/2 0 0 -1 0 0 0 1
     0 0 0 0 0 0 R2 0 0 0 0 1 -1
     0 0 0 0 0 0 0 R1 0 0 0 -1 0
     1 0 -1 0 0 -1 0 0 0 0 0 0 0
     0 1 0 -1 -1 0 0 0 0 0 0 0 0
     0 0 1 1 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 1 -1 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 A*a/(s+a) -A*a/(s+a) -1];
b = [C*s*Vin;Vin;0;0;0;0;0;0;0;0;0;0;0];
x = A\b; %solve the 13x13 linear system
F_notch = simplify(x(13)/Vin) %get Vout/Vin

%% double check 4
syms I1 I2 I3 I4 I5 I6 I7 I8 R R1 R2 C s Vin V1 V2 Vp Vn Vout
%The 13 equations for 13 variables
eqn(1) = I1==C*s*(Vin-V1);
eqn(2) = Vin-V2==I2*R;
eqn(3) = I3==C*s*(V1-Vp);
eqn(4) = V2-Vp==I4*R;
eqn(5) = I5==2*C*s*V2;
eqn(6) = V1-Vout==I6*R/2;
eqn(7) = Vout-Vn==I7*R2;
eqn(8) = Vn==I8*R1;
eqn(9) = I1==I3+I6;
eqn(10) = I2==I4+I5;
eqn(11) = I3+I4==0;
eqn(12) = Vp==Vn; %for comparison
eqn(13) = I7==I8;
temp = "eqn(1)"; %so I don't need to type the long line.
for i=2:13 
    temp = temp+",eqn("+num2str(i)+")";
end
eval("sol = solve("+temp+",I1,I2,I3,I4,I5,I6,I7,I8,V1,V2,Vp,Vn,Vout);")
F = simplify(sol.Vout/Vin)