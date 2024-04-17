%% calculating theeffective electroelastic properties of PVDF/PZT composite using 
%Eshelby-Mori-Tanaka method. Reference for properties of PVDF and PZT is 
% Constitutive modelling of piezoeectric polymer composites by Odegard
%and  eshelby tensor is calculated by neelam mishra
%general ellipsoid problem when the axis of orientation is about the x1
%axis
%this code is written by neelam mishra
clc
clear all
format long
alpha=5;% aspect ratio a3=a,a3/a1=beta,a3/a1=alpha
%% Material properties of PVDF (matrix)
e0 = 8.85418782e-12; % Permittivity of free space, Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
C11_m=4.84e9;% units in GPa,Component of stiffness matrix
C12_m=2.72e9;% units in GPa,Component of stiffness matrix
C13_m=2.22e9;% units in GPa,Component of stiffness matrix
C31_m=C13_m;
C21_m=C12_m;
C22_m=4.84e9;% units in GPa,Component of stiffness matrix
C23_m=2.22e9;% units in GPa,Component of stiffness matrix
C32_m=C23_m;
C33_m=4.63e9;% units in GPa,Component of stiffness matrix
C44_m=5.26e7;% units in GPa,Component of stiffness matrix
C55_m=5.26e7;% unitss in GPa,Component of stiffness matrix
C66_m=1.060e9;% units in GPa,Component of stiffness matrix
k11_m=6.641e-11;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k22_m=6.641e-11;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k33_m=7.983e-11;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
e15_m=-1.999e-3;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_m=-1.999e-3;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_m=4.344e-3;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_m=4.344e-3;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_m=-1.099e-1;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
E_m=     [C11_m,C12_m, C13_m, 0, 0, 0, 0, 0, e31_m;
         C12_m,C22_m, C23_m, 0, 0, 0, 0, 0, e32_m;
         C13_m,C23_m, C33_m, 0, 0, 0, 0, 0, e33_m;
         0, 0, 0, C44_m, 0, 0, 0, e24_m, 0;
         0, 0, 0, 0, C55_m, 0, e15_m, 0, 0;
         0, 0, 0, 0, 0, C66_m, 0, 0, 0;
         0, 0, 0, 0, e15_m, 0, -k11_m, 0, 0;
         0, 0, 0, e24_m, 0, 0, 0, -k22_m, 0;
         e31_m, e32_m, e33_m, 0, 0, 0, 0, 0,-k33_m];
     E_m;
 %  Material Properties of BaTiO3 (reinforcement)
 C11_f=150.4e9;% units in GPa,Component of stiffness matrix
C12_f=65.63e9;% units in GPa,Component of stiffness matrix
C13_f=65.94e9;% units in GPa,Component of stiffness matrix
C22_f=150.4e9;% units in GPa,Component of stiffness matrix
C23_f=65.94e9;% units in GPa,Component of stiffness matrix
C33_f=145.5e9;% units in GPa,Component of stiffness matrix
C44_f=43.86e9;% units in GPa,Component of stiffness matrix
C55_f=43.86e9;% unitss in GPa,Component of stiffness matrix
C66_f=42.37e9;% units in GPa,Component of stiffness matrix
k11_f=1.280e-8;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k22_f=1.280e-8;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k33_f=1.510e-8;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
e15_f=11.40;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_f=11.40;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_f=-4.322;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_f=-4.322;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_f=17.36;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
E_f=     [C11_f,C12_f, C13_f, 0, 0, 0, 0, 0, e31_f;
         C12_f,C22_f, C23_f, 0, 0, 0, 0, 0, e32_f;
         C13_f,C23_f, C33_f, 0, 0, 0, 0, 0, e33_f;
         0, 0, 0, C44_f, 0, 0, 0, e24_f, 0;
         0, 0, 0, 0, C55_f, 0, e15_f, 0, 0;
         0, 0, 0, 0, 0, C66_f, 0, 0, 0;
         0, 0, 0, 0, e15_f, 0, -k11_f, 0, 0;
         0, 0, 0, e24_f, 0, 0, 0, -k22_f, 0;
         e31_f, e32_f, e33_f, 0, 0, 0, 0, 0,-k33_f];
     
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

