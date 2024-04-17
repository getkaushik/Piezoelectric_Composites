%% calculating the effective electroelastic properties of PVDF/PZT composite using 
%Eshelby-Mori-Tanaka method. Reference for properties of PVDF and PZT is 
% Constitutive modelling of piezoeectric polymer composites by Odegard
%and reference for eshelby tensor is calculated by neelam mishra
%general cylinder problem when the axis of orientation is about the x1
%axis
%this code is written by neelam mishra
clc
clear all
%format long
alpha=1;% aspect ratio a3=a,a3/a1=beta,a3/a1=alpha
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

%% zeroes
I1111=0;
I1112=0;I1121=I1112;
I1113=0;I1131=I1113;
I1114=0;I1141=I1114;
I1122=0;
I1123=0;I1132=I1123;
I1124=0;I1142=I1124;
I1133=0;
I1134=0;I1143=I1134;
I1144=0;

I1211=0;I2111=I1211;
I1212=0;I1221=I1212;I2112=I1212;I2121=I1212;
I1213=0;I1231=I1213;I2113=I1213;I2131=I1213;
I1214=0;I1241=I1214;I2114=I1214;I2141=I1214;
I1222=0;I2122=I1222;
I1223=0;I1232=I1223;I2123=I1223;I2132=I1223;
I1224=0;I1242=I1224;I2124=I1224;I2142=I1224;
I1233=0;I2133=I1233;
I1234=0;I1243=I1234;I2134=I1234;I2143=I1234;
I1244=0;I2144=I1234;

I1311=0;I3111=I1311;
I1312=0;I1321=I1312;I3112=I1312;I3121=I1312;
I1313=0;I1331=I1313;I3113=I1313;I3131=I1313;
I1314=0;I1341=I1314;I3114=I1314;I3141=I1314;
I1322=0;I3122=I1322;
I1323=0;I1332=I1323;I3123=I1323;I3132=I1323;
I1324=0;I1342=I1324;I3124=I1324;I3142=I1324;
I1333=0;I3133=I1333;
I1334=0;I1343=I1334;I3134=I1334;I3143=I1334;
I1344=0;I3144=I1344;












%%  I1111
 syms theta phi y1 y2 y3
 y1=cos(theta);
 y2=sin(theta).*cos(phi);
 y3=sin(theta).*sin(phi);
 
 aa_11=(C23_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^2 - C22_m.*alpha.^6.*e24_m.^2.*y2.^6 - C33_m.*C44_m.*k33_m.*y3.^6 - C44_m.*e33_m.^2.*y3.^6 - C22_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^4 - C33_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^4 + C32_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^2 - C33_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^4 - C44_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^2 - C22_m.*C44_m.*alpha.^6.*k22_m.*y2.^6 - C22_m.*C33_m.*alpha.^4.*k22_m.*y2.^4.*y3.^2 + C23_m.*C32_m.*alpha.^4.*k22_m.*y2.^4.*y3.^2 - C22_m.*C33_m.*alpha.^2.*k33_m.*y2.^2.*y3.^4 + C23_m.*C32_m.*alpha.^2.*k33_m.*y2.^2.*y3.^4 + C23_m.*C44_m.*alpha.^4.*k22_m.*y2.^4.*y3.^2 - C33_m.*C44_m.*alpha.^2.*k22_m.*y2.^2.*y3.^4 + C23_m.*C44_m.*alpha.^2.*k33_m.*y2.^2.*y3.^4 + C32_m.*C44_m.*alpha.^4.*k22_m.*y2.^4.*y3.^2 - C22_m.*C44_m.*alpha.^4.*k33_m.*y2.^4.*y3.^2 + C32_m.*C44_m.*alpha.^2.*k33_m.*y2.^2.*y3.^4 + C23_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^4 - 2.*C22_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^2 + C23_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^2 + C23_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^4 + C32_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^4 - 2.*C33_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^4 + C32_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^2 + C32_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^4 + 2.*C44_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^4)./(C23_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 - C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 - C33_m.*C44_m.*C55_m.*k33_m.*y3.^8 - C44_m.*C55_m.*e33_m.^2.*y3.^8 - C22_m.*C55_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C22_m.*C55_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C33_m.*C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^6 - C22_m.*C66_m.*alpha.^4.*e33_m.^2.*y2.^4.*y3.^4 - C33_m.*C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C55_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C44_m.*C66_m.*alpha.^6.*e32_m.^2.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 - C22_m.*C33_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C32_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C55_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C23_m.*C32_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 - C22_m.*C44_m.*C55_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C32_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 - C33_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C32_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^6.*k33_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C22_m.*C55_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C33_m.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C22_m.*C66_m.*alpha.^6.*e24_m.*e33_m.*y2.^6.*y3.^2 + C23_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + C32_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C23_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C33_m.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + 2.*C44_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + 2.*C44_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4);
 
