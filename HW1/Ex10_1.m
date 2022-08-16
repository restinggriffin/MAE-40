clear,clc,close all
syms C1 C2 C3 C4 C5
Ca = (C1*C2 + C1*C3 + C2*C3)/C3;
Cb = (C1*C2 + C1*C3 + C2*C3)/C2;
Cc = (C1*C2 + C1*C3 + C2*C3)/C1;
C = 1/(1/Ca+1/(1/(1/Cb+1/C4)+1/(1/Cc+1/C5)));
C = simplify(C)