I1111=0;
I1211=0;I2111=I1211;
I1311=0;I3111=I1311;

i2211=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_11),'vars',[theta,phi])
I2211=integral2(i2211,0,pi,0,2.*pi)

i2311=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_11),'vars',[theta,phi])
I2311=integral2(i2311,0,pi,0,2.*pi)
I3211=I2311

i3311=matlabFunction((sin(theta).*((y3).^2).*aa_11),'vars',[theta,phi])
I3311=integral2(i3311,0,pi,0,2.*pi)


I1112=0;I1121=I1112;
I1212=0;I1221=I1212;I2112=I1212;I2121=I1212;
I1312=0;I1321=I1312;I3112=I1312;I3121=I1312;
I2212=0;I2221=I2212;
I2312=0;I2321=I2312;I3212=I2312;I3221=I2312;
I3312=0;I3321=I3312;

I1113=0;I1131=I1113;
I1213=0;I1231=I1213;I2113=I1213;I2131=I1213;
I1313=0;I1331=I1313;I3113=I1313;I3131=I1313;
I2213=0;I2231=I2213;
I2313=0;I2331=I2313;I3213=I2313;I3231=I2313;
I3313=0;I3331=I3313;

I1114=0;I1141=I1114;
I1214=0;I1241=I1214;I2114=I1214;I2141=I1214;
I1314=0;I1341=I1314;I3114=I1314;I3141=I1314;
I2214=0;I2241=I2214;
I2314=0;I2341=I2314;I3214=I2314;I3241=I2314;
I3314=0;I3341=I3314;


%%
aa_22=-(C55_m.*e33_m.^2.*y3.^6 + C66_m.*alpha.^6.*e24_m.^2.*y2.^6 + C33_m.*C55_m.*k33_m.*y3.^6 + C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^2 + C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^4 + C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6 + C33_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^4 + C33_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^2 + C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^2 + C33_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^4 + C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^4 + C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^2 + 2.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^4 + 2.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^2)./(C23_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 - C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 - C33_m.*C44_m.*C55_m.*k33_m.*y3.^8 - C44_m.*C55_m.*e33_m.^2.*y3.^8 - C22_m.*C55_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C22_m.*C55_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C33_m.*C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^6 - C22_m.*C66_m.*alpha.^4.*e33_m.^2.*y2.^4.*y3.^4 - C33_m.*C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C55_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C44_m.*C66_m.*alpha.^6.*e32_m.^2.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 - C22_m.*C33_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C32_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C55_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C23_m.*C32_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 - C22_m.*C44_m.*C55_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C32_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 - C33_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C32_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^6.*k33_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C22_m.*C55_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C33_m.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C22_m.*C66_m.*alpha.^6.*e24_m.*e33_m.*y2.^6.*y3.^2 + C23_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + C32_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C23_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C33_m.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + 2.*C44_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + 2.*C44_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4);

I1122=0;
I1222=0;I2122=I1222;
I1322=0;I3122=I1322;

i2222=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_22),'vars',[theta,phi])
I2222=integral2(i2222,0,pi,0,2.*pi)

i2322=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_22),'vars',[theta,phi])
I2322=integral2(i2322,0,pi,0,2.*pi)
I3222=I2322

i3322=matlabFunction((sin(theta).*((y3).^2).*aa_22),'vars',[theta,phi])
I3322=integral2(i3322,0,pi,0,2.*pi)
 