i2211=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_11),'vars',[theta,phi])
I2211=integral2(i2211,0,pi,0,2.*pi)

i2311=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_11),'vars',[theta,phi])
I2311=integral2(i2311,0,pi,0,2.*pi)
I3211=I2311

i3311=matlabFunction((sin(theta).*((y3).^2).*aa_11),'vars',[theta,phi])
I3311=integral2(i3311,0,pi,0,2.*pi)




%%
aa_22=-(C55_m.*e33_m.^2.*y3.^6 + C66_m.*alpha.^6.*e24_m.^2.*y2.^6 + C33_m.*C55_m.*k33_m.*y3.^6 + C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^2 + C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^4 + C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6 + C33_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^4 + C33_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^2 + C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^2 + C33_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^4 + C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^4 + C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^2 + 2.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^4 + 2.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^2)./(C23_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 - C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 - C33_m.*C44_m.*C55_m.*k33_m.*y3.^8 - C44_m.*C55_m.*e33_m.^2.*y3.^8 - C22_m.*C55_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C22_m.*C55_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C33_m.*C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^6 - C22_m.*C66_m.*alpha.^4.*e33_m.^2.*y2.^4.*y3.^4 - C33_m.*C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C55_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C44_m.*C66_m.*alpha.^6.*e32_m.^2.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 - C22_m.*C33_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C32_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C55_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C23_m.*C32_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 - C22_m.*C44_m.*C55_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C32_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 - C33_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C32_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^6.*k33_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C22_m.*C55_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C33_m.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C22_m.*C66_m.*alpha.^6.*e24_m.*e33_m.*y2.^6.*y3.^2 + C23_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + C32_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C23_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C33_m.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + 2.*C44_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + 2.*C44_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4);

i2222=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_22),'vars',[theta,phi])
I2222=integral2(i2222,0,pi,0,2.*pi)

i2322=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_22),'vars',[theta,phi])
I2322=integral2(i2322,0,pi,0,2.*pi)
I3222=I2322

i3322=matlabFunction((sin(theta).*((y3).^2).*aa_22),'vars',[theta,phi])
I3322=integral2(i3322,0,pi,0,2.*pi)
 
