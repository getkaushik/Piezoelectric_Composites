%% calculating the effective electroelastic properties of PVDF/PZT composite using 
%Eshelby-Mori-Tanaka method. Reference for properties of PVDF and PZT is 
% Constitutive modelling of piezoeectric polymer composites by Odegard
%and eshelby tensors is calculated by neelam mishra 
%general ellipsoid problem when the axis of orientation is about the x3
%axis
%this code is written by neelam mishra
clc
clear all
format long
alpha=1;% aspect ratio a1./a2
%% Material properties of PVDF (matrix)
e0 = 8.85418782e-12; % Permittivity of free space, Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
C11_m=3.8e9;% units in GPa,Component of stiffness matrix
C12_m=1.9e9;% units in GPa,Component of stiffness matrix
C13_m=1e9;% units in GPa,Component of stiffness matrix
C31_m=C13_m;
C21_m=C12_m;
C22_m=3.2e9;% units in GPa,Component of stiffness matrix
C23_m=0.9e9;% units in GPa,Component of stiffness matrix
C32_m=C23_m;
C33_m=1.2e9;% units in GPa,Component of stiffness matrix
C44_m=0.7e9;% units in GPa,Component of stiffness matrix
C55_m=0.9e9;% unitss in GPa,Component of stiffness matrix
C66_m=0.9e9;% units in GPa,Component of stiffness matrix
k11_m=7.4.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k22_m=9.3.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k33_m=7.6.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
e15_m=0;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_m=0;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_m=0.024;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_m=0.001;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_m=-0.027;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
E_m=     [C11_m,C12_m, C13_m, 0, 0, 0, 0, 0, e31_m;
         C12_m,C22_m, C23_m, 0, 0, 0, 0, 0, e32_m;
         C13_m,C23_m, C33_m, 0, 0, 0, 0, 0, e33_m;
         0, 0, 0, C44_m, 0, 0, 0, e15_m, 0;
         0, 0, 0, 0, C55_m, 0, e24_m, 0, 0;
         0, 0, 0, 0, 0, C66_m, 0, 0, 0;
         0, 0, 0, 0, e15_m, 0, -k11_m, 0, 0;
         0, 0, 0, e24_m, 0, 0, 0, -k22_m, 0;
         e31_m, e32_m, e33_m, 0, 0, 0, 0, 0,-k33_m];
     E_m;
 %  Material Properties of PZT-7A (reinforcement)
 C11_f=148e9;% units in GPa,Component of stiffness matrix
C12_f=76.2e9;% units in GPa,Component of stiffness matrix
C13_f=74.2e9;% units in GPa,Component of stiffness matrix
C22_f=148e9;% units in GPa,Component of stiffness matrix
C23_f=74.2e9;% units in GPa,Component of stiffness matrix
C33_f=131e9;% units in GPa,Component of stiffness matrix
C44_f=25.4e9;% units in GPa,Component of stiffness matrix
C55_f=25.4e9;% unitss in GPa,Component of stiffness matrix
C66_f=35.9e9;% units in GPa,Component of stiffness matrix
k1_f=460.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k2_f=460.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k3_f=235.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
e15_f=9.2;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_f=9.2;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_f=-2.1;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_f=-2.1;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_f=9.5;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
E_f=     [C11_f,C12_f, C13_f, 0, 0, 0, 0, 0, e31_f;
         C12_f,C22_f, C23_f, 0, 0, 0, 0, 0, e32_f;
         C13_f,C23_f, C33_f, 0, 0, 0, 0, 0, e33_f;
         0, 0, 0, C44_f, 0, 0, 0, e15_f, 0;
         0, 0, 0, 0, C55_f, 0, e24_f, 0, 0;
         0, 0, 0, 0, 0, C66_f, 0, 0, 0;
         0, 0, 0, 0, e15_f, 0, -k1_f, 0, 0;
         0, 0, 0, e24_f, 0, 0, 0, -k2_f, 0;
         e31_f, e32_f, e33_f, 0, 0, 0, 0, 0,-k3_f];
 %% inverse K_MJ
%  syms C11_m C12_m C13_m C21_m C22_m C23_m C31_m C32_m C33_m C44_m C55_m C66_m e15_m e24_m e31_m e32_m e33_m k11_m k22_m k33_m x1 x2 x3
% sym K_mj
% K_mj=[C11_m.*x1.^2+C66_m.*x2.^2+C55_m.*x3.^2 (C12_m+C66_m).*x1.*x2 (C13_m+C55_m).*x1.*x3 (e31_m+e15_m).*x1.*x3;
%      (C21_m+C66_m).*x1.*x2 C66_m.*x1.^2+C22_m.*x2.^2+C44_m.*x3.^2 (C23_m+C44_m).*x2.*x3 (e32_m+e24_m).*x2.*x3;
%      (C55_m+C31_m).*x1.*x3 (C44_m+C32_m).*x2.*x3 C55_m.*x1.^2+C44_m.*x2.^2+C33_m.*x3.^2 e15_m.*x1.^2+e24_m.*x2.^2+e33_m.*x3.^2;
%      (e15_m+e31_m).*x1.*x3 (e24_m+e32_m).*x2.*x3 e15_m.*x1.^2+e24_m.*x2.^2+e33_m.*x3.^2 -k11_m.*x1.^2-k22_m.*x2.^2-k33_m.*x3.^2;];
%  det(K_mj);
%  B=inv(K_mj);
% C=B./det(K_mj);
% diary
% diary('cofactors')
% %diary off
% diary on
% diary cofactors
% C;
% diary off
% diary
% diary('inverse')
% %diary off
% diary on
% diary inverse
% B;
% diary off
% 
% % individual elemnts of the inverse K_mj matrix
% inv_K_mj_11=B(1,1);
% inv_K_mj_12=B(1,2);
% inv_K_mj_13=B(1,3);
% inv_K_mj_14=B(1,4);
% inv_K_mj_21=B(2,1);
% inv_K_mj_22=B(2,2);
% inv_K_mj_23=B(2,3);
% inv_K_mj_24=B(2,4);
% inv_K_mj_31=B(3,1);
% inv_K_mj_32=B(3,2);
% inv_K_mj_33=B(3,3);
% inv_K_mj_34=B(3,4);
% inv_K_mj_41=B(4,1);
% inv_K_mj_42=B(4,2);
% inv_K_mj_43=B(4,3);
% inv_K_mj_44=B(4,4);