%%
aa_23=(C66_m.*alpha.^5.*e24_m.^2.*y2.^5.*y3 + C55_m.*alpha.^3.*e24_m.^2.*y2.^3.*y3.^3 + C23_m.*C55_m.*alpha.*k33_m.*y2.*y3.^5 + C44_m.*C55_m.*alpha.*k33_m.*y2.*y3.^5 + C55_m.*alpha.*e24_m.*e33_m.*y2.*y3.^5 + C55_m.*alpha.*e32_m.*e33_m.*y2.*y3.^5 + C23_m.*C66_m.*alpha.^5.*k22_m.*y2.^5.*y3 + C44_m.*C66_m.*alpha.^5.*k22_m.*y2.^5.*y3 + C66_m.*alpha.^5.*e24_m.*e32_m.*y2.^5.*y3 + C23_m.*C55_m.*alpha.^3.*k22_m.*y2.^3.*y3.^3 + C44_m.*C55_m.*alpha.^3.*k22_m.*y2.^3.*y3.^3 + C23_m.*C66_m.*alpha.^3.*k33_m.*y2.^3.*y3.^3 + C44_m.*C66_m.*alpha.^3.*k33_m.*y2.^3.*y3.^3 + C55_m.*alpha.^3.*e24_m.*e32_m.*y2.^3.*y3.^3 + C66_m.*alpha.^3.*e24_m.*e33_m.*y2.^3.*y3.^3 + C66_m.*alpha.^3.*e32_m.*e33_m.*y2.^3.*y3.^3)./(C23_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 - C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 - C33_m.*C44_m.*C55_m.*k33_m.*y3.^8 - C44_m.*C55_m.*e33_m.^2.*y3.^8 - C22_m.*C55_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C22_m.*C55_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C33_m.*C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^6 - C22_m.*C66_m.*alpha.^4.*e33_m.^2.*y2.^4.*y3.^4 - C33_m.*C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C55_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C44_m.*C66_m.*alpha.^6.*e32_m.^2.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 - C22_m.*C33_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C32_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C55_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C23_m.*C32_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 - C22_m.*C44_m.*C55_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C32_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 - C33_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C32_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^6.*k33_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C22_m.*C55_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C33_m.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C22_m.*C66_m.*alpha.^6.*e24_m.*e33_m.*y2.^6.*y3.^2 + C23_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + C32_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C23_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C33_m.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + 2.*C44_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + 2.*C44_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4);

I1123=0;I1132=I1123;
I1223=0;I1232=I1223;I2123=I1223;I2132=I1223;
I1323=0;I1332=I1323;I3123=I1323;I3132=I1323;


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

I1124=0;I1142=I1124;
I1224=0;I1242=I1224;I2124=I1224;I2142=I1224;
I1324=0;I1342=I1324;I3124=I1324;I3142=I1324;

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

I1133=0;
I1233=0;I2133=I1233;
I1333=0;I3133=I1333;

i2233=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_33),'vars',[theta,phi])
I2233=integral2(i2233,0,pi,0,2.*pi)

i2333=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_33),'vars',[theta,phi])
I2333=integral2(i2333,0,pi,0,2.*pi)
I3233=I2333


i3333=matlabFunction((sin(theta).*((y3).^2).*aa_33),'vars',[theta,phi])
I3333=integral2(i3333,0,pi,0,2.*pi)