%%
aa_23=(C66_m.*alpha.^5.*e24_m.^2.*y2.^5.*y3 + C55_m.*alpha.^3.*e24_m.^2.*y2.^3.*y3.^3 + C23_m.*C55_m.*alpha.*k33_m.*y2.*y3.^5 + C44_m.*C55_m.*alpha.*k33_m.*y2.*y3.^5 + C55_m.*alpha.*e24_m.*e33_m.*y2.*y3.^5 + C55_m.*alpha.*e32_m.*e33_m.*y2.*y3.^5 + C23_m.*C66_m.*alpha.^5.*k22_m.*y2.^5.*y3 + C44_m.*C66_m.*alpha.^5.*k22_m.*y2.^5.*y3 + C66_m.*alpha.^5.*e24_m.*e32_m.*y2.^5.*y3 + C23_m.*C55_m.*alpha.^3.*k22_m.*y2.^3.*y3.^3 + C44_m.*C55_m.*alpha.^3.*k22_m.*y2.^3.*y3.^3 + C23_m.*C66_m.*alpha.^3.*k33_m.*y2.^3.*y3.^3 + C44_m.*C66_m.*alpha.^3.*k33_m.*y2.^3.*y3.^3 + C55_m.*alpha.^3.*e24_m.*e32_m.*y2.^3.*y3.^3 + C66_m.*alpha.^3.*e24_m.*e33_m.*y2.^3.*y3.^3 + C66_m.*alpha.^3.*e32_m.*e33_m.*y2.^3.*y3.^3)./(C23_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 - C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 - C33_m.*C44_m.*C55_m.*k33_m.*y3.^8 - C44_m.*C55_m.*e33_m.^2.*y3.^8 - C22_m.*C55_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C22_m.*C55_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C33_m.*C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^6 - C22_m.*C66_m.*alpha.^4.*e33_m.^2.*y2.^4.*y3.^4 - C33_m.*C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C55_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C44_m.*C66_m.*alpha.^6.*e32_m.^2.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 - C22_m.*C33_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C32_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C55_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C23_m.*C32_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 - C22_m.*C44_m.*C55_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C32_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 - C33_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C32_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^6.*k33_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C22_m.*C55_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C33_m.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C22_m.*C66_m.*alpha.^6.*e24_m.*e33_m.*y2.^6.*y3.^2 + C23_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + C32_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C23_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C33_m.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + 2.*C44_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + 2.*C44_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4);
 
i2223=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_23),'vars',[theta,phi])
I2223=integral2(i2223,0,pi,0,2.*pi)
I2232=I2223

i2323=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_23),'vars',[theta,phi])
I2323=integral2(i2323,0,pi,0,2.*pi)
I2332=I2323;I3223=I2323;I3232=I2323


i3323=matlabFunction((sin(theta).*((y3).^2).*aa_23),'vars',[theta,phi])
I3323=integral2(i3323,0,pi,0,2.*pi)
I3332=I3323

%%
aa_24=(C23_m.*C66_m.*alpha.^5.*e24_m.*y2.^5.*y3 - C44_m.*C66_m.*alpha.^5.*e32_m.*y2.^5.*y3 + C23_m.*C55_m.*alpha.^3.*e24_m.*y2.^3.*y3.^3 + C23_m.*C66_m.*alpha.^3.*e33_m.*y2.^3.*y3.^3 - C33_m.*C66_m.*alpha.^3.*e24_m.*y2.^3.*y3.^3 - C33_m.*C66_m.*alpha.^3.*e32_m.*y2.^3.*y3.^3 - C44_m.*C55_m.*alpha.^3.*e32_m.*y2.^3.*y3.^3 + C44_m.*C66_m.*alpha.^3.*e33_m.*y2.^3.*y3.^3 + C23_m.*C55_m.*alpha.*e33_m.*y2.*y3.^5 - C33_m.*C55_m.*alpha.*e24_m.*y2.*y3.^5 - C33_m.*C55_m.*alpha.*e32_m.*y2.*y3.^5 + C44_m.*C55_m.*alpha.*e33_m.*y2.*y3.^5)./(C23_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 - C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 - C33_m.*C44_m.*C55_m.*k33_m.*y3.^8 - C44_m.*C55_m.*e33_m.^2.*y3.^8 - C22_m.*C55_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C22_m.*C55_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C33_m.*C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^6 - C22_m.*C66_m.*alpha.^4.*e33_m.^2.*y2.^4.*y3.^4 - C33_m.*C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C55_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C44_m.*C66_m.*alpha.^6.*e32_m.^2.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 - C22_m.*C33_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C32_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C55_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C23_m.*C32_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 - C22_m.*C44_m.*C55_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C32_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 - C33_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C32_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^6.*k33_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C22_m.*C55_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C33_m.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C22_m.*C66_m.*alpha.^6.*e24_m.*e33_m.*y2.^6.*y3.^2 + C23_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + C32_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C23_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C33_m.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + 2.*C44_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + 2.*C44_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4);

i2224=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_24),'vars',[theta,phi])
I2224=integral2(i2224,0,pi,0,2.*pi)
I2242=I2224