%%  I1111
 syms theta phi y1 y2 y3
 y1=sin(theta).*cos(phi);
 y2=sin(theta).*sin(phi);
 y3=cos(theta);

 i1111=matlabFunction((sin(theta).*y1.^2.*((C66_m.*e15_m.^2.*y1.^6 + C22_m.*alpha.^6.*e24_m.^2.*y2.^6 + C55_m.*C66_m.*k11_m.*y1.^6 + C22_m.*alpha.^2.*e15_m.^2.*y1.^4.*y2.^2 + C66_m.*alpha.^4.*e24_m.^2.*y1.^2.*y2.^4 + C22_m.*C44_m.*alpha.^6.*k22_m.*y2.^6 + C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 + C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + 2.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^2.*y2.^4 + 2.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^4.*y2.^2)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
 %i1111=@(theta,phi) ((C66_m.*e15_m.^2.*y1.^6 + C22_m.*alpha.^6.*e24_m.^2.*y2.^6 + C55_m.*C66_m.*k11_m.*y1.^6 + C22_m.*alpha.^2.*e15_m.^2.*y1.^4.*y2.^2 + C66_m.*alpha.^4.*e24_m.^2.*y1.^2.*y2.^4 + C22_m.*C44_m.*alpha.^6.*k22_m.*y2.^6 + C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 + C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + 2.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^2.*y2.^4 + 2.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^4.*y2.^2)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))
 I1111=integral2(i1111,0,pi,0,2.*pi)
 G1111=I1111;

% syms t phi y1 y2 y3
% y1=sqrt(1-t.^2).*cos(phi);
% y2=sqrt(1-t.^2).*sin(phi); 
% y3=t;
% 
% i1111=matlabFunction((y1.^2.*((C66_m.*e15_m.^2.*y1.^6 + C22_m.*alpha.^6.*e24_m.^2.*y2.^6 + C55_m.*C66_m.*k11_m.*y1.^6 + C22_m.*alpha.^2.*e15_m.^2.*y1.^4.*y2.^2 + C66_m.*alpha.^4.*e24_m.^2.*y1.^2.*y2.^4 + C22_m.*C44_m.*alpha.^6.*k22_m.*y2.^6 + C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 + C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + 2.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^2.*y2.^4 + 2.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^4.*y2.^2)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[t,phi])
% I1111=integral2(i1111,-1,1,0,2.*pi)

i1122=matlabFunction((sin(theta).*y1.^2.*((C11_m.*e15_m.^2.*y1.^6 + C66_m.*alpha.^6.*e24_m.^2.*y2.^6 + C11_m.*C55_m.*k11_m.*y1.^6 + C11_m.*alpha.^4.*e24_m.^2.*y1.^2.*y2.^4 + C66_m.*alpha.^2.*e15_m.^2.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6 + C11_m.*C44_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C11_m.*C44_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C11_m.*C55_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 + C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + 2.*C11_m.*alpha.^2.*e15_m.*e24_m.*y1.^4.*y2.^2 + 2.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^2.*y2.^4)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I1122=integral2(i1122,0,pi,0,2.*pi)
G2211=I1122;

i1133=matlabFunction((sin(theta).*y1.^2.*((C11_m.*C66_m.*k11_m.*y1.^6 + C22_m.*C66_m.*alpha.^6.*k22_m.*y2.^6 + C11_m.*C22_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 - C12_m.*C21_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C11_m.*C22_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 - C12_m.*C21_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 - C12_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 - C21_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C11_m.*C66_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + C22_m.*C66_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 - C12_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 - C21_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I1133=integral2(i1133,0,pi,0,2.*pi)
G3311=I1133;

i1144=matlabFunction((sin(theta).*y1.^2.*(-(C11_m.*C55_m.*C66_m.*y1.^6 + C22_m.*C44_m.*C66_m.*alpha.^6.*y2.^6 + C11_m.*C22_m.*C44_m.*alpha.^4.*y1.^2.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*y1.^2.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*y1.^4.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*y1.^4.*y2.^2 + C11_m.*C44_m.*C66_m.*alpha.^2.*y1.^4.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*y1.^2.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*y1.^4.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*y1.^2.*y2.^4 - C21_m.*C55_m.*C66_m.*alpha.^2.*y1.^4.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*y1.^2.*y2.^4)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I1144=integral2(i1144,0,pi,0,2.*pi)
G4411=I1144;

i1112=matlabFunction((sin(theta).*y1.^2.*(-(C12_m.*alpha.*e15_m.^2.*y1.^5.*y2 + C66_m.*alpha.*e15_m.^2.*y1.^5.*y2 + C12_m.*alpha.^5.*e24_m.^2.*y1.*y2.^5 + C66_m.*alpha.^5.*e24_m.^2.*y1.*y2.^5 + C12_m.*C55_m.*alpha.*k11_m.*y1.^5.*y2 + C55_m.*C66_m.*alpha.*k11_m.*y1.^5.*y2 + C12_m.*C44_m.*alpha.^5.*k22_m.*y1.*y2.^5 + C44_m.*C66_m.*alpha.^5.*k22_m.*y1.*y2.^5 + C12_m.*C44_m.*alpha.^3.*k11_m.*y1.^3.*y2.^3 + C12_m.*C55_m.*alpha.^3.*k22_m.*y1.^3.*y2.^3 + C44_m.*C66_m.*alpha.^3.*k11_m.*y1.^3.*y2.^3 + C55_m.*C66_m.*alpha.^3.*k22_m.*y1.^3.*y2.^3 + 2.*C12_m.*alpha.^3.*e15_m.*e24_m.*y1.^3.*y2.^3 + 2.*C66_m.*alpha.^3.*e15_m.*e24_m.*y1.^3.*y2.^3)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I1112=integral2(i1112,0,pi,0,2.*pi);
G1211=I1112;
G2111=G1211;

I1113=0;
G1311=0;
G3111=0;

I1114=0;
G1411=0;
G4111=0;

I1123=0;
G2311=0;
G3211=0;

I1124=0;
G4211=0;
G2411=0;

 
I1134=0;
I1143=0;
G3411=0;
G4311=0;

i2211=matlabFunction((sin(theta).*(alpha.^2).*y2.^2.*((C66_m.*e15_m.^2.*y1.^6 + C22_m.*alpha.^6.*e24_m.^2.*y2.^6 + C55_m.*C66_m.*k11_m.*y1.^6 + C22_m.*alpha.^2.*e15_m.^2.*y1.^4.*y2.^2 + C66_m.*alpha.^4.*e24_m.^2.*y1.^2.*y2.^4 + C22_m.*C44_m.*alpha.^6.*k22_m.*y2.^6 + C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 + C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + 2.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^2.*y2.^4 + 2.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^4.*y2.^2)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I2211=integral2(i2211,0,pi,0,2.*pi)
G1122=I2211;

i2222=matlabFunction((sin(theta).*(alpha.^2).*y2.^2.*((C11_m.*e15_m.^2.*y1.^6 + C66_m.*alpha.^6.*e24_m.^2.*y2.^6 + C11_m.*C55_m.*k11_m.*y1.^6 + C11_m.*alpha.^4.*e24_m.^2.*y1.^2.*y2.^4 + C66_m.*alpha.^2.*e15_m.^2.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6 + C11_m.*C44_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C11_m.*C44_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C11_m.*C55_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 + C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + 2.*C11_m.*alpha.^2.*e15_m.*e24_m.*y1.^4.*y2.^2 + 2.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^2.*y2.^4)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I2222=integral2(i2222,0,pi,0,2.*pi)
G2222=I2222;

i2233=matlabFunction((sin(theta).*(alpha.^2).*y2.^2.*((C11_m.*C66_m.*k11_m.*y1.^6 + C22_m.*C66_m.*alpha.^6.*k22_m.*y2.^6 + C11_m.*C22_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 - C12_m.*C21_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C11_m.*C22_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 - C12_m.*C21_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 - C12_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 - C21_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C11_m.*C66_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + C22_m.*C66_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 - C12_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 - C21_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I2233=integral2(i2233,0,pi,0,2.*pi);
G3322=I2233;

i2244=matlabFunction((sin(theta).*(alpha.^2).*y2.^2.*(-(C11_m.*C55_m.*C66_m.*y1.^6 + C22_m.*C44_m.*C66_m.*alpha.^6.*y2.^6 + C11_m.*C22_m.*C44_m.*alpha.^4.*y1.^2.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*y1.^2.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*y1.^4.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*y1.^4.*y2.^2 + C11_m.*C44_m.*C66_m.*alpha.^2.*y1.^4.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*y1.^2.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*y1.^4.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*y1.^2.*y2.^4 - C21_m.*C55_m.*C66_m.*alpha.^2.*y1.^4.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*y1.^2.*y2.^4)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I2244=integral2(i2244,0,pi,0,2.*pi);
G4422=I2244;

i2212=matlabFunction((sin(theta).*(alpha.^2).*y2.^2.*(-(C12_m.*alpha.*e15_m.^2.*y1.^5.*y2 + C66_m.*alpha.*e15_m.^2.*y1.^5.*y2 + C12_m.*alpha.^5.*e24_m.^2.*y1.*y2.^5 + C66_m.*alpha.^5.*e24_m.^2.*y1.*y2.^5 + C12_m.*C55_m.*alpha.*k11_m.*y1.^5.*y2 + C55_m.*C66_m.*alpha.*k11_m.*y1.^5.*y2 + C12_m.*C44_m.*alpha.^5.*k22_m.*y1.*y2.^5 + C44_m.*C66_m.*alpha.^5.*k22_m.*y1.*y2.^5 + C12_m.*C44_m.*alpha.^3.*k11_m.*y1.^3.*y2.^3 + C12_m.*C55_m.*alpha.^3.*k22_m.*y1.^3.*y2.^3 + C44_m.*C66_m.*alpha.^3.*k11_m.*y1.^3.*y2.^3 + C55_m.*C66_m.*alpha.^3.*k22_m.*y1.^3.*y2.^3 + 2.*C12_m.*alpha.^3.*e15_m.*e24_m.*y1.^3.*y2.^3 + 2.*C66_m.*alpha.^3.*e15_m.*e24_m.*y1.^3.*y2.^3)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I2212=integral2(i2212,0,pi,0,2.*pi);
G1222=I2212;
G2122=G1222;


I2213=0;
G1322=0;
G3122=0

I2214=0;
G1422=0;
G4122=0

I2223=0;
G2322=0;
G3222=0;

I2224=0;
G2422=0;
G4222=0;



I2234=0;
I4322=0;
G3422=0;
G4322=0;

i1211=matlabFunction((sin(theta).*alpha.*y1.*y2.*((C66_m.*e15_m.^2.*y1.^6 + C22_m.*alpha.^6.*e24_m.^2.*y2.^6 + C55_m.*C66_m.*k11_m.*y1.^6 + C22_m.*alpha.^2.*e15_m.^2.*y1.^4.*y2.^2 + C66_m.*alpha.^4.*e24_m.^2.*y1.^2.*y2.^4 + C22_m.*C44_m.*alpha.^6.*k22_m.*y2.^6 + C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 + C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + 2.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^2.*y2.^4 + 2.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^4.*y2.^2)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I1211=integral2(i1211,0,pi,0,2.*pi);
G1112=I1211;
G1121=G1112;

i1222=matlabFunction((sin(theta).*alpha.*y1.*y2.*((C11_m.*e15_m.^2.*y1.^6 + C66_m.*alpha.^6.*e24_m.^2.*y2.^6 + C11_m.*C55_m.*k11_m.*y1.^6 + C11_m.*alpha.^4.*e24_m.^2.*y1.^2.*y2.^4 + C66_m.*alpha.^2.*e15_m.^2.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6 + C11_m.*C44_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C11_m.*C44_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + C11_m.*C55_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 + C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 + 2.*C11_m.*alpha.^2.*e15_m.*e24_m.*y1.^4.*y2.^2 + 2.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^2.*y2.^4)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I1222=integral2(i1222,0,pi,0,2.*pi)
G2212=I1222;
G2221=G2212;

i1233=matlabFunction((sin(theta).*alpha.*y1.*y2.*((C11_m.*C66_m.*k11_m.*y1.^6 + C22_m.*C66_m.*alpha.^6.*k22_m.*y2.^6 + C11_m.*C22_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 - C12_m.*C21_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C11_m.*C22_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 - C12_m.*C21_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 - C12_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 - C21_m.*C66_m.*alpha.^2.*k11_m.*y1.^4.*y2.^2 + C11_m.*C66_m.*alpha.^2.*k22_m.*y1.^4.*y2.^2 + C22_m.*C66_m.*alpha.^4.*k11_m.*y1.^2.*y2.^4 - C12_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4 - C21_m.*C66_m.*alpha.^4.*k22_m.*y1.^2.*y2.^4)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I1233=integral2(i1233,0,pi,0,2.*pi)
G3312=I1233;
G3321=G3312;


i1244=matlabFunction((sin(theta).*alpha.*y1.*y2.*(-(C11_m.*C55_m.*C66_m.*y1.^6 + C22_m.*C44_m.*C66_m.*alpha.^6.*y2.^6 + C11_m.*C22_m.*C44_m.*alpha.^4.*y1.^2.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*y1.^2.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*y1.^4.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*y1.^4.*y2.^2 + C11_m.*C44_m.*C66_m.*alpha.^2.*y1.^4.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*y1.^2.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*y1.^4.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*y1.^2.*y2.^4 - C21_m.*C55_m.*C66_m.*alpha.^2.*y1.^4.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*y1.^2.*y2.^4)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I1244=integral2(i1244,0,pi,0,2.*pi)
G4412=I1244;
G4421=G4412;

i1212=matlabFunction((sin(theta).*alpha.*y1.*y2.*(-(C12_m.*alpha.*e15_m.^2.*y1.^5.*y2 + C66_m.*alpha.*e15_m.^2.*y1.^5.*y2 + C12_m.*alpha.^5.*e24_m.^2.*y1.*y2.^5 + C66_m.*alpha.^5.*e24_m.^2.*y1.*y2.^5 + C12_m.*C55_m.*alpha.*k11_m.*y1.^5.*y2 + C55_m.*C66_m.*alpha.*k11_m.*y1.^5.*y2 + C12_m.*C44_m.*alpha.^5.*k22_m.*y1.*y2.^5 + C44_m.*C66_m.*alpha.^5.*k22_m.*y1.*y2.^5 + C12_m.*C44_m.*alpha.^3.*k11_m.*y1.^3.*y2.^3 + C12_m.*C55_m.*alpha.^3.*k22_m.*y1.^3.*y2.^3 + C44_m.*C66_m.*alpha.^3.*k11_m.*y1.^3.*y2.^3 + C55_m.*C66_m.*alpha.^3.*k22_m.*y1.^3.*y2.^3 + 2.*C12_m.*alpha.^3.*e15_m.*e24_m.*y1.^3.*y2.^3 + 2.*C66_m.*alpha.^3.*e15_m.*e24_m.*y1.^3.*y2.^3)./(C11_m.*C66_m.*e15_m.^2.*y1.^8 + C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 + C11_m.*C55_m.*C66_m.*k11_m.*y1.^8 + C11_m.*C22_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C12_m.*C21_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C22_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C21_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C12_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 - C21_m.*C66_m.*alpha.^2.*e15_m.^2.*y1.^6.*y2.^2 + C11_m.*C66_m.*alpha.^4.*e24_m.^2.*y1.^4.*y2.^4 + C22_m.*C66_m.*alpha.^4.*e15_m.^2.*y1.^4.*y2.^4 - C12_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 - C21_m.*C66_m.*alpha.^6.*e24_m.^2.*y1.^2.*y2.^6 + C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 + C11_m.*C22_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C44_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C22_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C21_m.*C55_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C22_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C12_m.*C21_m.*C44_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + C11_m.*C22_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C12_m.*C21_m.*C55_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C12_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 - C21_m.*C44_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 + C11_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C44_m.*C66_m.*alpha.^6.*k11_m.*y1.^2.*y2.^6 - C12_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^2.*k11_m.*y1.^6.*y2.^2 + C11_m.*C55_m.*C66_m.*alpha.^2.*k22_m.*y1.^6.*y2.^2 + C22_m.*C55_m.*C66_m.*alpha.^4.*k11_m.*y1.^4.*y2.^4 - C12_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 - C21_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 - C21_m.*C55_m.*C66_m.*alpha.^4.*k22_m.*y1.^4.*y2.^4 + C22_m.*C55_m.*C66_m.*alpha.^6.*k22_m.*y1.^2.*y2.^6 + 2.*C11_m.*C22_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C12_m.*C21_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C11_m.*C66_m.*alpha.^2.*e15_m.*e24_m.*y1.^6.*y2.^2 - 2.*C12_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 - 2.*C21_m.*C66_m.*alpha.^4.*e15_m.*e24_m.*y1.^4.*y2.^4 + 2.*C22_m.*C66_m.*alpha.^6.*e15_m.*e24_m.*y1.^2.*y2.^6))),'vars',[theta,phi])
I1212=integral2(i1212,0,pi,0,2.*pi)
G1212=I1212;
G1221=G1212;
G2121=G1212;
G2112=G1212;


I1234=0; %(for this particular material)
I2134=0
I1243=0;
I2143=0;
G1234=0;
G2134=0
G1243=0;
G2143=0;

G1321=0;
G1231=0;
G1421=0;
G3131=0;
G1311=0;
G1131=0;
G1411=0;

G1321=0;
G1231=0;
G1421=0;

G2322=0;
G2232=0;
G2422=0;

G2312=0;
G2132=0;
G2412=0;
G1213=0;
G3211=0;
G1123=0;
G3121=0;
G2312=0;
G2132=0;
G2412=0;
G1313=0;
G1133=0;
G2432=0;
G1413=0;
G3411=0;
G3113=0;
G3223=0;
G3323=0;
G3433=0;
G3333=0;
G1113=0;
G3111=0;
G1223=0;
G3221=0;
G1333=0;
G3331=0;
G1433=0;
G3431=0;
G3313=0;
G1312=0;
G2311=0;
G1132=0;
G2131=0;
G1413=0;
G2411=0
G3133=0;
G1313=0;
G1133=0;
G3131=0;
G1413=0;
G3411=0;
G3323=0
G3223=0;
G3423=0;
G3323=0;
G3233=0;
G3423=0;
G3313=0;
G3133=0;
G3413=0;
G3213=0;
G3123=0;
G2313=0;
G2133=0;
G1323=0;
G1233=0;
G3231=0;
G1423=0;
G3421=0;
G3132=0;
G2413=0;
G3412=0;
G2113=0;
G3112=0;
G2223=0;
G3222=0;
G2333=0;
G3332=0;
G2433=0;
G3432=0;
G1412=0;
G4113=0;
G4312=0;
G4132=0;
G4223=0;
G4333=0;
G4433=0;
G3313=0;
G3133=0;
G3413=0;
G2323=0;
G2423=0;
G2213=0;
G3212=0;
G2123=0;
G3122=0;
G2323=0;
G2233=0;
G4213=0;
G4123=0;
G3232=0;
G2423=0;
G3422=0;
G2313=0;
G2133=0;
G3132=0;
G2133=0;
G3132=0;
G2113=0;
G3112=0;
G2223=0;
G3222=0;
G2333=0;
G3332=0;
G1322=0;
G2321=0;
G1232=0;
G4311=0;
G4131=0;
G2231=0;
G1422=0;
G2421=0;
G2433=0;
G3432=0;
G1323=0;
G3221=0;
G1233=0;
G3231=0;
G1423=0;
G3421=0;
G1332=0;
G2331=0;
G4111=0;
G4221=0;
G4331=0;
G4431=0;
G1432=0;
G2431=0;
G4321=0;
G4231=0;
G4313=0;
G4133=0;
G4413=0;
G4323=0;
G4233=0;
G4423=0;
G4112=0;
G4222=0;
G4332=0;
G4432=0;
G4322=0;
G4232=0;
G1331=0;
G1431=0;

%% the eshelby tensors

S=zeros(9);
%%
S1111=(1/(4*pi))*(C11_m*G1111+C21_m*G1221+C31_m*G1331+e31_m*G1431);
S(1,1)=S1111;

S1122=(1/(4*pi))*(C12_m*G1111+C22_m*G1221+C32_m*G1331+e32_m*G1431);
S(1,2)=S1122;

S1133=(1/(4*pi))*(C13_m*G1111+C23_m*G1221+C33_m*G1331+e33_m*G1431);
S(1,3)=S1133;

S1123=(1/(4*pi))*(C44_m*(G1321+G1231)+e24_m*(G1421));
S(1,4)=S1123;

S1113=(1/(4*pi))*(C55_m*(G1311+G1131)+e15_m*G1411);
S(1,5)=S1113;

S1112=(1/(4*pi))*(C66_m*(G1211+G1121));
S(1,6)=S1112;

S1141=(1/(4*pi))*(e15_m*(G1311+G1131)-k11_m*G1411);
S(1,7)=S1141;

S1142=(1/(4*pi))*(e24_m*(G1321+G1231)-k22_m*G1421);
S(1,8)=S1142;

S1143=(1/(4*pi))*(e31_m*G1111+e32_m*G1221+e33_m*G1331-k33_m*G1431);
S(1,9)=S1143;

%%
G2332=0;
G2432=0
S2211=(1/(4*pi))*(C11_m*G2112+C21_m*G2222+C31_m*G2332+e31_m*G2432);
S(2,1)=S2211;

S2222=(1/(4*pi))*(C11_m*G2112+C22_m*G2222+C32_m*G2332+e32_m*G2432);
S(2,2)=S2222;

S2233=(1/(4*pi))*(C13_m*G2112+C23_m*G2222+C33_m*G2332+e33_m*G2432);
S(2,3)=S2233;

S2223=(1/(4*pi))*(C44_m*(G2322+G2232)+e24_m*G2422)
S(2,4)=S2223;

S2213=(1/(4*pi))*(C55_m*(G2312+G2132)+e15_m*G2412);
S(2,5)=S2213;

S2212=(1/(4*pi))*(C66_m*(G2212+G2122));
S(2,6)=S2212;

S2241=(1/(4*pi))*(e15_m*(G2312+G2132)-k11_m*G2412);
S(2,7)=S2241;

S2242=(1/(4*pi))*(e24_m*(G2322+G2232)-k22_m*G2422);
S(2,8)=S2242;

S2243=(1/(4*pi))*(e31_m*G2112+e32_m*G2222+e33_m*G2332-k33_m*G2432);
S(2,9)=S2243;

%%

S3311=(1/(4*pi))*(C11_m*G3113+C21_m*G3223+C31_m*G3323+e31_m*G3433);
S(3,1)=S3311;

S3322=(1/(4*pi))*(C12_m*G3113+C22_m*G3223+C32_m*G3333+e32_m*G3433);
S(3,1)=S3322;

S3333=(1/(4*pi))*(C13_m*G3113+C23_m*G3223+C33_m*G3323+e33_m*G3433);
S(3,3)=S3333;

G3423=0;
S3323=(1/(4*pi))*(C44_m*(G3323+G3223)+e24_m*G3423);
S(3,4)=S3323;


S3313=(1/(4*pi))*(C55_m*(G3313+G3133)+e15_m*G3413);
S(3,5)=S3313;


S3312=(1/(4*pi))*(C66_m*(G3213+G3123));
S(3,6)=S3312;


S3341=(1/(4*pi))*(e15_m*(G3313+G3133)-k11_m*G3413);
S(3,7)=S3341;


S3342=(1/(4*pi))*(e24_m*(G3323+G3233)-k22_m*G3423);
S(3,8)=S3342;


S3343=(1/(4*pi))*(e31_m*G3113+e32_m*G3223+e33_m*G3333-k33_m*G3433);
S(3,9)=S3343;

%%
S2311=(1/(8*pi))*(C11_m*(G2113+G3112)+C21_m*(G2223+G3222)+C31_m*(G2333+G3332)+e31_m*(G2433+G3432));
S(4,1)=S2311;

S2322=(1/(8*pi))*(C12_m*(G2113+G3112)+C22_m*(G2223+G3222)+C32_m*(G2333+G3332)+e32_m*(G2433+G3432));
S(4,2)=S2322;

S2333=(1/(8*pi))*(C13_m*(G2113+G3112)+C23_m*(G2223+G3222)+C33_m*(G2333+G3332)+e33_m*(G2433+G3432));
S(4,3)=S2333;



S2323=(1/(8*pi))*(C44_m*(G3322+G2323+G2233+G3232)+e24_m*(G2423+G3422));
S(4,4)=S2323;


S2313=(1/(8*pi))*(C55_m*(G2313+G3312+G2133+G3132)+e15_m*(G2413+G3412));
S(4,5)=S2313;

S2312=(1/(8*pi))*(C66_m*(G2213+G3212+G2123+G3122));
S(4,6)=S2312;


S2341=(1/(8*pi))*(e15_m*(G2313+G3312+G2133+G3132)-k11_m*(G2133+G3132));
S(4,7)=S2341;


S2342=(1/(8*pi))*(e24_m*(G2323+G3322+G2233+G3232)-k22_m*(G2423+G3422));
S(4,8)=S2342;


S2343=(1/(8*pi))*(e31_m*(G2113+G3112)+e32_m*(G2223+G3222)+e33_m*(G2333+G3332)-k33_m*(G2433+G3432));
S(4,9)=S2343;

%%


S1311=(1/(8*pi))*(C11_m*(G1113+G3111)+C21_m*(G1223+G3221)+C31_m*(G1333+G3331)+e31_m*(G1433+G3431));
S(5,1)=S1311;

S1322=(1/(8*pi))*(C12_m*(G1113+G3111)+C22_m*(G1223+G3221)+C32_m*(G1333+G3331)+e32_m*(G1433+G3431));
S(5,2)=S1322;

S1333=(1/(8*pi))*(C13_m*(G1113+G3111)+C23_m*(G1223+G3221)+C33_m*(G1333+G3331)+e33_m*(G1433+G3431));
S(5,3)=S1333;


S1323=(1/(8*pi))*(C44_m*(G1323+G3221+G1233+G3231)+e24_m*(G1423+G3421));
S(5,4)=S1323;


S1313=(1/(8*pi))*(C55_m*(G1313+G3311+G1133+G3131)+e15_m*(G1413+G3411));
S(5,5)=S1313;


S1312=(1/(8*pi))*(C66_m*(G1213+G3211+G1123+G3121));
S(5,6)=S1312;


S1341=(1/(8*pi))*(e15_m*(G1313+G3311+G1133+G3131)-k11_m*(G1413+G3411));
S(5,7)=S1341;


S1342=(1/(8*pi))*(e24_m*(G1323+G3321+G1233+G3231)-k22_m*(G1423+G3421));
S(5,8)=S1342;

S1343=(1/(8*pi))*(e31_m*(G1113+G3111)+e32_m*(G1223+G3221)+e33_m*(G1333+G3331)-k33_m*(G1433+G3431));
S(5,9)=S1343;
%%

S1211=(1/(8*pi))*(C11_m*(G1112+G2111)+C21_m*(G1222+G2221)+C31_m*(G1332+G2331)+e31_m*(G1432+G2431));
S(6,1)=S1211;

S1222=(1/(8*pi))*(C12_m*(G1112+G2111)+C22_m*(G1222+G2221)+C32_m*(G1332+G2331)+e32_m*(G1432+G2431));
S(6,2)=S1222;

S1233=(1/(8*pi))*(C13_m*(G1112+G2111)+C23_m*(G1222+G2221)+C33_m*(G1332+G2331)+e33_m*(G1432+G2431));
S(6,3)=S1233;


S1223=(1/(8*pi))*(C44_m*(G1322+G2321+G1232+G2231)+e24_m*(G1422+G2421));
S(6,4)=S1223;

S1213=(1/(8*pi))*(C55_m*(G1312+G2312+G1132+G2331)+e15_m*(G1412+G2412));
S(6,5)=S1213;

S1212=(1/(8*pi))*(C66_m*(G1212+G2211+G1122+G2121));
S(6,6)=S1212;


S1241=(1/(8*pi))*(e15_m*(G1312+G2311+G1132+G2131)-k11_m*(G1413+G2411));
S(6,7)=S1241;

S1242=(1/(8*pi))*(e24_m*(G1322+G2321+G1232+G2231)-k22_m*(G1422+G2421));
S(6,8)=S1242;

S1243=(1/(8*pi))*(e31_m*(G1112+G2111)+e32_m*(G1222+G2221)+e33_m*(G1332+G2331)-k33_m*(G1432+G2431));
S(6,9)=S1243;

%%

S4111=(1/(4*pi))*(C11_m*G4111+C21_m*G4221+C31_m*G4331+e31_m*G4431)
S(7,1)=S4111;

S4122=(1/(4*pi))*(C12_m*G4111+C22_m*G4221+C32_m*G4331+e32_m*G4431)
S(7,2)=S4122;

S4133=(1/(4*pi))*(C13_m*G4111+C23_m*G4221+C33_m*G4331+e33_m*G4431)
S(7,3)=S4133;


S4123=(1/(4*pi))*(C44_m*(G4321+G4231)+e24_m*G4421)
S(7,4)=S4123;


S4113=(1/(4*pi))*(C55_m*(G4311+G4131)+e15_m*G4411);
S(7,5)=S4113;

G4121=0;
S4112=(1/(4*pi))*(C66_m*(G4211+G4121))
S(7,6)=S4112;

G4113=0;
S4141=(1/(4*pi))*(e15_m*(G4311+G4113)-k11_m*G4411);
S(7,7)=S4141;

S4142=(1/(4*pi))*(e24_m*(G4321+G4231)-k22_m*G4421)
S(7,8)=S4142;

S4143=(1/(4*pi))*(e31_m*G4111+e32_m*G4221+e33_m*G4331-k33_m*G4431)
S(7,9)=S4143;

%%

S4211=(1/(4*pi))*(C11_m*G4112+C21_m*G4222+C31_m*G4332+e31_m*G4432)
S(8,1)=S4211;

S4222=(1/(4*pi))*(C12_m*G4112+C22_m*G4222+C32_m*G4332+e32_m*G4432)
S(8,2)=S4222;

S4233=(1/(4*pi))*(C13_m*G4112+C23_m*G4222+C33_m*G4332+e33_m*G4432)
S(8,3)=S4233;



S4223=(1/(4*pi))*(C44_m*(G4322+G4232)+e24_m*G4422);
S(8,4)=S4223;


S4213=(1/(4*pi))*(C55_m*(G4312+G4132)+e15_m*G4412);
S(8,5)=S4213;

G4212=0;
S4212=(1/(4*pi))*(C66_m*(G4212+G4122))
S(8,6)=S4212;

S4241=(1/(4*pi))*(e15_m*(G4312+G4132)-k11_m*G4412);
S(8,7)=S4241;

S4242=(1/(4*pi))*(e24_m*(G4322+G4232)-k22_m*G4422)
S(8,8)=S4242;

S4243=(1/(4*pi))*(e31_m*G4112+e32_m*G4222+e33_m*G4332-k33_m*G4432)
S(8,9)=S4243;
%%


S4311=(1/(4*pi))*(C11_m*G4113+C21_m*G4223+C31_m*G4333+e31_m*G4433);
S(9,1)=S4311;

S4322=(1/(4*pi))*(C12_m*G4113+C22_m*G4223+C32_m*G4333+e32_m*G4433);
S(9,2)=S4322;

S4333=(1/(4*pi))*(C13_m*G4113+C23_m*G4223+C33_m*G4333+e33_m*G4433);
S(9,3)=S4333;


S4323=(1/(4*pi))*(C44_m*(G4323+G4233)+e24_m*G4423);
S(9,4)=S4323;


S4313=(1/(4*pi))*(C55_m*(G4313+G4133)+e15_m*G4413);
S(9,5)=S4313;


S4312=(1/(4*pi))*(C66_m*(G4213+G4123))
S(9,6)=S4312;

S4341=(1/(4*pi))*(e15_m*(G4313+G4133)-k11_m*G4413);
S(9,7)=S4341;

S4342=(1/(4*pi))*(e24_m*(G4323+G4233)-k22_m*G4423)
S(9,8)=S4342;

S4343=(1/(4*pi))*(e31_m*G4113+e32_m*G4223+e33_m*G4333-k33_m*G4433)
S(9,9)=S4343;
%%
fileID = fopen('cylinder_PVDF_PZT_x3_axis.xls','w');
fprintf(fileID,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'vf', 'E1[GPa]', 'E2[GPa]', 'E3[GPa]', 'G23[GPa]', 'G13[GPa]', 'G12[GPa]', 'nu23', 'nu13', 'nu12', 'd31[pC/N]', 'd32[pC/N]', 'd33[pC/N]', 'd15[pC/N]', 'd24[pC/N]', 'k11','k22','k33');
fileid2=fopen('cylinder_PVDF_PZT_x3_axis_extra_properties.xls','w')
fprintf(fileid2,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'vf', 'C11[GPa]', 'C12[GPa]', 'C13[GPa]', 'C22[GPa]', 'C23[GPa]', 'C33[GPa]', 'C44[GPa]', 'C55[GPa]', 'C66[GPa]', 'e31[C/m2]', 'e32[C/m2]', 'e33[C/m2]', 'e15[C/m2]', 'e24[C/m2]', 'k11','k22','k33');

%%
i=1;
for vf=0:0.005:1
 vol_frac(i)=vf;
vm=1-vf;
 I= eye(9);
% A_dil2D = inv(I  + (S*(inv(E_m))*(E_f - E_m)))
% A_MT2D = A_dil2D*(inv((vm*I) + (vf*A_dil2D)))
% E_composite = E_m + (vf*(E_f-E_m)*A_MT2D)
%  E_composite_compliance = inv(E_composite);
A_N=inv(I+S*inv(E_m)*(E_f-E_m));
E_composite(:,:,i)=E_m+vf*(E_f-E_m)*A_N*inv((1-vf)*I+vf*A_N);
 E_composite_compliance(:,:,i) = inv(E_composite(:,:,i));
  

%% calculating the properties of the composite(transversely isotropic)

C11(i)=E_composite(1,1,i);
C12(i)=E_composite(1,2,i);
C13(i)=E_composite(1,3,i);
C21(i)=E_composite(2,1,i);
C22(i)=E_composite(2,2,i);
C23(i)=E_composite(2,3,i);
C31(i)=E_composite(3,1,i);
C32(i)=E_composite(3,2,i);
C33(i)=E_composite(3,3,i);
C44(i)=E_composite(4,4,i);
C55(i)=E_composite(5,5,i);
C66(i)=E_composite(6,6,i);

e15(i)=E_composite(7,5,i);
e24(i)=E_composite(8,4,i);
e31(i)=E_composite(9,1,i);
e32(i)=E_composite(9,2,i);
e33(i)=E_composite(9,3,i);
Cmatrix(:,:,i)  = [C11(i) C12(i) C13(i) 0 0 0;
               C21(i) C22(i) C23(i) 0 0 0;
               C31(i) C32(i) C33(i) 0 0 0;
               0 0 0 C44(i) 0 0;
               0 0 0 0 C55(i) 0;
               0 0 0 0 0 C66(i)];
Smatrix(:,:,i) = inv(Cmatrix(:,:,i));
ematrix(:,:,i) = [0 0 0 0 e15(i) 0;
                  0 0 0 e24(i) 0 0;
                  e31(i) e32(i) e33(i) 0 0 0];
dmatrix(:,:,i) = ematrix(:,:,i)*Smatrix(:,:,i);
E1_composite(i)=(1/(Smatrix(1,1,i)))/(1e9);
E2_composite(i)=(1/(Smatrix(2,2,i)))/(1e9);
E3_composite(i)=(1/(Smatrix(3,3,i)))/(1e9);
% 
G23(i)=(1/(Smatrix(4,4,i)))/(1e9);
G13(i)=(1/(Smatrix(5,5,i)))/(1e9);
G12(i)=(1/(Smatrix(6,6,i)))/(1e9);

nu12(i)=-(E1_composite(i)*Smatrix(1,2,i));
nu13(i)=-(E1_composite(i)*Smatrix(1,3,i));
nu23(i)=-(E2_composite(i)*Smatrix(2,3,i));

k11(i)=-E_composite(7,7,i)/e0;
k22(i)=-E_composite(8,8,i)/e0;
k33(i)=-E_composite(9,9,i)/e0;

d15(i)=dmatrix(1,5,i)/1e-12;
d24(i)=dmatrix(2,4,i)/1e-12;
d31(i)=dmatrix(3,1,i)/1e-12;
d32(i)=dmatrix(3,2,i)/1e-12;
d33(i)=dmatrix(3,3,i)/1e-12;

fprintf(fileID,'%f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', vol_frac(i), E1_composite(i), E2_composite(i), E3_composite(i), G23(i), G13(i), G12(i), nu23(i), nu13(i), nu12(i), d31(i), d32(i), d33(i), d15(i), d24(i), k11(i),k22(i),k33(i));
fprintf(fileid2,'%f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', vol_frac(i), C11(i), C12(i), C13(i), C22(i), C23(i), C33(i), C44(i), C55(i), C66(i), e31(i), e32(i), e33(i), e15(i), e24(i), k11(i),k22(i),k33(i));

i=i+1;



end
figure(1)
plot(vol_frac,E1_composite,'r')
hold on
plot(vol_frac,E2_composite,'g')
hold on
plot(vol_frac,E3_composite,'b')
legend('E1','E2','E3','Location','northwest')
xlabel('Volume Fraction of PZT')
ylabel('Youngs Moduli in GPa')


figure(2)
plot(vol_frac,d15,'b')
hold on
plot(vol_frac,d24,'r')
legend('d15','d24','Location','northwest')
xlabel('Volume Fraction of PZT')
ylabel('Piezoelectric Strain Constants in pC/N')


figure(3)
plot(vol_frac,d31,'r')
hold on
plot(vol_frac,d32,'g')
hold on
plot(vol_frac,d33,'b')
legend('d31','d32','d33','Location','northwest')
xlabel('Volume Fraction of PZT')
ylabel('Piezoelectric Strain Constants in pC/N')


figure(4)
plot(vol_frac,G23,'r')
hold on
plot(vol_frac,G12,'g')
hold on
plot(vol_frac,G13,'b')
legend('G23','G12','G13','Location','northwest')
xlabel('Volume Fraction of PZT')
ylabel('Shear moduli in GPa')


figure(5)
plot(vol_frac,nu23,'r')
hold on
plot(vol_frac,nu12,'g')
hold on
plot(vol_frac,nu13,'b')
legend('nu23','nu12','nu13','Location','southwest')
xlabel('Volume Fraction of PZT')
ylabel('Poissons ratio')

figure(6)
plot(vol_frac,k11,'r')
hold on
plot(vol_frac,k22,'g')
hold on
plot(vol_frac,k33,'b')
legend('k11','k22','k33','Location','northwest')
xlabel('Volume Fraction of PZT')
ylabel('Dielectric Constants')

figure(7)
plot(vol_frac,e31,'r')
hold on
plot(vol_frac,e32,'g')
hold on
plot(vol_frac,e33,'b')
legend('e31','e32','e33','Location','northwest')
xlabel('Volume Fraction of PZT')
ylabel('Piezoelectric Constants')