%%
aa_34=-(C44_m.*C55_m.*e33_m.*y3.^6 + C22_m.*C66_m.*alpha.^6.*e24_m.*y2.^6 + C22_m.*C55_m.*alpha.^4.*e24_m.*y2.^4.*y3.^2 + C22_m.*C55_m.*alpha.^2.*e33_m.*y2.^2.*y3.^4 - C32_m.*C55_m.*alpha.^2.*e24_m.*y2.^2.*y3.^4 - C32_m.*C55_m.*alpha.^2.*e32_m.*y2.^2.*y3.^4 + C22_m.*C66_m.*alpha.^4.*e33_m.*y2.^4.*y3.^2 - C32_m.*C66_m.*alpha.^4.*e24_m.*y2.^4.*y3.^2 - C44_m.*C55_m.*alpha.^2.*e32_m.*y2.^2.*y3.^4 - C32_m.*C66_m.*alpha.^4.*e32_m.*y2.^4.*y3.^2 + C44_m.*C66_m.*alpha.^2.*e33_m.*y2.^2.*y3.^4 - C44_m.*C66_m.*alpha.^4.*e32_m.*y2.^4.*y3.^2)./(C23_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 - C22_m.*C66_m.*alpha.^8.*e24_m.^2.*y2.^8 - C33_m.*C44_m.*C55_m.*k33_m.*y3.^8 - C44_m.*C55_m.*e33_m.^2.*y3.^8 - C22_m.*C55_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C22_m.*C55_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C33_m.*C55_m.*alpha.^2.*e24_m.^2.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C55_m.*alpha.^2.*e32_m.^2.*y2.^2.*y3.^6 - C22_m.*C66_m.*alpha.^4.*e33_m.^2.*y2.^4.*y3.^4 - C33_m.*C66_m.*alpha.^4.*e24_m.^2.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.^2.*y2.^6.*y3.^2 - C33_m.*C66_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C55_m.*alpha.^4.*e32_m.^2.*y2.^4.*y3.^4 - C44_m.*C66_m.*alpha.^2.*e33_m.^2.*y2.^2.*y3.^6 - C44_m.*C66_m.*alpha.^6.*e32_m.^2.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^8.*k22_m.*y2.^8 - C22_m.*C33_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C32_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C55_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C23_m.*C32_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C55_m.*alpha.^2.*k22_m.*y2.^2.*y3.^6 + C23_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C55_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 - C22_m.*C33_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 - C22_m.*C44_m.*C55_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C32_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 + C32_m.*C44_m.*C55_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 - C33_m.*C44_m.*C66_m.*alpha.^4.*k22_m.*y2.^4.*y3.^4 + C23_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C32_m.*C44_m.*C66_m.*alpha.^6.*k22_m.*y2.^6.*y3.^2 - C22_m.*C44_m.*C66_m.*alpha.^6.*k33_m.*y2.^6.*y3.^2 - C33_m.*C44_m.*C66_m.*alpha.^2.*k33_m.*y2.^2.*y3.^6 + C32_m.*C44_m.*C66_m.*alpha.^4.*k33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C22_m.*C55_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^2.*e24_m.*e33_m.*y2.^2.*y3.^6 - 2.*C33_m.*C55_m.*alpha.^2.*e24_m.*e32_m.*y2.^2.*y3.^6 + C32_m.*C55_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C23_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C22_m.*C66_m.*alpha.^6.*e24_m.*e33_m.*y2.^6.*y3.^2 + C23_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + C32_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C23_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^4.*e24_m.*e33_m.*y2.^4.*y3.^4 - 2.*C33_m.*C66_m.*alpha.^4.*e24_m.*e32_m.*y2.^4.*y3.^4 + C32_m.*C66_m.*alpha.^6.*e24_m.*e32_m.*y2.^6.*y3.^2 + 2.*C44_m.*C55_m.*alpha.^2.*e32_m.*e33_m.*y2.^2.*y3.^6 + C32_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4 + 2.*C44_m.*C66_m.*alpha.^4.*e32_m.*e33_m.*y2.^4.*y3.^4);

I1134=0;I1143=I1134;
I1234=0;I1243=I1234;I2134=I1234;I2143=I1234;
I1334=0;I1343=I1334;I3134=I1334;I3143=I1334;

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

I1144=0;
I1244=0;I2144=I1244;
I1344=0;I3144=I1344;

i2244=matlabFunction((sin(theta).*((alpha.*y2).^2).*aa_44),'vars',[theta,phi])
I2244=integral2(i2244,0,pi,0,2.*pi)

i2344=matlabFunction((sin(theta).*alpha.*y2.*y3.*aa_44),'vars',[theta,phi])
I2344=integral2(i2344,0,pi,0,2.*pi)
I3244=I2344


i3344=matlabFunction((sin(theta).*((y3).^2).*aa_44),'vars',[theta,phi])
I3344=integral2(i3344,0,pi,0,2.*pi)

 %% the eshelby tensors