i2324=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_24),'vars',[theta,phi])
I2324=integral2(i2324,0,pi,0,2.*pi)
I2342=I2324;I3224=I2324;I3242=I2324


i3324=matlabFunction((sin(theta).*((y3).^2).*aa_24),'vars',[theta,phi])
I3324=integral2(i3324,0,pi,0,2.*pi)
I3342=I3324 

%%
aa_33=-(C44_m.*C55_m.*k33_m.*y3.^6 + C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^4 + C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^4 + C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^2 + C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^2 + C22_m.*C66_m.*alpha.^6.*k22_m.*y2.^6 + C22_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^2 + C22_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^4 + C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^4 + C22_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^2 + C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^2 + C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^4 + 2.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^4 + 2.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^2)./(C23_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 - C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 - C33_m.*C44_m.*C55_m.*k33_m.*y3.^8 - C44_m.*C55_m.*e33_m.^2.*y3.^8 - C22_m.*C55_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C22_m.*C55_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C33_m.*C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^6 - C22_m.*C66_m.*alpha.^4.*e33_m.^2.*y2.^4.*y3.^4 - C33_m.*C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C55_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C44_m.*C66_m.*alpha.^6.*e32_m.^2.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 - C22_m.*C33_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C32_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C55_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C23_m.*C32_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 - C22_m.*C44_m.*C55_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C32_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 - C33_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C32_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^6.*k33_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C22_m.*C55_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C33_m.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C22_m.*C66_m.*alpha.^6.*e24_m.*e33_m.*y2.^6.*y3.^2 + C23_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + C32_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C23_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C33_m.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + 2.*C44_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + 2.*C44_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4);

i2233=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_33),'vars',[theta,phi])
I2233=integral2(i2233,0,pi,0,2.*pi)

i2333=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_33),'vars',[theta,phi])
I2333=integral2(i2333,0,pi,0,2.*pi)
I3233=I2333


i3333=matlabFunction((sin(theta).*((y3).^2).*aa_33),'vars',[theta,phi])
I3333=integral2(i3333,0,pi,0,2.*pi)


%%
aa_34=-(C44_m.*C55_m.*e33_m.*y3.^6 + C22_m.*C66_m.*alpha.^6.*e24_m.*y2.^6 + C22_m.*C55_m.*alpha.^4.*e24_m.*y2.^4.*y3.^2 + C22_m.*C55_m.*alpha.^2.*e33_m.*y2.^2.*y3.^4 - C32_m.*C55_m.*alpha.^2.*e24_m.*y2.^2.*y3.^4 - C32_m.*C55_m.*alpha.^2.*e32_m.*y2.^2.*y3.^4 + C22_m.*C66_m.*alpha.^4.*e33_m.*y2.^4.*y3.^2 - C32_m.*C66_m.*alpha.^4.*e24_m.*y2.^4.*y3.^2 - C44_m.*C55_m.*alpha.^2.*e32_m.*y2.^2.*y3.^4 - C32_m.*C66_m.*alpha.^4.*e32_m.*y2.^4.*y3.^2 + C44_m.*C66_m.*alpha.^2.*e33_m.*y2.^2.*y3.^4 - C44_m.*C66_m.*alpha.^4.*e32_m.*y2.^4.*y3.^2)./(C23_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 - C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 - C33_m.*C44_m.*C55_m.*k33_m.*y3.^8 - C44_m.*C55_m.*e33_m.^2.*y3.^8 - C22_m.*C55_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C22_m.*C55_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C33_m.*C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^6 - C22_m.*C66_m.*alpha.^4.*e33_m.^2.*y2.^4.*y3.^4 - C33_m.*C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C55_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C44_m.*C66_m.*alpha.^6.*e32_m.^2.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 - C22_m.*C33_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C32_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C55_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C23_m.*C32_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 - C22_m.*C44_m.*C55_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C32_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 - C33_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C32_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^6.*k33_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C22_m.*C55_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C33_m.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C22_m.*C66_m.*alpha.^6.*e24_m.*e33_m.*y2.^6.*y3.^2 + C23_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + C32_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C23_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C33_m.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + 2.*C44_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + 2.*C44_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4);

