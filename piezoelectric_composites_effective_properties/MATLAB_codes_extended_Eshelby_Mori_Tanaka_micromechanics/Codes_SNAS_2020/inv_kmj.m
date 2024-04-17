%% Calculation of Greens function for orthotropic material(PVDF) for the
% calculation of eshelby tensor for electroelastic properties of PVDF/PZT 
% composite. 
%calculation of inverse of  Kmj matrix
%this code is written by neelam mishra
clc
clear all
syms C11_m C12_m C13_m C21_m C22_m C23_m C31_m C32_m C33_m C44_m C55_m C66_m e15_m e24_m e31_m e32_m e33_m k11_m k22_m k33_m x1 x2 x3
sym K_mj
K_mj=[C11_m*x1^2+C66_m*x2^2+C55_m*x3^2 (C12_m+C66_m)*x1*x2 (C13_m+C55_m)*x1*x3 (e31_m+e15_m)*x1*x3;
     (C21_m+C66_m)*x1*x2 C66_m*x1^2+C22_m*x2^2+C44_m*x3^2 (C23_m+C44_m)*x2*x3 (e32_m+e24_m)*x2*x3;
     (C55_m+C31_m)*x1*x3 (C44_m+C32_m)*x2*x3 C55_m*x1^2+C44_m*x2^2+C33_m*x3^2 e15_m*x1^2+e24_m*x2^2+e33_m*x3^2;
     (e15_m+e31_m)*x1*x3 (e24_m+e32_m)*x2*x3 e15_m*x1^2+e24_m*x2^2+e33_m*x3^2 -k11_m*x1^2-k22_m*x2^2-k33_m*x3^2;];
 det(K_mj);
 B=inv(K_mj);
C=B./det(K_mj);
diary
diary('cofactors')
%diary off
diary on
diary cofactors
C;
diary off
diary
diary('inverse')
%diary off
diary on
diary inverse
B;
diary off

%% individual elemnts of the inverse K_mj matrix
inv_K_mj_11=B(1,1);
inv_K_mj_12=B(1,2);
inv_K_mj_13=B(1,3);
inv_K_mj_14=B(1,4);
inv_K_mj_21=B(2,1);
inv_K_mj_22=B(2,2);
inv_K_mj_23=B(2,3);
inv_K_mj_24=B(2,4);
inv_K_mj_31=B(3,1);
inv_K_mj_32=B(3,2);
inv_K_mj_33=B(3,3);
inv_K_mj_34=B(3,4);
inv_K_mj_41=B(4,1);
inv_K_mj_42=B(4,2);
inv_K_mj_43=B(4,3);
inv_K_mj_44=B(4,4);