S=zeros(9);
%%
S1111=(1/(4*pi))*(C11_m*I1111+C21_m*I2112+C13_m*I3113+e31_m*I3114)
S(1,1)=S1111;

S1122=(1/(4*pi))*(C12_m*I1111+C22_m*I2112+C32_m*I3113+e32_m*I3114)
S(1,2)=S1122;


S1133=(1/(4*pi))*(C13_m*I1111+C23_m*I2112+C33_m*I3113+e33_m*I3114)
S(1,3)=S1133;

% S1123=(1/(4*pi))*(C44_m*(I2113+I3112)+e24_m*I2114)
% S(1,4)=S1123;
% 
% S1113=(1/(4*pi))*(C55_m*(I1113+I3111)+e15_m*I1114)
% S(1,5)=S1113;
% 
% S1112=(1/(4*pi))*(C66_m*(I2111+I1112))
% S(1,6)=S1112;
% 
% S1141=(1/(4*pi))*(e15_m*(I1113+I3111)-k11_m*I1114)
% S(1,7)=S1141;
% 
% S1142=(1/(4*pi))*(e24_m*(I2113+I3112)-k22_m*I2114)
% S(1,8)=S1142;

S1143=(1/(4*pi))*(e31_m*I1111+e32_m*I2112+e33_m*I3113-k33_m*I3114)
S(1,9)=S1143;


%%
S2211=(1/(4*pi))*(C11_m*I1221+C21_m*I2222+C31_m*I3223+e31_m*I3224)
S(2,1)=S2211;

S2222=(1/(4*pi))*(C12_m*I1221+C22_m*I2222+C32_m*I3223+e32_m*I3224)
S(2,2)=S2222;

S2233=(1/(4*pi))*(C13_m*I1221+C23_m*I2222+C33_m*I3223+e33_m*I3224)
S(2,3)=S2211;

% S2223=(1/(4*pi))*(C44_m*(I2223+I3222)+e24_m*I2224)
% S(2,4)=S2223;
% 
% S2213=(1/(4*pi))*(C55_m*(I1223+I3221)+e15_m*I1224)
% S(2,5)=S2213;
% 
% S2212=(1/(4*pi))*(C66_m*(I1222+I2221))
% S(2,6)=S2212;
% 
% S2241=(1/(4*pi))*(e15_m*(I1223+I3221)-k11_m*I1224)
% S(2,7)=S2241;
% 
% S2242=(1/(4*pi))*(e24_m*(I2223+I3222)-k22_m*I2224)
% S(2,8)=S2242;

S2243=(1/(4*pi))*(e31_m*I1221+e32_m*I2222+e33_m*I3223-k33_m*I3224)
S(2,9)=S2243;

%
S3311=(1/(4*pi))*(C11_m*I1331+C21_m*I2332+C31_m*I3333+e31_m*I3334)
S(3,1)=S3311;

S3322=(1/(4*pi))*(C12_m*I1331+C22_m*I2332+C32_m*I3333+e32_m*I3334)
S(3,2)=S3322;


S3333=(1/(4*pi))*(C13_m*I1331+C23_m*I2332+C33_m*I3333+e33_m*I3334)
S(3,3)=S3333;

% S3323=(1/(4*pi))*(C44_m*(I2333+I2332)+e24_m*I2334)
% S(3,4)=S3323;
% 
% S3313=(1/(4*pi))*(C55_m*(I1333+I3331)+e15_m*I1334)
% S(3,5)=S3313;
% 
% 
% S3312=(1/(4*pi))*(C66_m*(I1332+I2331))
% S(3,6)=S3312;
% 
% 
% S3341=(1/(4*pi))*(e15_m*(I1333+I3331)-k11_m*I1334)
% S(3,7)=S3341;
% 
% S3342=(1/(4*pi))*(e24_m*(I2333+I3332)-k22_m*I2334)
% S(3,8)=S3342;
% 