i2234=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_34),'vars',[theta,phi])
I2234=integral2(i2234,0,pi,0,2.*pi)
I2243=I2234


i2334=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_34),'vars',[theta,phi])
I2334=integral2(i2334,0,pi,0,2.*pi)
I2343=I2334;I3234=I2334;I3243=I2334


i3334=matlabFunction((sin(theta).*((y3).^2).*aa_34),'vars',[theta,phi])
I3334=integral2(i3334,0,pi,0,2.*pi)
I3343=I3334

%%

aa_44=(C33_m.*C44_m.*C55_m.*y3.^6 + C22_m.*C44_m.*C66_m.*alpha.^6.*y2.^6 + C22_m.*C33_m.*C55_m.*alpha.^2.*y2.^2.*y3.^4 - C23_m.*C32_m.*C55_m.*alpha.^2.*y2.^2.*y3.^4 - C23_m.*C44_m.*C55_m.*alpha.^2.*y2.^2.*y3.^4 + C22_m.*C33_m.*C66_m.*alpha.^4.*y2.^4.*y3.^2 + C22_m.*C44_m.*C55_m.*alpha.^4.*y2.^4.*y3.^2 - C23_m.*C32_m.*C66_m.*alpha.^4.*y2.^4.*y3.^2 - C32_m.*C44_m.*C55_m.*alpha.^2.*y2.^2.*y3.^4 - C23_m.*C44_m.*C66_m.*alpha.^4.*y2.^4.*y3.^2 + C33_m.*C44_m.*C66_m.*alpha.^2.*y2.^2.*y3.^4 - C32_m.*C44_m.*C66_m.*alpha.^4.*y2.^4.*y3.^2)./(C23_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 - C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 - C33_m.*C44_m.*C55_m.*k33_m.*y3.^8 - C44_m.*C55_m.*e33_m.^2.*y3.^8 - C22_m.*C55_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C22_m.*C55_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C33_m.*C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^6 - C22_m.*C66_m.*alpha.^4.*e33_m.^2.*y2.^4.*y3.^4 - C33_m.*C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C55_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C44_m.*C66_m.*alpha.^6.*e32_m.^2.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 - C22_m.*C33_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C32_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C55_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C23_m.*C32_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 - C22_m.*C44_m.*C55_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C32_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 - C33_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C32_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^6.*k33_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C22_m.*C55_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C33_m.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C22_m.*C66_m.*alpha.^6.*e24_m.*e33_m.*y2.^6.*y3.^2 + C23_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + C32_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C23_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C33_m.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + 2.*C44_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + 2.*C44_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4);

i2244=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_44),'vars',[theta,phi])
I2244=integral2(i2244,0,pi,0,2.*pi)

i2344=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_44),'vars',[theta,phi])
I2344=integral2(i2344,0,pi,0,2.*pi)
I3244=I2344


i3344=matlabFunction((sin(theta).*((y3).^2).*aa_44),'vars',[theta,phi])
I3344=integral2(i3344,0,pi,0,2.*pi)

 %% the eshelby tensors

S=zeros(9);
%
S1111=(1/(4*pi))*(C11_m*I1111+C21_m*I2112+C13_m*I3113+e31_m*I3114)
S(1,1)=S1111;

S1122=(1/(4*pi))*(C12_m*I1111+C22_m*I2112+C32_m*I3113+e32_m*I3114)
S(1,2)=S1122;


S1133=(1/(4*pi))*(C13_m*I1111+C23_m*I2112+C33_m*I3113+e33_m*I3114)
S(1,3)=S1133;

S1143=(1/(4*pi))*(e31_m*I1111+e32_m*I2112+e33_m*I3113-k33_m*I3114)
S(1,9)=S1143;


%
S2211=(1/(4*pi))*(C11_m*I1221+C21_m*I2222+C31_m*I3223+e31_m*I3224)
S(2,1)=S2211;

S2222=(1/(4*pi))*(C12_m*I1221+C22_m*I2222+C32_m*I3223+e32_m*I3224)
S(2,2)=S2222;