S3343=(1/(4*pi))*(e31_m*I1331+e32_m*I2332+e33_m*I3333-k33_m*I3334)
S(3,9)=S3343;



%%
% S2311=(1/(8*pi))*(C11_m*(I1321+I1231)+C21_m*(I2322+I2232)+C31_m*(I3323+I3233)+e31_m*(I3324+I3234))
% S(4,1)=S2311;
% 
% S2322=(1/(8*pi))*(C12_m*(I1321+I1231)+C22_m*(I2322+I2232)+C32_m*(I3323+I3233)+e32_m*(I3324+I3234))
% S(4,2)=S2322;
% 
% S2333=(1/(8*pi))*(C13_m*(I1321+I1231)+C23_m*(I2322+I2232)+C33_m*(I3323+I3233)+e33_m*(I3324+I3234))
% S(4,3)=S2333;


S2323=(1/(8*pi))*(C44_m*(I2233+I2323+I3232+I2322)+e24_m*(I2234+I2324))
S(4,4)=S2323;


% S2313=(1/(8*pi))*(C55_m*(I1323+I1233+I3321+I3231)+e15_m*(I1324+I1234))
% S(4,5)=S2313;
% 
% S2312=(1/(8*pi))*(C66_m*(I1322+I1232+I2321+I2231))
% S(4,6)=S2312;
% 
% S2341=(1/(8*pi))*(e15_m*(I1323+I1233+I3321+I3231)-k11_m*(I3321+I3231))
% S(4,7)=S2341;

S2342=(1/(8*pi))*(e24_m*(I2233+I2323+I3232+I2322)-k22_m*(I2234+I2324))
S(4,8)=S2342;

% S2343=(1/(8*pi))*(e31_m*(I1321+I1231)+e32_m*(I2322+I2232)+e33_m*(I3323+I3233)-k33_m*(I3324+I3234))
% S(4,9)=S2343;

%%
% S1311=(1/(8*pi))*(C11_m*(I1311+I1131)+C21_m*(I2312+I2132)+C31_m*(I3313+I3133)+e31_m*(I3314+I3134))
% S(5,1)=S1311;
% 
% S1322=(1/(8*pi))*(C12_m*(I1311+I1131)+C22_m*(I2312+I2132)+C32_m*(I3313+I3133)+e32_m*(I3314+I3134))
% S(5,2)=S1322;
% 
% S1333=(1/(8*pi))*(C13_m*(I1311+I1131)+C23_m*(I2312+I2132)+C33_m*(I3313+I3133)+e33_m*(I3314+I3134))
% S(5,3)=S1333;
% 
% S1323=(1/(8*pi))*(C44_m*(I2313+I2132+I3312+I3132)+e24_m*(I2314+I2134))
% S(5,4)=S1323;

S1313=(1/(8*pi))*(C55_m*(I1133+I1313+I3131+I3311)+e15_m*(I1134+I1314))
S(5,5)=S1313;

% S1312=(1/(8*pi))*(C66_m*(I1312+I1132+I2311+I2131))
% S(5,6)=S1312;


S1341=(1/(8*pi))*(e15_m*(I1133+I1313+I3131+I3311)-k11_m*(I1134+I1314))
S(5,7)=S1341;

% S1342=(1/(8*pi))*(e24_m*(I2313+I2133+I3312+I3132)-k22_m*(I2314+I2134))
% S(5,8)=S1342;
% 
% S1343=(1/(8*pi))*(e31_m*(I1311+I1131)+e32_m*(I2312+I2132)+e33_m*(I3313+I3133)-k33_m*(I3314+I3134))
% S(5,9)=S1343;


%%
% S1211=(1/(8*pi))*(C11_m*(I1211+I1121)+C21_m*(I2212+I2122)+C31_m*(I3213+I3123)+e31_m*(I3214+I3124))
% S(6,1)=S1211;
% 
% S1222=(1/(8*pi))*(C12_m*(I1211+I1121)+C22_m*(I2212+I2122)+C32_m*(I3213+I3123)+e32_m*(I3214+I3124))
% S(6,2)=S1222;
% 
% S1233=(1/(8*pi))*(C13_m*(I1211+I1121)+C23_m*(I2212+I2122)+C33_m*(I3213+I3123)+e33_m*(I3214+I3124))
% S(6,3)=S1233;
% 
% S1223=(1/(8*pi))*(C44_m*(I2213+I2123+I3212+I3122)+e24_m*(I2214+I2124))
% S(6,4)=S1223;
% 
% S1213=(1/(8*pi))*(C55_m*(I1213+I1223+I3211+I3123)+e15_m*(I1214+I1224))
% S(6,5)=S1213;


S1212=(1/(8*pi))*(C66_m*(I1122+I1212+I2121+I2211))
S(6,6)=S1212;


% S1241=(1/(8*pi))*(e15_m*(I1213+I1123+I3211+I3121)-k11_m*(I1214+I1124))
% S(6,7)=S1241;
% 
% S1242=(1/(8*pi))*(e24_m*(I2213+I2123+I3212+I3122)-k22_m*(I2214+I2124))
% S(6,8)=S1242;
% 
% S1243=(1/(8*pi))*(e31_m*(I1211+I1121)+e32_m*(I2212+I2122)+e33_m*(I3213+I3123)-k33_m*(I3214+I3124))
% S(6,9)=S1242;



%%
% S4111=(1/(4*pi))*(C11_m*I1141+C21_m*I2142+C31_m*I3143+e31_m*I3144)
% S(7,1)=S4111;
% 
% S4122=(1/(4*pi))*(C12_m*I1141+C22_m*I2142+C32_m*I3143+e32_m*I3144)
% S(7,2)=S4122;
% 
% S4133=(1/(4*pi))*(C13_m*I1141+C23_m*I2142+C33_m*I3143+e33_m*I3144)
% S(7,3)=S4133;
% 
% S4123=(1/(4*pi))*(C44_m*(I2143+I3142)+e24_m*I2144)
% S(7,4)=S4123;

S4113=(1/(4*pi))*(C55_m*(I1143+I3141)+e15_m*I1144)
S(7,5)=S4113;

% S4112=(1/(4*pi))*(C66_m*(I1142+I2141))
% S(7,6)=S4112;

S4141=(1/(4*pi))*(e15_m*(I1143+I3141)-k11_m*I1144)
S(7,7)=S4141;

% S4142=(1/(4*pi))*(e24_m*(I2143+I3142)-k22_m*I2144)
% S(7,8)=S4142;
% 
% S4143=(1/(4*pi))*(e31_m*I1141+e32_m*I2142+e33_m*I3143-k33_m*I3144)
% S(7,9)=S4143;
%%
% S4211=(1/(4*pi))*(C11_m*I1241+C21_m*I2242+C31_m*I3243+e31_m*I3244)
% S(8,1)=S4211;
% 
% S4222=(1/(4*pi))*(C12_m*I1241+C22_m*I2242+C32_m*I3243+e32_m*I3244)
% S(8,2)=S4222;
% 
% S4233=(1/(4*pi))*(C13_m*I1241+C23_m*I2242+C33_m*I3243+e33_m*I3244)
% S(8,3)=S4233;
% 
% 
S4223=(1/(4*pi))*(C44_m*(I2243+I3242)+e24_m*I2244)
S(8,4)=S4223;

% S4213=(1/(4*pi))*(C55_m*I1243+e15_m*I1244+C55_m*I3241)
% S(8,5)=S4213;
% 
% S4212=(1/(4*pi))*(C66_m*(I1242+I3241))
% S(8,6)=S4212;
% 
% S4241=(1/(4*pi))*(e15_m*(I1243+I3241)-k11_m*I1244)
% S(8,7)=S4241;

S4242=(1/(4*pi))*(e24_m*(I2243+I3242)-k22_m*I2244)
S(8,8)=S4242;