S2233=(1/(4*pi))*(C13_m*I1221+C23_m*I2222+C33_m*I3223+e33_m*I3224)
S(2,3)=S2211;

S2243=(1/(4*pi))*(e31_m*I1221+e32_m*I2222+e33_m*I3223-k33_m*I3224)
S(2,9)=S2243;

%
S3311=(1/(4*pi))*(C11_m*I1331+C21_m*I2332+C31_m*I3333+e31_m*I3334)
S(3,1)=S3311;

S3322=(1/(4*pi))*(C12_m*I1331+C22_m*I2332+C32_m*I3333+e32_m*I3334)
S(3,2)=S3322;


S3333=(1/(4*pi))*(C13_m*I1331+C23_m*I2332+C33_m*I3333+e33_m*I3334)
S(3,3)=S3333;


S3343=(1/(4*pi))*(e31_m*I1331+e32_m*I2332+e33_m*I3333-k33_m*I3334)
S(3,9)=S3343;



%
S2323=(1/(8*pi))*(C44_m*(I2233+I2323+I3232+I2322)+e24_m*(I2234+I2324))
S(4,4)=S2323;

S2342=(1/(8*pi))*(e24_m*(I2233+I2323+I3232+I2322)-k22_m*(I2234+I2324))
S(4,8)=S2342;

%
S1313=(1/(8*pi))*(C55_m*(I1133+I1313+I3131+I3311)+e15_m*(I1134+I1314))
S(5,5)=S1313;

S1341=(1/(8*pi))*(e15_m*(I1133+I1313+I3131+I3311)-k11_m*(I1134+I1314))
S(5,7)=S1341;

%
S1212=(1/(8*pi))*(C66_m*(I1122+I1212+I2121+I2211))
S(6,6)=S1212;


%
S4113=(1/(4*pi))*(C55_m*(I1143+I3141)+e15_m*I1144)
S(7,5)=S4113;

S4141=(1/(4*pi))*(e15_m*(I1143+I3141)-k11_m*I1144)
S(7,7)=S4141;

%
S4223=(1/(4*pi))*(C44_m*(I2243+I3242)+e24_m*I2244)
S(8,4)=S4223;

S4242=(1/(4*pi))*(e24_m*(I2243+I3242)-k22_m*I2244)
S(8,8)=S4242;

%

S4311= (1/(4*pi))*(C11_m*I1341+C21_m*I2342+C31_m*I3343+e31_m*I3344)
S(9,1)=S4311;

S4322=(1/(4*pi))*(C12_m*I1341+C22_m*I2342+C32_m*I3343+e32_m*I3344)
S(9,2)=S4322;

S4333=(1/(4*pi))*(C13_m*I1341+C23_m*I2342+C33_m*I3343+e33_m*I3344)
S(9,3)=S4333;

S4343=(1/(4*pi))*(e31_m*I1341+e32_m*I2342+e33_m*I3343-k33_m*I3344)
S(9,9)=S4343;
 

%%
fileID = fopen('cylinder_pvdf_pzt7A_x1_axis.xls','w');
fprintf(fileID,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'vf', 'E1[GPa]', 'E2[GPa]', 'E3[GPa]', 'G23[GPa]', 'G13[GPa]', 'G12[GPa]', 'nu23', 'nu13', 'nu12', 'd31[C/GN]', 'd32[pC/N]', 'd33[pC/N]', 'd15[pC/N]', 'd24[C/GN]', 'k11','k22','k33');
fileid2=fopen('cylinder_PVDF_PZT_x1_axis_extra_properties.xls','w');
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
E1_composite(i)=(1/(Smatrix(1,1,i)))/1e9;
E2_composite(i)=(1/(Smatrix(2,2,i)))/1e9;
E3_composite(i)=(1/(Smatrix(3,3,i)))/1e9;
% 
G23(i)=(1/(Smatrix(4,4,i)))/1e9;
G13(i)=(1/(Smatrix(5,5,i)))/1e9;
G12(i)=(1/(Smatrix(6,6,i)))/1e9;

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
legend('nu12','nu13','Location','southwest')
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
ylabel('Electromechanical coupling factor ')