% S4243=(1/(4*pi))*(e31_m*I1241+e32_m*I2242+e33_m*I3243-k33_m*I3244)
% S(8,9)=S4243;

%

S4311= (1/(4*pi))*(C11_m*I1341+C21_m*I2342+C31_m*I3343+e31_m*I3344)
S(9,1)=S4311;

S4322=(1/(4*pi))*(C12_m*I1341+C22_m*I2342+C32_m*I3343+e32_m*I3344)
S(9,2)=S4322;

S4333=(1/(4*pi))*(C13_m*I1341+C23_m*I2342+C33_m*I3343+e33_m*I3344)
S(9,3)=S4333;

% S4323=(1/(4*pi))*(C44_m*(I2343+I3342)+e24_m*I2344)
% S(9,4)=S4323;
% 
% S4313=(1/(4*pi))*(C55_m*(I1343+I3341)+e15_m*I1344)
% S(9,5)=S4313;
% 
% S4312=(1/(4*pi))*(C66_m*(I1342+I2341))
% S(9,6)=S4312;

% S4341=(1/(4*pi))*(e15_m*(I1343+I3341)-k11_m*I1344)
% S(9,7)=S4341;
% 
% S4342=(1/(4*pi))*(e24_m*(e24_m*(I2343+I3342)-k22_m*I2344))
% S(9,8)=S4342;

S4343=(1/(4*pi))*(e31_m*I1341+e32_m*I2342+e33_m*I3343-k33_m*I3344)
S(9,9)=S4343;


 

%%
fileID = fopen('general_ellipsoid_PVDF_batio3_x1_axis.xls','w');
fprintf(fileID,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'vf', 'E1', 'E2', 'E3', 'G23', 'G13', 'G12', 'nu23', 'nu13', 'nu12', 'd31[C/N]', 'd32[C/N]', 'd33[C/N]', 'd15[C/N]', 'd24[C/N]', 'k11','k22','k33');

%%
i=1;
for vf=0:0.005:1
 vol_frac(i)=vf;
vm=1-vf;
 I= eye(9);
A_dil2D = inv(I  + (S*(inv(E_m))*(E_f - E_m)))
A_MT2D = A_dil2D*(inv((vm*I) + (vf*A_dil2D)))
E_composite(:,:,i) = E_m + (vf*(E_f-E_m)*A_MT2D)
 E_composite_compliance(:,:,i) = inv(E_composite(:,:,i));
% A_N=inv(I+S*inv(E_m)*(E_f-E_m));
% E_composite(:,:,i)=E_m+vf*(E_f-E_m)*A_N*inv((1-vf)*I+vf*A_N);
 
 

%% calculating the properties of the composite
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
E1_composite(i)=1/(Smatrix(1,1,i));
E2_composite(i)=1/(Smatrix(2,2,i));
E3_composite(i)=1/(Smatrix(3,3,i));
% 
G23(i)=1/(Smatrix(4,4,i));
G13(i)=1/(Smatrix(5,5,i));
G12(i)=1/(Smatrix(6,6,i));

nu12(i)=-(E1_composite(i)*Smatrix(1,2,i));
nu13(i)=-(E1_composite(i)*Smatrix(1,3,i));
nu23(i)=-(E2_composite(i)*Smatrix(2,3,i));

k11(i)=-E_composite(7,7,i);
k22(i)=-E_composite(8,8,i);
k33(i)=-E_composite(9,9,i);

d15(i)=dmatrix(1,5,i);
d24(i)=dmatrix(2,4,i);
d31(i)=dmatrix(3,1,i);
d32(i)=dmatrix(3,2,i);
d33(i)=dmatrix(3,3,i);
fprintf(fileID,'%f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', vol_frac(i), E1_composite(i), E2_composite(i), E3_composite(i), G23(i), G13(i), G12(i), nu23(i), nu13(i), nu12(i), d31(i), d32(i), d33(i), d15(i), d24(i), k11(i),k22(i),k33(i));
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
ylabel('Piezoelectric Constants')

