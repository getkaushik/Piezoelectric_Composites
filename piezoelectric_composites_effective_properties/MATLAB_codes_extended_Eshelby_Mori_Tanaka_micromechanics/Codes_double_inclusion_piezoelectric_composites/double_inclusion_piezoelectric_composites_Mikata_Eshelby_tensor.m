%% Code to calculate effective electroelastic properties of a piezoelectric
% composite with an isotropic non-piezoelectric matrix and a two-phase 
% co-axial ellipsoidal inclusion with a core-shell morphology.
% For comparison, the properties of a composite with a polymer matrix and a 
% piezoceramic inclusion. without any interfacial layer are also
% calculated.
% For unidirectional composites, the major axis of the ellipsoidal 
% inclusion is aligned along the x3-axis or z-direction of the matrix.
% Code for double inclusion model is based on the paper by Lin and Sodano, A double inclusion model
% for multiphase piezoelectric composites, Smart Materials and Structures,
% volume 19 (2010), 035003.
% DO NOT USE THIS CODE FOR COMPOSITES WITH ORTHOTROPIC MATRIX.
% This code works only for composites with isotropic and transversely
% isotropic matrix.
clc
close all
clear all
format long
%
fileID1 = fopen('unidirectional_derived_properties_ESO_PANI_BTO_aspect1pt3_MikataEshelbytensor.xls','w');
fprintf(fileID1,'%s\t %s\t %s\t %s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'c1', 'c2','c3','E1(GPa)', 'E2(GPa)', 'E3(GPa)', 'G23(GPa)', 'G13(GPa)', 'G12(GPa)', 'nu23', 'nu13', 'nu12', 'd31[pC/N]', 'd32[pC/N]', 'd33[pC/N]', 'd15[pC/N]', 'd24[pC/N]', 'k11','k22','k33');
%
fileID2=fopen('unidirectional_material_properties_ESO_PANI_BTO_aspect1pt3_MikataEshelbytensor.xls','w');
fprintf(fileID2,'%s\t %s\t %s\t %s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'c1', 'c2','c3','C11(GPa)', 'C12(GPa)', 'C13(GPa)', 'C22(GPa)', 'C23(GPa)', 'C33(GPa)', 'C44(GPa)', 'C55(GPa)', 'C66(GPa)', 'e31[C/m2]', 'e32[C/m2]', 'e33[C/m2]', 'e15[C/m2]', 'e24[C/m2]', 'k11','k22','k33');
%
fileID3 = fopen('random_oriented_derived_properties_ESO_PANI_BTO_aspect1pt3_MikataEshelbytensor.xls','w');
fprintf(fileID3,'%s\t %s\t %s\t %s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'c1', 'c2','c3','E1(GPa)', 'E2(GPa)', 'E3(GPa)', 'G23(GPa)', 'G13(GPa)', 'G12(GPa)', 'nu23', 'nu13', 'nu12', 'd31[pC/N]', 'd32[pC/N]', 'd33[pC/N]', 'd15[pC/N]', 'd24[pC/N]', 'k11','k22','k33');
%
fileID4=fopen('random_oriented_material_properties_ESO_PANI_BTO_aspect1pt3_MikataEshelbytensor.xls','w');
fprintf(fileID4,'%s\t %s\t %s\t %s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'c1', 'c2','c3','C11(GPa)', 'C12(GPa)', 'C13(GPa)', 'C22(GPa)', 'C23(GPa)', 'C33(GPa)', 'C44(GPa)', 'C55(GPa)', 'C66(GPa)', 'e31[C/m2]', 'e32[C/m2]', 'e33[C/m2]', 'e15[C/m2]', 'e24[C/m2]', 'k11','k22','k33');
%
fileID5 = fopen('unidirectional_derived_properties_ESO_BTO_aspect1pt3_MikataEshelbytensor.xls','w');
fprintf(fileID5,'%s\t %s\t %s\t %s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'c1', 'c2','c3','E1(GPa)', 'E2(GPa)', 'E3(GPa)', 'G23(GPa)', 'G13(GPa)', 'G12(GPa)', 'nu23', 'nu13', 'nu12', 'd31[pC/N]', 'd32[pC/N]', 'd33[pC/N]', 'd15[pC/N]', 'd24[pC/N]', 'k11','k22','k33');
%
fileID6=fopen('unidirectional_material_properties_ESO_BTO_aspect1pt3_MikataEshelbytensor.xls','w');
fprintf(fileID6,'%s\t %s\t %s\t %s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'c1', 'c2','c3','C11(GPa)', 'C12(GPa)', 'C13(GPa)', 'C22(GPa)', 'C23(GPa)', 'C33(GPa)', 'C44(GPa)', 'C55(GPa)', 'C66(GPa)', 'e31[C/m2]', 'e32[C/m2]', 'e33[C/m2]', 'e15[C/m2]', 'e24[C/m2]', 'k11','k22','k33');
%
fileID7 = fopen('random_oriented_derived_properties_ESO_BTO_aspect1pt3_MikataEshelbytensor.xls','w');
fprintf(fileID7,'%s\t %s\t %s\t %s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'c1', 'c2','c3','E1(GPa)', 'E2(GPa)', 'E3(GPa)', 'G23(GPa)', 'G13(GPa)', 'G12(GPa)', 'nu23', 'nu13', 'nu12', 'd31[pC/N]', 'd32[pC/N]', 'd33[pC/N]', 'd15[pC/N]', 'd24[pC/N]', 'k11','k22','k33');
%
fileID8=fopen('random_oriented_material_properties_ESO_BTO_aspect1pt3_MikataEshelbytensor.xls','w');
fprintf(fileID8,'%s\t %s\t %s\t %s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'c1', 'c2','c3','C11(GPa)', 'C12(GPa)', 'C13(GPa)', 'C22(GPa)', 'C23(GPa)', 'C33(GPa)', 'C44(GPa)', 'C55(GPa)', 'C66(GPa)', 'e31[C/m2]', 'e32[C/m2]', 'e33[C/m2]', 'e15[C/m2]', 'e24[C/m2]', 'k11','k22','k33');
%
%% Geometry of inclusions
aspect_ratio = 1.3 % a3/a1
alpha = 1; % aspect ratio a1/a2
beta = 1/aspect_ratio; %aspect ratio a1/a3
%% Properties of matrix Epoxidized Soyabean Oil (ESO)
%
e0 = 8.85418782e-12; % Permittivity of free space, Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
C11_m = 72.86*10^(6);% units in Pa,Component of stiffness matrix
C12_m = 48.57*10^(6);% units in Pa,Component of stiffness matrix
C13_m = 48.57*10^(6);% units in Pa,Component of stiffness matrix
C31_m = C13_m;
C21_m = C12_m;
C22_m = 72.86*10^(6);% units in Pa,Component of stiffness matrix
C23_m = 48.57*10^(6);% units in Pa,Component of stiffness matrix
C32_m = C23_m;
C33_m = 72.86*10^(6);% units in Pa,Component of stiffness matrix
C44_m = 12.145*10^(6);% units in Pa,Component of stiffness matrix
C55_m = 12.145*10^(6);% unitss in Pa,Component of stiffness matrix
C66_m = 12.145*10^(6);% units in Pa,Component of stiffness matrix
k11_m = 3.38*e0;% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
k22_m = 3.38*e0;% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
k33_m = 3.38*e0;% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
e15_m = 0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_m = 0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_m = 0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_m = 0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_m = 0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
E_m = [C11_m/(10^9),C12_m/(10^9), C13_m/(10^9), 0, 0, 0, 0, 0, e31_m;
       C12_m/(10^9),C22_m/(10^9), C23_m/(10^9), 0, 0, 0, 0, 0, e32_m;
       C13_m/(10^9),C23_m/(10^9), C33_m/(10^9), 0, 0, 0, 0, 0, e33_m;
       0, 0, 0, C44_m/(10^9), 0, 0, 0, e24_m, 0;
       0, 0, 0, 0, C55_m/(10^9), 0, e15_m, 0, 0;
       0, 0, 0, 0, 0, C66_m/(10^9), 0, 0, 0;
       0, 0, 0, 0, e15_m, 0, -k11_m/e0, 0, 0;
       0, 0, 0, e24_m, 0, 0, 0, -k22_m/e0, 0;
       e31_m, e32_m, e33_m, 0, 0, 0, 0, 0,-k33_m/e0];
%
%% Properties of interfacial layer Polyaniline (PANI)
% 
C11_i = 1.685*(10^9);% units in Pa,Component of stiffness matrix
C12_i = 1.033*(10^9);% units in Pa,Component of stiffness matrix
C13_i = 1.033*(10^9);% units in Pa,Component of stiffness matrix
C22_i = 1.685*(10^9);% units in Pa,Component of stiffness matrix
C23_i = 1.033*(10^9);% units in Pa,Component of stiffness matrix
C33_i = 1.685*(10^9);% units in Pa,Component of stiffness matrix
C44_i = 3.261*(10^8);% units in Pa,Component of stiffness matrix
C55_i = 3.261*(10^8);% unitss in Pa,Component of stiffness matrix
C66_i = 3.261*(10^8);% units in Pa,Component of stiffness matrix
k11_i = 7.88*10^(-11);% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
k22_i = 7.88*10^(-11);% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
k33_i = 7.88*10^(-11);% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
e15_i = 0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_i = 0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_i = 0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_i = 0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_i = 0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
E_i = [C11_i/(10^9),C12_i/(10^9), C13_i/(10^9), 0, 0, 0, 0, 0, e31_i;
       C12_i/(10^9),C22_i/(10^9), C23_i/(10^9), 0, 0, 0, 0, 0, e32_i;
       C13_i/(10^9),C23_i/(10^9), C33_i/(10^9), 0, 0, 0, 0, 0, e33_i;
       0, 0, 0, C44_i/(10^9), 0, 0, 0, e24_i, 0;
       0, 0, 0, 0, C55_i/(10^9), 0, e15_i, 0, 0;
       0, 0, 0, 0, 0, C66_i/(10^9), 0, 0, 0;
       0, 0, 0, 0, e15_i, 0, -k11_i/e0, 0, 0;
       0, 0, 0, e24_i, 0, 0, 0, -k22_i/e0, 0;
       e31_i, e32_i, e33_i, 0, 0, 0, 0, 0,-k33_i/e0];
%
%% Properties of Reinforcement
% Barium Titanate (BTO)
C11_f = 27.5121*10^(10);% units in Pa,Component of stiffness matrix
C12_f = 17.8967*10^(10);% units in Pa,Component of stiffness matrix
C13_f = 15.1555*10^(10);% units in Pa,Component of stiffness matrix
C22_f = 27.5121*10^(10);% units in Pa,Component of stiffness matrix
C23_f = 15.1555*10^(10);% units in Pa,Component of stiffness matrix
C33_f = 16.486*10^(10);% units in Pa,Component of stiffness matrix
C44_f = 5.43478*10^(10);% units in Pa,Component of stiffness matrix
C55_f = 5.43478*10^(10);% unitss in Pa,Component of stiffness matrix
C66_f = 11.3122*10^(10);% units in Pa,Component of stiffness matrix
k11_f = 1750.3*10^(-11);% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k22_f = 1750.3*10^(-11);% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k33_f = 98.9*10^(-11);% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
e15_f = 21.3043;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_f = 21.3043;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_f = -2.69289;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_f = -2.69289;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_f = 3.65468;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
E_f = [C11_f/(10^9),C12_f/(10^9), C13_f/(10^9), 0, 0, 0, 0, 0, e31_f;
       C12_f/(10^9),C22_f/(10^9), C23_f/(10^9), 0, 0, 0, 0, 0, e32_f;
       C13_f/(10^9),C23_f/(10^9), C33_f/(10^9), 0, 0, 0, 0, 0, e33_f;
       0, 0, 0, C44_f/(10^9), 0, 0, 0, e24_f, 0;
       0, 0, 0, 0, C55_f/(10^9), 0, e15_f, 0, 0;
       0, 0, 0, 0, 0, C66_f/(10^9), 0, 0, 0;
       0, 0, 0, 0, e15_f, 0, -k11_f/e0, 0, 0;
       0, 0, 0, e24_f, 0, 0, 0, -k22_f/e0, 0;
       e31_f, e32_f, e33_f, 0, 0, 0, 0, 0,-k33_f/e0];
%
%% Calculation of piezoelectric Eshleby tensors based on Mikata's paper
% "Determination of piezoelectric Eshelby tensor in transversely 
% isotropic piezoelectric solids", Yozo Mikata,
% International Journal of Engineering Science, 38, (2000) 605 - 641
syms theta phi x1 x2 x3 y1 y2 y3
% x1 = sin(theta)*cos(phi);   %x1 = y1;
% x2 = alpha*sin(theta)*sin(phi); %x2 = alpha*y2;
% x3 = beta*cos(theta); %x3 = beta*y3;
y1 = sin(theta)*cos(phi);
y2 = sin(theta)*sin(phi);
y3 = cos(theta);
% K_MJ=[C11_m*x1^2+C66_m*x2^2+C55_m*x3^2 (C12_m+C66_m)*x1*x2 (C13_m+C55_m)*x1*x3 (e31_m+e15_m)*x1*x3;
%      (C21_m+C66_m)*x1*x2 C66_m*x1^2+C22_m*x2^2+C44_m*x3^2 (C23_m+C44_m)*x2*x3 (e32_m+e24_m)*x2*x3;
%      (C55_m+C31_m)*x1*x3 (C44_m+C32_m)*x2*x3 C55_m*x1^2+C44_m*x2^2+C33_m*x3^2 e15_m*x1^2+e24_m*x2^2+e33_m*x3^2;
%      (e15_m+e31_m)*x1*x3 (e24_m+e32_m)*x2*x3 e15_m*x1^2+e24_m*x2^2+e33_m*x3^2 -k11_m*x1^2-k22_m*x2^2-k33_m*x3^2;];
% B =inv(K_MJ);
%
i1111 = cos(phi)^2*sin(theta)^2*(2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 - cos(phi)^6*sin(theta)^6*C12_m*e15_m^2 + 2*cos(theta)^6*C33_m*C44_m*k33_m + 2*sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + 2*cos(theta)^6*C44_m*e33_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*C12_m*C33_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m - cos(phi)^2*cos(theta)^4*sin(theta)^2*C12_m*C33_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*C12_m*C44_m*k33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*e15_m*e33_m + 5*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 4*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m - cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*k11_m - 2*cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C44_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C44_m^2 - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*C12_m*e33_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e15_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C12_m*e15_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e15_m*e33_m + 5*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 4*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 - cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*e15_m^2 - 2*cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - cos(phi)^6*sin(theta)^6*C12_m*C44_m*k11_m - 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)*(- cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C33_m*C44_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m^2*e33_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m^2*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C44_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*e15_m*e33_m*C11_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C44_m*k11_m*C11_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C44_m*k11_m*C11_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C44_m*k33_m*C13_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*e15_m^2 - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*e15_m^2 - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*e15_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - sin(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*e31_m*e33_m*C44_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m^2*e15_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m^2*e15_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m^2*e15_m^2 + cos(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*e31_m*e33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 - sin(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 + cos(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 + 2*cos(theta)^8*C33_m*k33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*C44_m*k11_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*C44_m*k11_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 6*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 2*cos(theta)^8*C44_m^2*e33_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C13_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C33_m*k11_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C44_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C33_m*k33_m*C11_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C44_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C44_m*k33_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m^2 - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e31_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e31_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*e31_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C33_m*C44_m*k33_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*C44_m*k11_m)^-1
G1111 = matlabFunction(i1111,'vars',[theta,phi])
I1111 = integral2(G1111,0,pi,0,2*pi)
%
i1122 = cos(phi)^2*sin(theta)^2*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - sin(phi)^6*sin(theta)^6*C12_m*C44_m*k11_m + 2*cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + 2*cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 - sin(phi)^6*sin(theta)^6*C12_m*e15_m^2 + 2*cos(theta)^6*C44_m*e33_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*e15_m*e33_m + 4*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 5*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*k11_m - cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - cos(theta)^2*sin(phi)^4*sin(theta)^4*C12_m*C33_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m - cos(theta)^4*sin(phi)^2*sin(theta)^2*C12_m*C33_m*k33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - cos(theta)^2*sin(phi)^4*sin(theta)^4*C12_m*C44_m*k33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C44_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C44_m^2 - 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 4*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 5*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 - 2*cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*e15_m^2 - cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*e15_m^2 + 2*cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*C12_m*e33_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C12_m*e15_m*e33_m + 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e15_m*e33_m)*(- cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C33_m*C44_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m^2*e33_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m^2*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C44_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*e15_m*e33_m*C11_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C44_m*k11_m*C11_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C44_m*k11_m*C11_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C44_m*k33_m*C13_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*e15_m^2 - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*e15_m^2 - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*e15_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - sin(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*e31_m*e33_m*C44_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m^2*e15_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m^2*e15_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m^2*e15_m^2 + cos(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*e31_m*e33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 - sin(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 + cos(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 + 2*cos(theta)^8*C33_m*k33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*C44_m*k11_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*C44_m*k11_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 6*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 2*cos(theta)^8*C44_m^2*e33_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C13_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C33_m*k11_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C44_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C33_m*k33_m*C11_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C44_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C44_m*k33_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m^2 - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e31_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e31_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*e31_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C33_m*C44_m*k33_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*C44_m*k11_m)^-1
G1122 = matlabFunction(i1122,'vars',[theta,phi])
I1122 = integral2(G1122,0,pi,0,2*pi)
%
i1133 = cos(phi)^2*sin(theta)^2*(cos(phi)^2*cos(theta)^2*sin(theta)^2*C11_m*k33_m + cos(phi)^2*cos(theta)^2*sin(theta)^2*C44_m*k11_m + 2*cos(phi)^2*sin(phi)^2*sin(theta)^4*C11_m*k11_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C11_m*k33_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C44_m*k11_m + cos(phi)^2*cos(theta)^2*sin(theta)^2*e15_m^2 + cos(phi)^2*cos(theta)^2*sin(theta)^2*e31_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(theta)^2*e15_m*e31_m + cos(phi)^4*sin(theta)^4*C11_m*k11_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*e15_m^2 + cos(theta)^2*sin(phi)^2*sin(theta)^2*e31_m^2 + 2*cos(theta)^2*sin(phi)^2*sin(theta)^2*e15_m*e31_m + sin(phi)^4*sin(theta)^4*C11_m*k11_m + cos(theta)^4*C44_m*k33_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1
G1133 = matlabFunction(i1133,'vars',[theta,phi])
I1133 = integral2(G1133,0,pi,0,2*pi)
%
i1134 = cos(phi)^2*sin(theta)^2*(cos(theta)^4*C44_m*e33_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m*e15_m + cos(phi)^2*cos(theta)^2*sin(theta)^2*C11_m*e33_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m*e31_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C44_m*e31_m + 2*cos(phi)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m - cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m*e15_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C11_m*e33_m - cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m*e31_m - cos(theta)^2*sin(phi)^2*sin(theta)^2*C44_m*e31_m + cos(phi)^4*sin(theta)^4*C11_m*e15_m + sin(phi)^4*sin(theta)^4*C11_m*e15_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1
%G1134 = matlabFunction(i1134,'vars',[theta,phi])
%I1134 = integral2(G1134,0,pi,0,2*pi)
I1134 = 0;
I1143 = I1134;
%
i1144 = -cos(phi)^2*sin(theta)^2*(cos(phi)^2*cos(theta)^2*sin(theta)^2*C11_m*C33_m - 2*cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m*C44_m + 2*cos(phi)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C11_m*C33_m - 2*cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m*C44_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m^2 - cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m^2 + cos(phi)^4*sin(theta)^4*C11_m*C44_m + sin(phi)^4*sin(theta)^4*C11_m*C44_m + cos(theta)^4*C33_m*C44_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1
G1144 = matlabFunction(i1144,'vars',[theta,phi])
I1144 = integral2(G1144,0,pi,0,2*pi)
%
i2211 = (2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 - cos(phi)^6*sin(theta)^6*C12_m*e15_m^2 + 2*cos(theta)^6*C33_m*C44_m*k33_m + 2*sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + 2*cos(theta)^6*C44_m*e33_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*C12_m*C33_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m - cos(phi)^2*cos(theta)^4*sin(theta)^2*C12_m*C33_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*C12_m*C44_m*k33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*e15_m*e33_m + 5*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 4*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m - cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*k11_m - 2*cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C44_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C44_m^2 - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*C12_m*e33_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e15_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C12_m*e15_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e15_m*e33_m + 5*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 4*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 - cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*e15_m^2 - 2*cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - cos(phi)^6*sin(theta)^6*C12_m*C44_m*k11_m - 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)*(- cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C33_m*C44_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m^2*e33_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m^2*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C44_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*e15_m*e33_m*C11_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C44_m*k11_m*C11_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C44_m*k11_m*C11_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C44_m*k33_m*C13_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*e15_m^2 - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*e15_m^2 - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*e15_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - sin(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*e31_m*e33_m*C44_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m^2*e15_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m^2*e15_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m^2*e15_m^2 + cos(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*e31_m*e33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 - sin(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 + cos(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 + 2*cos(theta)^8*C33_m*k33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*C44_m*k11_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*C44_m*k11_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 6*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 2*cos(theta)^8*C44_m^2*e33_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C13_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C33_m*k11_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C44_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C33_m*k33_m*C11_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C44_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C44_m*k33_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m^2 - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e31_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e31_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*e31_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C33_m*C44_m*k33_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*C44_m*k11_m)^-1*sin(phi)^2*sin(theta)^2*alpha^2
G2211 = matlabFunction(i2211,'vars',[theta,phi])
I2211 = integral2(G2211,0,pi,0,2*pi)
%
i2222 = (sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - sin(phi)^6*sin(theta)^6*C12_m*C44_m*k11_m + 2*cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + 2*cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 - sin(phi)^6*sin(theta)^6*C12_m*e15_m^2 + 2*cos(theta)^6*C44_m*e33_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*e15_m*e33_m + 4*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 5*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*k11_m - cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - cos(theta)^2*sin(phi)^4*sin(theta)^4*C12_m*C33_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m - cos(theta)^4*sin(phi)^2*sin(theta)^2*C12_m*C33_m*k33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - cos(theta)^2*sin(phi)^4*sin(theta)^4*C12_m*C44_m*k33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C44_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C44_m^2 - 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 4*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 5*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 - 2*cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*e15_m^2 - cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*e15_m^2 + 2*cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*C12_m*e33_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C12_m*e15_m*e33_m + 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e15_m*e33_m)*(- cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C33_m*C44_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m^2*e33_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m^2*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C44_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*e15_m*e33_m*C11_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C44_m*k11_m*C11_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C44_m*k11_m*C11_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C44_m*k33_m*C13_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*e15_m^2 - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*e15_m^2 - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*e15_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - sin(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*e31_m*e33_m*C44_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m^2*e15_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m^2*e15_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m^2*e15_m^2 + cos(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*e31_m*e33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 - sin(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 + cos(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 + 2*cos(theta)^8*C33_m*k33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*C44_m*k11_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*C44_m*k11_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 6*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 2*cos(theta)^8*C44_m^2*e33_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C13_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C33_m*k11_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C44_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C33_m*k33_m*C11_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C44_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C44_m*k33_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m^2 - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e31_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e31_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*e31_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C33_m*C44_m*k33_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*C44_m*k11_m)^-1*sin(phi)^2*sin(theta)^2*alpha^2
G2222 = matlabFunction(i2222,'vars',[theta,phi])
I2222 = integral2(G2222,0,pi,0,2*pi)
%
i2233 = (cos(phi)^2*cos(theta)^2*sin(theta)^2*C11_m*k33_m + cos(phi)^2*cos(theta)^2*sin(theta)^2*C44_m*k11_m + 2*cos(phi)^2*sin(phi)^2*sin(theta)^4*C11_m*k11_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C11_m*k33_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C44_m*k11_m + cos(phi)^2*cos(theta)^2*sin(theta)^2*e15_m^2 + cos(phi)^2*cos(theta)^2*sin(theta)^2*e31_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(theta)^2*e15_m*e31_m + cos(phi)^4*sin(theta)^4*C11_m*k11_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*e15_m^2 + cos(theta)^2*sin(phi)^2*sin(theta)^2*e31_m^2 + 2*cos(theta)^2*sin(phi)^2*sin(theta)^2*e15_m*e31_m + sin(phi)^4*sin(theta)^4*C11_m*k11_m + cos(theta)^4*C44_m*k33_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1*sin(phi)^2*sin(theta)^2*alpha^2
G2233 = matlabFunction(i2233,'vars',[theta,phi])
I2233 = integral2(G2233,0,pi,0,2*pi)
%
i2234 = (cos(theta)^4*C44_m*e33_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m*e15_m + cos(phi)^2*cos(theta)^2*sin(theta)^2*C11_m*e33_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m*e31_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C44_m*e31_m + 2*cos(phi)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m - cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m*e15_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C11_m*e33_m - cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m*e31_m - cos(theta)^2*sin(phi)^2*sin(theta)^2*C44_m*e31_m + cos(phi)^4*sin(theta)^4*C11_m*e15_m + sin(phi)^4*sin(theta)^4*C11_m*e15_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1*sin(phi)^2*sin(theta)^2*alpha^2
% G2234 = matlabFunction(i2234,'vars',[theta,phi])
% I2234 = integral2(G2234,0,pi,0,2*pi)
I2234 = 0;
I2243 = I2234;
%
i2244 = -(cos(phi)^2*cos(theta)^2*sin(theta)^2*C11_m*C33_m - 2*cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m*C44_m + 2*cos(phi)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C11_m*C33_m - 2*cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m*C44_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m^2 - cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m^2 + cos(phi)^4*sin(theta)^4*C11_m*C44_m + sin(phi)^4*sin(theta)^4*C11_m*C44_m + cos(theta)^4*C33_m*C44_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1*sin(phi)^2*sin(theta)^2*alpha^2
G2244 = matlabFunction(i2244,'vars',[theta,phi])
I2244 = integral2(G2244,0,pi,0,2*pi)
%
i3311 = cos(theta)^2*beta^2*(2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 - cos(phi)^6*sin(theta)^6*C12_m*e15_m^2 + 2*cos(theta)^6*C33_m*C44_m*k33_m + 2*sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + 2*cos(theta)^6*C44_m*e33_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*C12_m*C33_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m - cos(phi)^2*cos(theta)^4*sin(theta)^2*C12_m*C33_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*C12_m*C44_m*k33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*e15_m*e33_m + 5*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 4*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m - cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*k11_m - 2*cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C44_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C44_m^2 - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*C12_m*e33_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e15_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C12_m*e15_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e15_m*e33_m + 5*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 4*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 - cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*e15_m^2 - 2*cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - cos(phi)^6*sin(theta)^6*C12_m*C44_m*k11_m - 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)*(- cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C33_m*C44_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m^2*e33_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m^2*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C44_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*e15_m*e33_m*C11_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C44_m*k11_m*C11_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C44_m*k11_m*C11_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C44_m*k33_m*C13_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*e15_m^2 - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*e15_m^2 - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*e15_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - sin(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*e31_m*e33_m*C44_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m^2*e15_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m^2*e15_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m^2*e15_m^2 + cos(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*e31_m*e33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 - sin(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 + cos(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 + 2*cos(theta)^8*C33_m*k33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*C44_m*k11_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*C44_m*k11_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 6*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 2*cos(theta)^8*C44_m^2*e33_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C13_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C33_m*k11_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C44_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C33_m*k33_m*C11_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C44_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C44_m*k33_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m^2 - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e31_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e31_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*e31_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C33_m*C44_m*k33_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*C44_m*k11_m)^-1
G3311 = matlabFunction(i3311,'vars',[theta,phi])
I3311 = integral2(G3311,0,pi,0,2*pi)
%
i3322 = cos(theta)^2*beta^2*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - sin(phi)^6*sin(theta)^6*C12_m*C44_m*k11_m + 2*cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + 2*cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 - sin(phi)^6*sin(theta)^6*C12_m*e15_m^2 + 2*cos(theta)^6*C44_m*e33_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 3*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C12_m*e15_m*e33_m + 4*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 5*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*k11_m - cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - cos(theta)^2*sin(phi)^4*sin(theta)^4*C12_m*C33_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m - cos(theta)^4*sin(phi)^2*sin(theta)^2*C12_m*C33_m*k33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - cos(theta)^2*sin(phi)^4*sin(theta)^4*C12_m*C44_m*k33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C44_m^2 + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C44_m^2 - 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 4*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 5*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 - 2*cos(phi)^2*sin(phi)^4*sin(theta)^6*C12_m*e15_m^2 - cos(phi)^4*sin(phi)^2*sin(theta)^6*C12_m*e15_m^2 + 2*cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*C12_m*e33_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C12_m*e15_m*e33_m + 4*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e15_m*e33_m)*(- cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C33_m*C44_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m^2*e33_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m^2*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C44_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*e15_m*e33_m*C11_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C44_m*k11_m*C11_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C44_m*k11_m*C11_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C44_m*k33_m*C13_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*e15_m^2 - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*e15_m^2 - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*e15_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - sin(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*e31_m*e33_m*C44_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m^2*e15_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m^2*e15_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m^2*e15_m^2 + cos(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*e31_m*e33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 - sin(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 + cos(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 + 2*cos(theta)^8*C33_m*k33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*C44_m*k11_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*C44_m*k11_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 6*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 2*cos(theta)^8*C44_m^2*e33_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C13_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C33_m*k11_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C44_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C33_m*k33_m*C11_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C44_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C44_m*k33_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m^2 - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e31_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e31_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*e31_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C33_m*C44_m*k33_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*C44_m*k11_m)^-1
G3322 = matlabFunction(i3322,'vars',[theta,phi])
I3322 = integral2(G3322,0,pi,0,2*pi)
%
i3333 = cos(theta)^2*beta^2*(cos(phi)^2*cos(theta)^2*sin(theta)^2*C11_m*k33_m + cos(phi)^2*cos(theta)^2*sin(theta)^2*C44_m*k11_m + 2*cos(phi)^2*sin(phi)^2*sin(theta)^4*C11_m*k11_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C11_m*k33_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C44_m*k11_m + cos(phi)^2*cos(theta)^2*sin(theta)^2*e15_m^2 + cos(phi)^2*cos(theta)^2*sin(theta)^2*e31_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(theta)^2*e15_m*e31_m + cos(phi)^4*sin(theta)^4*C11_m*k11_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*e15_m^2 + cos(theta)^2*sin(phi)^2*sin(theta)^2*e31_m^2 + 2*cos(theta)^2*sin(phi)^2*sin(theta)^2*e15_m*e31_m + sin(phi)^4*sin(theta)^4*C11_m*k11_m + cos(theta)^4*C44_m*k33_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1
G3333 = matlabFunction(i3333,'vars',[theta,phi])
I3333 = integral2(G3333,0,pi,0,2*pi)
%
i3334 = cos(theta)^2*beta^2*(cos(theta)^4*C44_m*e33_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m*e15_m + cos(phi)^2*cos(theta)^2*sin(theta)^2*C11_m*e33_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m*e31_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C44_m*e31_m + 2*cos(phi)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m - cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m*e15_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C11_m*e33_m - cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m*e31_m - cos(theta)^2*sin(phi)^2*sin(theta)^2*C44_m*e31_m + cos(phi)^4*sin(theta)^4*C11_m*e15_m + sin(phi)^4*sin(theta)^4*C11_m*e15_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1
% G3334 = matlabFunction(i3334,'vars',[theta,phi])
% I3334 = integral2(G3334,0,pi,0,2*pi)
I3334 = 0;
I3343 = I3334;
%
i3344 = -cos(theta)^2*beta^2*(cos(phi)^2*cos(theta)^2*sin(theta)^2*C11_m*C33_m - 2*cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m*C44_m + 2*cos(phi)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m + cos(theta)^2*sin(phi)^2*sin(theta)^2*C11_m*C33_m - 2*cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m*C44_m - cos(phi)^2*cos(theta)^2*sin(theta)^2*C13_m^2 - cos(theta)^2*sin(phi)^2*sin(theta)^2*C13_m^2 + cos(phi)^4*sin(theta)^4*C11_m*C44_m + sin(phi)^4*sin(theta)^4*C11_m*C44_m + cos(theta)^4*C33_m*C44_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1
G3344 = matlabFunction(i3344,'vars',[theta,phi])
I3344 = integral2(G3344,0,pi,0,2*pi)
%
i1212 = -cos(phi)*sin(phi)*sin(theta)^2*alpha*(- 4*cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C13_m*e15_m^2 - 4*sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 - 2*cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C44_m*e15_m^2 - 2*sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C44_m*e15_m^2 + 2*cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C44_m*e31_m^2 + 2*sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C13_m*e15_m*e31_m + 2*sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m + 2*cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C12_m*e15_m*e33_m + 2*sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C12_m*e15_m*e33_m + cos(phi)*sin(phi)^5*sin(theta)^6*C11_m*C44_m*k11_m + sin(phi)*cos(phi)^5*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)*sin(phi)^5*sin(theta)^6*C12_m*C44_m*k11_m + sin(phi)*cos(phi)^5*sin(theta)^6*C12_m*C44_m*k11_m + cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C12_m*C33_m*k33_m - 4*cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m - 2*cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*k33_m*C44_m^2 + cos(phi)*sin(phi)^5*sin(theta)^6*C11_m*e15_m^2 + sin(phi)*cos(phi)^5*sin(theta)^6*C11_m*e15_m^2 + cos(phi)*sin(phi)^5*sin(theta)^6*C12_m*e15_m^2 + sin(phi)*cos(phi)^5*sin(theta)^6*C12_m*e15_m^2 + cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C12_m*e33_m^2 + 2*cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + 2*cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 - 4*cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 4*cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 4*cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 4*cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C44_m*e15_m*e33_m - 4*cos(phi)*sin(phi)*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 2*cos(phi)^3*sin(phi)^3*sin(theta)^6*C11_m*C44_m*k11_m + 2*cos(phi)^3*sin(phi)^3*sin(theta)^6*C12_m*C44_m*k11_m + cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C11_m*C33_m*k11_m + sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m + cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C12_m*C33_m*k11_m + sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C12_m*C33_m*k11_m - 4*cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C13_m*C44_m*k11_m - 4*sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C11_m*C44_m*k33_m + sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m + cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*C12_m*C44_m*k33_m + sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*C12_m*C44_m*k33_m - 2*cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*k11_m*C13_m^2 - 2*sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - 2*cos(phi)*cos(theta)^2*sin(phi)^3*sin(theta)^4*k11_m*C44_m^2 - 2*sin(phi)*cos(phi)^3*cos(theta)^2*sin(theta)^4*k11_m*C44_m^2 + 2*cos(phi)^3*sin(phi)^3*sin(theta)^6*C11_m*e15_m^2 + 2*cos(phi)^3*sin(phi)^3*sin(theta)^6*C12_m*e15_m^2)*(- cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C33_m*C44_m*k33_m + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m^2*e33_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m^2*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C44_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*e15_m*e33_m*C11_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C44_m*k11_m*C11_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C44_m*k11_m*C11_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*k11_m*C13_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C33_m*k11_m*C11_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*k33_m*C13_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*k11_m*C44_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*k11_m*C44_m^2 - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m*k11_m*C13_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C33_m*k33_m*C11_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*k11_m*C44_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*k33_m*C44_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C44_m*k33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*k33_m*C44_m^2 - 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C44_m*k33_m*C13_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(phi)^4*cos(theta)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*e15_m^2 - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*e15_m^2 - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*e15_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C12_m*e33_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e15_m^2 - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e31_m^2 - cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C44_m*e31_m^2 - cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C44_m*e31_m^2 + 3*cos(theta)^6*sin(phi)^2*sin(theta)^2*C11_m*C44_m*e33_m^2 - cos(theta)^6*sin(phi)^2*sin(theta)^2*C12_m*C44_m*e33_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m^2 + 2*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e31_m^2 - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 4*cos(theta)^4*sin(phi)^4*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C13_m*C44_m*e31_m*e33_m + 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*C33_m*C44_m*e15_m*e31_m - sin(phi)^8*sin(theta)^8*C11_m*C12_m*C44_m*k11_m + cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(phi)^2*cos(theta)^6*sin(theta)^2*e31_m*e33_m*C44_m^2 + 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m^2*e15_m^2 + 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m^2*e15_m^2 + 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m^2*e15_m^2 + cos(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 + cos(theta)^4*sin(phi)^4*sin(theta)^4*C11_m^2*e33_m^2 + 2*cos(theta)^4*sin(phi)^4*sin(theta)^4*C44_m^2*e31_m^2 + 2*cos(theta)^2*sin(phi)^6*sin(theta)^6*e15_m*e33_m*C11_m^2 - 4*cos(theta)^6*sin(phi)^2*sin(theta)^2*e31_m*e33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C44_m*k11_m*C11_m^2 - cos(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 - sin(phi)^8*sin(theta)^8*C11_m*C12_m*e15_m^2 + cos(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 + 2*cos(theta)^8*C33_m*k33_m*C44_m^2 + sin(phi)^8*sin(theta)^8*C11_m^2*e15_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*C44_m*k11_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*C44_m*k11_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 6*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 2*cos(theta)^8*C44_m^2*e33_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C13_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*k11_m*C13_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C33_m*k11_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C33_m*k11_m*C11_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*k33_m*C13_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*k11_m*C44_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*k11_m*C44_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*k11_m*C44_m^2 - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C44_m*k11_m*C13_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C33_m*k33_m*C11_m^2 + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*k33_m*C44_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C44_m*k33_m*C11_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C44_m*k33_m*C11_m^2 - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m^2 - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C12_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m^2 + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e15_m^2 + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e15_m^2 - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e31_m^2 - 2*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e31_m^2 + 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*e31_m^2 + 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C44_m*e31_m^2 - 3*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C44_m*e31_m^2 - 3*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C44_m*e31_m^2 - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C33_m*k11_m - 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C13_m*C44_m*k11_m + 2*cos(phi)^6*cos(theta)^2*sin(theta)^6*C12_m*C13_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C12_m*C33_m*k33_m + 3*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C33_m*C44_m*k11_m - cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C33_m*C44_m*k11_m - cos(phi)^6*cos(theta)^2*sin(theta)^6*C11_m*C12_m*C44_m*k33_m - 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C11_m*C13_m*C44_m*k33_m + 2*cos(phi)^4*cos(theta)^4*sin(theta)^4*C12_m*C13_m*C44_m*k33_m + 3*cos(phi)^2*cos(theta)^6*sin(theta)^2*C11_m*C33_m*C44_m*k33_m - cos(phi)^2*cos(theta)^6*sin(theta)^2*C12_m*C33_m*C44_m*k33_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C13_m*e15_m*e31_m - 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^2*cos(theta)^2*sin(phi)^4*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C11_m*C12_m*e15_m*e33_m + 6*cos(phi)^4*cos(theta)^2*sin(phi)^2*sin(theta)^6*C12_m*C13_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e15_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C13_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C33_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C33_m*e15_m*e31_m + 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e15_m*e33_m - 8*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C13_m*C44_m*e15_m*e31_m - 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C11_m*C44_m*e31_m*e33_m + 4*cos(phi)^2*cos(theta)^4*sin(phi)^2*sin(theta)^4*C12_m*C44_m*e31_m*e33_m - 4*cos(phi)^2*sin(phi)^6*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 6*cos(phi)^4*sin(phi)^4*sin(theta)^8*C11_m*C12_m*C44_m*k11_m - 4*cos(phi)^6*sin(phi)^2*sin(theta)^8*C11_m*C12_m*C44_m*k11_m)^-1
G1212 = matlabFunction(i1212,'vars',[theta,phi])
I1212 = integral2(G1212,0,pi,0,2*pi)
I1221 = I1212;
I2112 = I1212;
I2121 = I1212;
%
i1313 = -cos(phi)*cos(theta)*sin(theta)*beta*(cos(theta)*cos(phi)^3*sin(theta)^3*e15_m^2 + cos(theta)*cos(phi)^3*sin(theta)^3*e15_m*e31_m + cos(phi)*cos(theta)*sin(phi)^2*sin(theta)^3*e15_m^2 + cos(phi)*sin(theta)*cos(theta)^3*C13_m*k33_m + cos(phi)*sin(theta)*cos(theta)^3*C44_m*k33_m + cos(phi)*cos(theta)*sin(phi)^2*sin(theta)^3*e15_m*e31_m + cos(phi)*sin(theta)*cos(theta)^3*e15_m*e33_m + cos(phi)*sin(theta)*cos(theta)^3*e31_m*e33_m + cos(theta)*cos(phi)^3*sin(theta)^3*C13_m*k11_m + cos(theta)*cos(phi)^3*sin(theta)^3*C44_m*k11_m + cos(phi)*cos(theta)*sin(phi)^2*sin(theta)^3*C13_m*k11_m + cos(phi)*cos(theta)*sin(phi)^2*sin(theta)^3*C44_m*k11_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1
G1313 = matlabFunction(i1313,'vars',[theta,phi])
I1313 = integral2(G1313,0,pi,0,2*pi)
I1331 = I1313;
I3113 = I1313;
I3131 = I1313;
%
i1314 = -(cos(phi)*cos(theta)*sin(phi)^2*sin(theta)^3*C13_m*e15_m - cos(phi)*cos(theta)*sin(phi)^2*sin(theta)^3*C44_m*e31_m + cos(phi)*sin(theta)*cos(theta)^3*C13_m*e33_m - cos(phi)*sin(theta)*cos(theta)^3*C33_m*e15_m - cos(phi)*sin(theta)*cos(theta)^3*C33_m*e31_m + cos(phi)*sin(theta)*cos(theta)^3*C44_m*e33_m + cos(theta)*cos(phi)^3*sin(theta)^3*C13_m*e15_m - cos(theta)*cos(phi)^3*sin(theta)^3*C44_m*e31_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1*cos(phi)*cos(theta)*sin(theta)*beta
% G1314 = matlabFunction(i1314,'vars',[theta,phi])
% I1314 = integral2(G1314,0,pi,0,2*pi)
I1314 = 0;
I1341 = I1314;
I3114 = I1314;
I3141 = I1314;
%
i2323 = -(cos(theta)*sin(phi)^3*sin(theta)^3*e15_m^2 + cos(theta)*sin(phi)^3*sin(theta)^3*e15_m*e31_m + cos(theta)*sin(phi)*cos(phi)^2*sin(theta)^3*e15_m^2 + cos(theta)*sin(phi)*cos(phi)^2*sin(theta)^3*e15_m*e31_m + sin(phi)*sin(theta)*cos(theta)^3*C13_m*k33_m + sin(phi)*sin(theta)*cos(theta)^3*C44_m*k33_m + sin(phi)*sin(theta)*cos(theta)^3*e15_m*e33_m + sin(phi)*sin(theta)*cos(theta)^3*e31_m*e33_m + cos(theta)*sin(phi)^3*sin(theta)^3*C13_m*k11_m + cos(theta)*sin(phi)^3*sin(theta)^3*C44_m*k11_m + cos(theta)*sin(phi)*cos(phi)^2*sin(theta)^3*C13_m*k11_m + cos(theta)*sin(phi)*cos(phi)^2*sin(theta)^3*C44_m*k11_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1*cos(theta)*sin(phi)*sin(theta)*alpha*beta
G2323 = matlabFunction(i2323,'vars',[theta,phi])
I2323 = integral2(G2323,0,pi,0,2*pi)
I2332 = I2323;
I3223 = I2323;
I3232 = I2323;
%
i2324 = -(cos(theta)*sin(phi)*cos(phi)^2*sin(theta)^3*C13_m*e15_m - cos(theta)*sin(phi)*cos(phi)^2*sin(theta)^3*C44_m*e31_m + sin(phi)*sin(theta)*cos(theta)^3*C13_m*e33_m - sin(phi)*sin(theta)*cos(theta)^3*C33_m*e15_m - sin(phi)*sin(theta)*cos(theta)^3*C33_m*e31_m + sin(phi)*sin(theta)*cos(theta)^3*C44_m*e33_m + cos(theta)*sin(phi)^3*sin(theta)^3*C13_m*e15_m - cos(theta)*sin(phi)^3*sin(theta)^3*C44_m*e31_m)*(sin(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m + cos(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C33_m*C44_m*k33_m + sin(phi)^6*sin(theta)^6*C11_m*e15_m^2 + cos(theta)^6*C44_m*e33_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C33_m*k11_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*C44_m*k11_m + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*k11_m*C13_m^2 - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m^2 + 2*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C44_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*C44_m*k11_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*C33_m*k33_m + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*C44_m*k11_m + cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*C44_m*k33_m + 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C11_m*e15_m*e33_m - 4*cos(phi)^2*cos(theta)^2*sin(phi)^2*sin(theta)^4*C13_m*e15_m*e31_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*C44_m*k11_m + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C33_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*C44_m*k11_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*C33_m*k33_m + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*C44_m*k11_m + cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*C44_m*k33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*C44_m*k33_m - cos(phi)^4*cos(theta)^2*sin(theta)^4*k11_m*C13_m^2 - cos(phi)^2*cos(theta)^4*sin(theta)^2*k33_m*C13_m^2 - cos(theta)^2*sin(phi)^4*sin(theta)^4*k11_m*C13_m^2 - cos(theta)^4*sin(phi)^2*sin(theta)^2*k33_m*C13_m^2 - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C11_m*e33_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m^2 + cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e31_m^2 + cos(phi)^4*cos(theta)^2*sin(theta)^4*C44_m*e31_m^2 + 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(phi)^4*cos(theta)^2*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(phi)^2*cos(theta)^4*sin(theta)^2*C44_m*e31_m*e33_m + 3*cos(phi)^2*sin(phi)^4*sin(theta)^6*C11_m*e15_m^2 + 3*cos(phi)^4*sin(phi)^2*sin(theta)^6*C11_m*e15_m^2 + cos(phi)^6*sin(theta)^6*C11_m*C44_m*k11_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C11_m*e33_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m^2 + cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e31_m^2 + cos(theta)^2*sin(phi)^4*sin(theta)^4*C44_m*e31_m^2 + 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C11_m*e15_m*e33_m - 2*cos(theta)^2*sin(phi)^4*sin(theta)^4*C13_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e15_m*e33_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C13_m*e31_m*e33_m + 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C33_m*e15_m*e31_m - 2*cos(theta)^4*sin(phi)^2*sin(theta)^2*C44_m*e31_m*e33_m)^-1*cos(theta)*sin(phi)*sin(theta)*alpha*beta
% G2324 = matlabFunction(i2324,'vars',[theta,phi])
% I2324 = integral2(G2324,0,pi,0,2*pi)
I2324 = 0;
I2342 = I2324;
I3224 = I2324;
I3242 = I2324;
%
S = zeros(9); % Initialize the 9 x 9 Eshelby-type constraint matrix
S1111=(1/(4*pi))*(C11_m*I1111+C12_m*I1212+C13_m*I1313+e31_m*I1314);
S2222=S1111;
S(1,1)=S1111;
S(2,2)=S2222;
%
S1122=(1/(4*pi))*(C12_m*I1111+C11_m*I1212+C13_m*I1313+e31_m*I1314);
S2211=S1122;
S(1,2)=S1122;
S(2,1)=S2211;
%
S1133=(1/(4*pi))*(C13_m*(I1111+I1212)+C33_m*I1313+e33_m*I1314);
S2233=S1133;
S(1,3)=S1133;
S(2,3)=S2233;
%
S1143=(1/(4*pi))*(e31_m*(I1111+I1212)+e33_m*I1313-k33_m*I1314);
S2243=S1143;
S(1,9)=S1143;
S(2,9)=S2243;
%
S1212=(1/8*pi)*(C11_m-C12_m)*(I1122+I1212);
S1221=S1212;
S2112=S1212;
S2121=S1212;
S(6,6)=S1212;
%
S1313=(1/(8*pi))*(C44_m*(I1133+I3311+2*I1313)+e15_m*(I1134+I1314));
S1331=S1313;
S3113=S1313;
S3131=S1313;
S2323=S1313;
S2332=S1313;
S3223=S1313;
S3232=S1313;
S(5,5)=S1313;
S(4,4)=S2323;
%
S1341=(1/(8*pi))*(e15_m*(I1133+I3311+2*I1313)-k11_m*(I1134+I1314));
S3141=S1341;
S2342=S1341;
S3242=S1341;
S(5,7)=S1341;
S(4,8)=S2342;
%
S3311=(1/(4*pi))*(C11_m*I1313+C12_m*I2323+C13_m*I3333+e31_m*I3334);
S3322=S3311;
S(3,1)=S3311;
S(3,2)=S3322;
%
S3333=(1/(4*pi))*(C13_m*(I1313+I2323)+C33_m*I3333+e33_m*I3334);
S(3,3)=S3333;
%
S3343=(1/(4*pi))*(e31_m*(I1313+I2323)+e33_m*I3333-k33_m*I3334);
S(3,9)=S3343;
%
S4113=(1/(4*pi))*(C44_m*(I1134+I1314)+e15_m*I1144);
S4131=S4113;
S4223=S4113;
S4322=S4113;
S(7,5)=S4113;
S(8,4)=S4223;
S(9,2)=S4322;
%
S4141=(1/(4*pi))*(e15_m*(I1134+I1314)-k11_m*I1144);
S4242=S4141;
S(7,7)=S4141;
S(8,8)=S4242;
%
S4311=(1/(4*pi))*(C11_m*I1314+C12_m*I2324+C13_m*I3334+e31_m*I3344);
S4322=S4311;
S(9,1)=S4311;
S(9,2)=S4322;
%
S4333=(1/(4*pi))*(C13_m*(I1314+I2324)+C33_m*I3334+e33_m*I3344);
S(9,3)=S4333;
%
S4343=(1/(4*pi))*(e31_m*(I1314+I2324)+e33_m*I3334-k33_m*I3344);
S(9,9)=S4343;
%% Calculation of effective properties of unidirectional ESO/BTO composite i.e. without PANI
% (major axis of ellipsoid aligned along x3 direction) 
I = eye(9);
A_dil_no_intrfc=inv(I+S*inv(E_m)*(E_f-E_m));
for c3 = 0.001:0.01:0.6
    c1 = 1-c3;
    c2 = 0;
    A_Eshelby=A_dil_no_intrfc*(inv((1-c3)*I + c3*A_dil_no_intrfc));
    E_composite_no_intrfc=E_m + c3*(E_f-E_m)*A_Eshelby;
    C11_no_intrfc= E_composite_no_intrfc(1,1);
    C12_no_intrfc= E_composite_no_intrfc(1,2);
    C13_no_intrfc = E_composite_no_intrfc(1,3);
    C21_no_intrfc = E_composite_no_intrfc(2,1);
    C22_no_intrfc = E_composite_no_intrfc(2,2);
    C23_no_intrfc = E_composite_no_intrfc(2,3);
    C31_no_intrfc = E_composite_no_intrfc(3,1);
    C32_no_intrfc = E_composite_no_intrfc(3,2);
    C33_no_intrfc = E_composite_no_intrfc(3,3);
    C44_no_intrfc = E_composite_no_intrfc(4,4);
    C55_no_intrfc = E_composite_no_intrfc(5,5);
    C66_no_intrfc = E_composite_no_intrfc(6,6);

    e15_no_intrfc=E_composite_no_intrfc(7,5);
    e24_no_intrfc=E_composite_no_intrfc(8,4);
    e31_no_intrfc=E_composite_no_intrfc(9,1);
    e32_no_intrfc=E_composite_no_intrfc(9,2);
    e33_no_intrfc=E_composite_no_intrfc(9,3);
    Cmatrix_no_intrfc  = [C11_no_intrfc C12_no_intrfc C13_no_intrfc 0 0 0;
                   C21_no_intrfc C22_no_intrfc C23_no_intrfc 0 0 0;
                   C31_no_intrfc C32_no_intrfc C33_no_intrfc 0 0 0;
                   0 0 0 C44_no_intrfc 0 0;
                   0 0 0 0 C55_no_intrfc 0;
                   0 0 0 0 0 C66_no_intrfc];
    Smatrix_no_intrfc = inv(Cmatrix_no_intrfc);
    ematrix_no_intrfc = [0 0 0 0 e15_no_intrfc 0;
                      0 0 0 e24_no_intrfc 0 0;
                      e31_no_intrfc e32_no_intrfc e33_no_intrfc 0 0 0];
    dmatrix_no_intrfc = ematrix_no_intrfc*Smatrix_no_intrfc;
    E1_composite_no_intrfc=(1/(Smatrix_no_intrfc(1,1)));
    E2_composite_no_intrfc=(1/(Smatrix_no_intrfc(2,2)));
    E3_composite_no_intrfc=(1/(Smatrix_no_intrfc(3,3)));
    % 
    G23_no_intrfc=(1/(Smatrix_no_intrfc(4,4)));
    G13_no_intrfc=(1/(Smatrix_no_intrfc(5,5)));
    G12_no_intrfc=(1/(Smatrix_no_intrfc(6,6)));

    nu12_no_intrfc=-(E1_composite_no_intrfc*Smatrix_no_intrfc(1,2));
    nu13_no_intrfc=-(E1_composite_no_intrfc*Smatrix_no_intrfc(1,3));
    nu23_no_intrfc=-(E2_composite_no_intrfc*Smatrix_no_intrfc(2,3));

    k11_no_intrfc=-E_composite_no_intrfc(7,7);
    k22_no_intrfc=-E_composite_no_intrfc(8,8);
    k33_no_intrfc=-E_composite_no_intrfc(9,9);

    d15_no_intrfc=(dmatrix_no_intrfc(1,5)/(1e-12))/(1e9);
    d24_no_intrfc=(dmatrix_no_intrfc(2,4)/(1e-12))/(1e9);
    d31_no_intrfc=(dmatrix_no_intrfc(3,1)/(1e-12))/(1e9);
    d32_no_intrfc=(dmatrix_no_intrfc(3,2)/(1e-12))/(1e9);
    d33_no_intrfc=(dmatrix_no_intrfc(3,3)/(1e-12))/(1e9);
    %
    fprintf(fileID5,'%f\t %f\t %f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', c1, c2, c3, E1_composite_no_intrfc, E2_composite_no_intrfc, E3_composite_no_intrfc, G23_no_intrfc, G13_no_intrfc, G12_no_intrfc, nu23_no_intrfc, nu13_no_intrfc, nu12_no_intrfc, d31_no_intrfc, d32_no_intrfc, d33_no_intrfc, d15_no_intrfc, d24_no_intrfc, k11_no_intrfc,k22_no_intrfc,k33_no_intrfc);
    fprintf(fileID6,'%f\t %f\t %f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', c1, c2, c3, C11_no_intrfc, C12_no_intrfc, C13_no_intrfc, C22_no_intrfc, C23_no_intrfc, C33_no_intrfc, C44_no_intrfc, C55_no_intrfc, C66_no_intrfc, e31_no_intrfc, e32_no_intrfc, e33_no_intrfc, e15_no_intrfc, e24_no_intrfc, k11_no_intrfc,k22_no_intrfc,k33_no_intrfc);
    %
end
disp("Properties of unidirectional ESO/BTO composite with no interface calculated.")
fclose(fileID5);
fclose(fileID6);
%% Calculation  of the effective electroelastic modulus matrix
% Calculations are primarily based on the paper by Dunn and Ledbetter, 
% Elastic Moduli of Composites Reinforced by Multiphase Particles, Journal
% of Applied Mechanics (1995), volume 62, 1023 -1028
a = 100; % RVE cube dimension, Units nm
t = 7.5; % Thickness of interface layer, Units nm
%I = eye(9);
deltaS = zeros(9) ; % Since the particles are coaxial multiphase
E3 = (inv(E_f - E_m))*E_m;
E2 = (inv(E_i - E_m))*E_m;
%
% Defining rotation matrices for calculation of properties of composites
% with randomly aligned inclusions
% Calculation of randomly oriented piezoelectric composite 
% Follows the procedure in the paper by Kuo and Huang 
% Int. J. Solid Strucrures Vol. 34, No. 19, pp. 2445 -2461, 1997
syms THETA PHI OMEGA
%Euler angles 
m = cos(THETA);
n = sin(THETA);
p = cos(PHI);
q = sin(PHI);
r = cos(OMEGA);
s = sin(OMEGA);
A=[m*p*r-n*s, n*p*r+m*s, -q*r;
-m*p*s-n*r ,m*r-n*p*s ,q*s;
m*q, n*q, p;];
%
A_T = transpose(A);
%
M = [A(1,1)^2, A(1,2)^2, A(1,3)^2, 2*A(1,2)*A(1,3), 2*A(1,3)*A(1,1), 2*A(1,1)*A(1,2);
A(2,1)^2, A(2,2)^2, A(2,3)^2, 2*A(2,2)*A(2,3), 2*A(2,3)*A(2,1), 2*A(2,1)*A(2,2);
A(3,1)^2, A(3,2)^2, A(3,3)^2, 2*A(3,2)*A(3,3), 2*A(3,3)*A(3,1), 2*A(3,1)*A(3,2);	 
A(2,1)*A(3,1), A(2,2)*A(3,2), A(2,3)*A(3,3), A(2,2)*A(3,3) + A(2,3)*A(3,2), A(1,2)*A(3,3) + A(2,3)*A(3,1), A(2,2)*A(3,1) + A(2,1)*A(3,2);
A(3,1)*A(1,1), A(3,2)*A(1,2), A(3,3)*A(1,3), A(1,2)*A(3,3) + A(1,3)*A(3,2), A(1,3)*A(3,1) + A(1,1)*A(3,3), A(1,1)*A(3,2) + A(1,2)*A(3,1);
A(1,1)*A(2,1), A(1,2)*A(2,2), A(1,3)*A(2,3), A(1,2)*A(2,3) + A(1,3)*A(2,2), A(1,3)*A(2,1) + A(1,1)*A(2,3), A(1,1)*A(2,2) + A(1,2)*A(2,1);];
%
M_T = transpose(M);
%
for c3 = 0.001:0.01:0.6 % volume fraction of the inner core
    aa1 = zeros(9); % Initialize variable
    bb1 = zeros(9); % Initialize variable
    aa2 = zeros(9); % Initialize variable
    bb2 = zeros(9); % Initialize variable
    phi2 = zeros(9); % Initialize variable
    phi3 = zeros(9); % Initialize variable
    phi23 = zeros(9); % Initialize variable
    A3_di = zeros(9);
    A2_di = zeros(9);
    A23_di = zeros(9);
    r = ((3*c3*(a^3))/(4*aspect_ratio*pi))^(1/3); % radius of the ellipsoid
    h = aspect_ratio*r; % semi-major axis of the outer ellipsoid with interface
    c = ((4/3)*pi*((r+t)^2)*(h+t))/(a^3); % core-shell volume fraction 
    c2 = c-c3; % volume fraction of the outer shell
    c1 = 1 - c2 - c3; % volume fraction of the matrix
    aa1 = S - ((c3/c2)*deltaS) + E3;
    bb1 = inv(aa1);
    aa2 = S - ((c3/c2)*deltaS) + E2;
    bb2 = inv(aa2);
    phi2 = -inv(deltaS +((S+E3)*bb1)*aa2);
    phi3 = -inv((S+E3) + (deltaS*bb2*aa1));
    phi23 = ((c3/(c2+c3))*phi3) + ((c2/(c2+c3))*phi2);
    A3_di = I + (deltaS*phi2) + (S*phi3); % Concentration factor.'di' denotes double inclusion in infinte matrix
    A2_di = I + ((S-((c3/c2)*deltaS))*phi2) + ((c3/c2)*deltaS*phi3);
    A23_di = I + (S*phi23);
    A3 = A3_di*(inv((c1*I) + ((c2+c3)*A23_di)));
    A23 = A23_di*(inv((c1*I) + ((c2+c3)*A23_di)));
    E_composite = E_m + ((c2 + c3)*((E_i-E_m)*A23)) + (c3*((E_f-E_i)*A3));
    %
    C11=E_composite(1,1);
    C12=E_composite(1,2);
    C13=E_composite(1,3);
    C21=E_composite(2,1);
    C22=E_composite(2,2);
    C23=E_composite(2,3);
    C31=E_composite(3,1);
    C32=E_composite(3,2);
    C33=E_composite(3,3);
    C44=E_composite(4,4);
    C55=E_composite(5,5);
    C66=E_composite(6,6);
    %
    e15=E_composite(7,5);
    e24=E_composite(8,4);
    e31=E_composite(9,1);
    e32=E_composite(9,2);
    e33=E_composite(9,3);
    Cmatrix(:,:)  = [C11 C12 C13 0 0 0;
                   C21 C22 C23 0 0 0;
                   C31 C32 C33 0 0 0;
                   0 0 0 C44 0 0;
                   0 0 0 0 C55 0;
                   0 0 0 0 0 C66];
    Smatrix(:,:) = inv(Cmatrix(:,:));
    ematrix(:,:) = [0 0 0 0 e15 0;
                      0 0 0 e24 0 0;
                      e31 e32 e33 0 0 0];
    dmatrix(:,:) = ematrix(:,:)*Smatrix(:,:);
    E1_composite=(1/(Smatrix(1,1)));
    E2_composite=(1/(Smatrix(2,2)));
    E3_composite=(1/(Smatrix(3,3)));
    % 
    G23=1/(Smatrix(4,4));
    G13=1/(Smatrix(5,5));
    G12=1/(Smatrix(6,6));
    %
    nu12=-(E1_composite*Smatrix(1,2));
    nu13=-(E1_composite*Smatrix(1,3));
    nu23=-(E2_composite*Smatrix(2,3));
    %
    k11=-E_composite(7,7);
    k22=-E_composite(8,8);
    k33=-E_composite(9,9);
    %
    d15=(dmatrix(1,5)/(1e-12))/(10^9);
    d24=(dmatrix(2,4)/(1e-12))/(10^9);
    d31=(dmatrix(3,1)/(1e-12))/(10^9);
    d32=(dmatrix(3,2)/(1e-12))/(10^9);
    d33=(dmatrix(3,3)/(1e-12))/(10^9);
    %
    fprintf(fileID1,'%f\t %f\t %f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', c1, c2, c3, E1_composite, E2_composite, E3_composite, G23, G13, G12, nu23, nu13, nu12, d31, d32, d33, d15, d24, k11,k22,k33);
    fprintf(fileID2,'%f\t %f\t %f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', c1, c2, c3, C11, C12, C13, C22, C23, C33, C44, C55, C66, e31, e32, e33, e15, e24, k11,k22,k33);
    %
end
fclose(fileID1);
fclose(fileID2);
disp('Properties of unidirectional ESO/BTO(PANI) double inclusion composite completed.')
%% Calculation of randomly oriented ESO/BTO(PANI) piezoelectric composite 
% Follows the procedure in the paper by Kuo and Huang 
% Int. J. Solid Strucrures Vol. 34, No. 19, pp. 2445 -2461, 1997
% and
% J. H. Huang and W.-S. Kuo, “Micromechanics determination of the 
% effective properties of piezoelectric composites containing 
% spatially-oriented short fibers,” Acta Mater., 44, No. 12, 4889–4898 
% (1996).
iteration = 1;
disp('Calculation of properties of randomly oriented ESO/BTO(PANI) composite started.')
for c3 = 0.001:0.01:0.6 % volume fraction of the inner core
    aa1 = zeros(9); % Initialize variable
    bb1 = zeros(9); % Initialize variable
    aa2 = zeros(9); % Initialize variable
    bb2 = zeros(9); % Initialize variable
    phi2 = zeros(9); % Initialize variable
    phi3 = zeros(9); % Initialize variable
    phi23 = zeros(9); % Initialize variable
    A3_di = zeros(9);
    A2_di = zeros(9);
    A23_di = zeros(9);
    r = ((3*c3*(a^3))/(4*aspect_ratio*pi))^(1/3); % radius of the ellipsoid
    h = aspect_ratio*r; % semi-major axis of the outer ellipsoid with interface
    c = ((4/3)*pi*((r+t)^2)*(h+t))/(a^3); % core-shell volume fraction 
    c2 = c-c3; % volume fraction of the outer shell
    c1 = 1 - c2 - c3; % volume fraction of the matrix
    aa1 = S - ((c3/c2)*deltaS) + E3;
    bb1 = inv(aa1);
    aa2 = S - ((c3/c2)*deltaS) + E2;
    bb2 = inv(aa2);
    phi2 = -inv(deltaS +((S+E3)*bb1)*aa2);
    phi3 = -inv((S+E3) + (deltaS*bb2*aa1));
    phi23 = ((c3/(c2+c3))*phi3) + ((c2/(c2+c3))*phi2);
    A3_di = I + (deltaS*phi2) + (S*phi3); % Concentration factor.'di' denotes double inclusion in infinte matrix
    A2_di = I + ((S-((c3/c2)*deltaS))*phi2) + ((c3/c2)*deltaS*phi3);
    A23_di = I + (S*phi23);
    %
    A_dil =zeros(9);
    A_dil = A23_di;
    A_dil1=zeros;
    A_dil1(1,1)=A_dil(1,1);
    A_dil1(1,2)=A_dil(1,2);
    A_dil1(1,3)=A_dil(1,3);
    A_dil1(1,4)=A_dil(1,4);
    A_dil1(1,5)=A_dil(1,5);
    A_dil1(1,6)=A_dil(1,6);
    
    A_dil1(2,1)=A_dil(2,1);
    A_dil1(2,2)=A_dil(2,2);
    A_dil1(2,3)=A_dil(2,3);
    A_dil1(2,4)=A_dil(2,4);
    A_dil1(2,5)=A_dil(2,5);
    A_dil1(2,6)=A_dil(2,6);
    
    A_dil1(3,1)=A_dil(3,1);
    A_dil1(3,2)=A_dil(3,2);
    A_dil1(3,3)=A_dil(3,3);
    A_dil1(3,4)=A_dil(3,4);
    A_dil1(3,5)=A_dil(3,5);
    A_dil1(3,6)=A_dil(3,6);
    
    A_dil1(4,1)=A_dil(4,1);
    A_dil1(4,2)=A_dil(4,2);
    A_dil1(4,3)=A_dil(4,3);
    A_dil1(4,4)=A_dil(4,4);
    A_dil1(4,5)=A_dil(4,5);
    A_dil1(4,6)=A_dil(4,6);
    
    A_dil1(5,1)=A_dil(5,1);
    A_dil1(5,2)=A_dil(5,2);
    A_dil1(5,3)=A_dil(5,3);
    A_dil1(5,3)=A_dil(5,4);
    A_dil1(5,5)=A_dil(5,5);
    A_dil1(5,6)=A_dil(5,6);


    A_dil1(6,1)=A_dil(6,1);
    A_dil1(6,2)=A_dil(6,2);
    A_dil1(6,3)=A_dil(6,3);
    A_dil1(6,4)=A_dil(6,4);
    A_dil1(6,5)=A_dil(6,5);
    A_dil1(6,6)=A_dil(6,6);

    A_dil1_rotated = M * A_dil1 * M_T; 

    BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
    BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
    %finding the average of components integral
    A_dil1_avg = zeros(6,6);
    for ii=1:6
        for jj=1:6
            if  A_dil1_rotated(ii,jj)~=0
                A_temp = matlabFunction(A_dil1_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
                A_dil1_avg(ii,jj)=(integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
%     			temp10 = ['A(',num2str(ii),',',num2str(jj),')']
%     			fprintf(fileID10,'%s \t',temp10);
%     			fprintf(fileID10,'%12.20f\n',A_dil1_avg(ii,jj));
            end
        end
    end
%
    A_dil1_rotated = M * A_dil1 * M_T; 
%
%
    A_dil2=zeros;
    A_dil2(1,1)=A_dil(1,7);
    A_dil2(1,2)=A_dil(1,8);
    A_dil2(1,3)=A_dil(1,9);

    A_dil2(2,1)=A_dil(2,7);
    A_dil2(2,2)=A_dil(2,8);
    A_dil2(2,3)=A_dil(2,9);

    A_dil2(3,1)=A_dil(3,7);
    A_dil2(3,2)=A_dil(3,8);
    A_dil2(3,3)=A_dil(3,9);

    A_dil2(4,1)=A_dil(4,7);
    A_dil2(4,2)=A_dil(4,8);
    A_dil2(4,3)=A_dil(4,9);

    A_dil2(5,1)=A_dil(5,7);
    A_dil2(5,2)=A_dil(5,8);
    A_dil2(5,3)=A_dil(5,9);

    A_dil2(6,1)=A_dil(6,7);
    A_dil2(6,2)=A_dil(6,8);
    A_dil2(6,3)=A_dil(6,9);


    A_dil2_rotated = M * A_dil2 * A_T;
    BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
    BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
    %finding the average of components integral
    A_dil2_avg = zeros(6,3);
    for ii=1:6
        for jj=1:3
            if  A_dil2_rotated(ii,jj)~=0
                A_temp = matlabFunction(A_dil2_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
                A_dil2_avg(ii,jj)=(integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
%     			temp11 = ['A_avg(',num2str(ii),',',num2str(jj),')']
%     			fprintf(fileID11,'%s \t',temp11);
%     			fprintf(fileID11,'%12.20f\n',A_dil2_avg(ii,jj));

            end
        end
    end
    A_dil3=zeros;
%
    A_dil3(1,1)=A_dil(7,1);
    A_dil3(1,2)=A_dil(7,2);
    A_dil3(1,3)=A_dil(7,3);
    A_dil3(1,4)=A_dil(7,4);
    A_dil3(1,5)=A_dil(7,5);
    A_dil3(1,6)=A_dil(7,6);
%
    A_dil3(2,1)=A_dil(8,1);
    A_dil3(2,2)=A_dil(8,2);
    A_dil3(2,3)=A_dil(8,3);
    A_dil3(2,4)=A_dil(8,4);
    A_dil3(2,5)=A_dil(8,5);
    A_dil3(2,6)=A_dil(8,6);
%
    A_dil3(3,1)=A_dil(9,1);
    A_dil3(3,2)=A_dil(9,2);
    A_dil3(3,3)=A_dil(9,3);
    A_dil3(3,4)=A_dil(9,4);
    A_dil3(3,5)=A_dil(9,5);
    A_dil3(3,6)=A_dil(9,6);
%
    A_dil3_rotated = A * A_dil3 * M_T;
%
    BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
    BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
    %finding the average of components integral
    A_dil3_avg = zeros(3,6);
    for ii=1:3
        for jj=1:6
            if  A_dil3_rotated(ii,jj)~=0
                A_temp = matlabFunction(A_dil3_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
                A_dil3_avg(ii,jj)= (integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
% 			temp12 = ['A_avg(',num2str(ii),',',num2str(jj),')'];
% 			fprintf(fileID12,'%s \t',temp12);
% 			fprintf(fileID12,'%12.20f\n',A_dil3_avg(ii,jj));
            end
        end
    end 
    A_dil4=zeros;
    A_dil4(1,1)=A_dil(7,7);
    A_dil4(1,2)=A_dil(7,8);
    A_dil4(1,3)=A_dil(7,9);

    A_dil4(2,1)=A_dil(8,7);
    A_dil4(2,2)=A_dil(8,8);
    A_dil4(2,3)=A_dil(8,9);

    A_dil4(3,1)=A_dil(9,7);
    A_dil4(3,2)=A_dil(9,8);
    A_dil4(3,3)=A_dil(9,9);

    A_dil4_rotated = A * A_dil4 * A_T;
    %
    BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
    BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
    %finding the average of components integral
    A_dil4_avg = zeros(3,3);
    for ii=1:3
        for jj=1:3
            if  A_dil4_rotated(ii,jj)~=0
                A_temp = matlabFunction(A_dil4_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
                A_dil4_avg(ii,jj)=(integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
% 			temp13 = ['A_avg(',num2str(ii),',',num2str(jj),')']
% 			fprintf(fileID13,'%s \t',temp13);
% 			fprintf(fileID13,'%12.20f\n',A_dil4_avg(ii,jj));
            end
        end
    end
    A23_di_avg = [A_dil1_avg(1,1), A_dil1_avg(1,2),A_dil1_avg(1,3),A_dil1_avg(1,4),A_dil1_avg(1,5),A_dil1_avg(1,6),A_dil2_avg(1,1), A_dil2_avg(1,2),A_dil2_avg(1,3);
	              A_dil1_avg(2,1), A_dil1_avg(2,2),A_dil1_avg(2,3),A_dil1_avg(2,4),A_dil1_avg(2,5),A_dil1_avg(2,6),A_dil2_avg(2,1), A_dil2_avg(2,2),A_dil2_avg(2,3);
	              A_dil1_avg(3,1), A_dil1_avg(3,2),A_dil1_avg(3,3),A_dil1_avg(3,4),A_dil1_avg(3,5),A_dil1_avg(3,6),A_dil2_avg(3,1), A_dil2_avg(3,2),A_dil2_avg(3,3);
	              A_dil1_avg(4,1), A_dil1_avg(4,2),A_dil1_avg(4,3),A_dil1_avg(4,4),A_dil1_avg(4,5),A_dil1_avg(4,6),A_dil2_avg(4,1), A_dil2_avg(4,2),A_dil2_avg(4,3);
	              A_dil1_avg(5,1), A_dil1_avg(5,2),A_dil1_avg(5,3),A_dil1_avg(5,4),A_dil1_avg(5,5),A_dil1_avg(5,6),A_dil2_avg(5,1), A_dil2_avg(5,2),A_dil2_avg(5,3);
	              A_dil1_avg(6,1), A_dil1_avg(6,2),A_dil1_avg(6,3),A_dil1_avg(6,4),A_dil1_avg(6,5),A_dil1_avg(6,6),A_dil2_avg(6,1), A_dil2_avg(6,2),A_dil2_avg(6,3);
	              A_dil3_avg(1,1),A_dil3_avg(1,2),A_dil3_avg(1,3),A_dil3_avg(1,4),A_dil3_avg(1,5),A_dil3_avg(1,6),A_dil4_avg(1,1),A_dil4_avg(1,2),A_dil4_avg(1,3);
	              A_dil3_avg(2,1),A_dil3_avg(2,2),A_dil3_avg(2,3),A_dil3_avg(2,4),A_dil3_avg(2,5),A_dil3_avg(2,6),A_dil4_avg(2,1),A_dil4_avg(2,2),A_dil4_avg(2,3);
	              A_dil3_avg(3,1),A_dil3_avg(3,2),A_dil3_avg(3,3),A_dil3_avg(3,4),A_dil3_avg(3,5),A_dil3_avg(3,6),A_dil4_avg(3,1),A_dil4_avg(3,2),A_dil4_avg(3,3);];

    A3_avg = zeros(9);
    A3_avg = A3_di*(inv((c1*I) + ((c2+c3)*A23_di_avg)));
    A23_avg = zeros(9);
    A23_avg = A23_di*(inv((c1*I) + ((c2+c3)*A23_di_avg)));
    E_composite_avg = zeros(9);
    E_composite_avg = E_m + ((c2 + c3)*((E_i-E_m)*A23_avg)) + (c3*((E_f-E_i)*A3_avg)); 

    C11_avg = E_composite_avg(1,1);
    C12_avg = E_composite_avg(1,2);
    C13_avg = E_composite_avg(1,3);
    C21_avg = E_composite_avg(2,1);
    C22_avg = E_composite_avg(2,2);
    C23_avg = E_composite_avg(2,3);
    C31_avg = E_composite_avg(3,1);
    C32_avg = E_composite_avg(3,2);
    C33_avg = E_composite_avg(3,3);
    C44_avg = E_composite_avg(4,4);
    C55_avg = E_composite_avg(5,5);
    C66_avg = E_composite_avg(6,6);

    e15_avg=E_composite_avg(7,5);
    e24_avg=E_composite_avg(8,4);
    e31_avg=E_composite_avg(9,1);
    e32_avg=E_composite_avg(9,2);
    e33_avg=E_composite_avg(9,3);
    Cmatrix_avg  = [C11_avg C12_avg C13_avg 0 0 0;
                   C21_avg C22_avg C23_avg 0 0 0;
                   C31_avg C32_avg C33_avg 0 0 0;
                   0 0 0 C44_avg 0 0;
                   0 0 0 0 C55_avg 0;
                   0 0 0 0 0 C66_avg];
    Smatrix_avg = inv(Cmatrix_avg);
    ematrix_avg = [0 0 0 0 e15_avg 0;
                      0 0 0 e24_avg 0 0;
                      e31_avg e32_avg e33_avg 0 0 0];
    dmatrix_avg = ematrix_avg*Smatrix_avg;
    E1_composite_avg=(1/(Smatrix_avg(1,1)));
    E2_composite_avg=(1/(Smatrix_avg(2,2)));
    E3_composite_avg=(1/(Smatrix_avg(3,3)));
    % 
    G23_avg=(1/(Smatrix_avg(4,4)));
    G13_avg=(1/(Smatrix_avg(5,5)));
    G12_avg=(1/(Smatrix_avg(6,6)));

    nu12_avg=-(E1_composite_avg*Smatrix_avg(1,2));
    nu13_avg=-(E1_composite_avg*Smatrix_avg(1,3));
    nu23_avg=-(E2_composite_avg*Smatrix_avg(2,3));

    k11_avg=-E_composite_avg(7,7);
    k22_avg=-E_composite_avg(8,8);
    k33_avg=-E_composite_avg(9,9);

    d15_avg=(dmatrix_avg(1,5)/(1e-12))/(1e9);
    d24_avg=(dmatrix_avg(2,4)/(1e-12))/(1e9);
    d31_avg=(dmatrix_avg(3,1)/(1e-12))/(1e9);
    d32_avg=(dmatrix_avg(3,2)/(1e-12))/(1e9);
    d33_avg=(dmatrix_avg(3,3)/(1e-12))/(1e9);
    %
    fprintf(fileID3,'%f\t %f\t %f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', c1, c2, c3, E1_composite_avg, E2_composite_avg, E3_composite_avg, G23_avg, G13_avg, G12_avg, nu23_avg, nu13_avg, nu12_avg, d31_avg, d32_avg, d33_avg, d15_avg, d24_avg, k11_avg,k22_avg,k33_avg);
    fprintf(fileID4,'%f\t %f\t %f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', c1, c2, c3, C11_avg, C12_avg, C13_avg, C22_avg, C23_avg, C33_avg, C44_avg, C55_avg, C66_avg, e31_avg, e32_avg, e33_avg, e15_avg, e24_avg, k11_avg,k22_avg,k33_avg);
    %

    fprintf('Iteration # %d completed.\n',iteration);
    iteration = iteration + 1;
end
fclose(fileID3);
fclose(fileID4);
disp('Properties of randomly-oriented ESO/BTO(PANI) double inclusion composite completed.')
%% Calculation of effective properties of randomly-oriented ESO/BTO composite i.e. without PANI
A_dil = zeros(9);
A_dil=A_dil_no_intrfc;
%
A_dil1=zeros;
A_dil1(1,1)=A_dil(1,1);
A_dil1(1,2)=A_dil(1,2);
A_dil1(1,3)=A_dil(1,3);
A_dil1(1,4)=A_dil(1,4);
A_dil1(1,5)=A_dil(1,5);
A_dil1(1,6)=A_dil(1,6);

A_dil1(2,1)=A_dil(2,1);
A_dil1(2,2)=A_dil(2,2);
A_dil1(2,3)=A_dil(2,3);
A_dil1(2,4)=A_dil(2,4);
A_dil1(2,5)=A_dil(2,5);
A_dil1(2,6)=A_dil(2,6);

A_dil1(3,1)=A_dil(3,1);
A_dil1(3,2)=A_dil(3,2);
A_dil1(3,3)=A_dil(3,3);
A_dil1(3,4)=A_dil(3,4);
A_dil1(3,5)=A_dil(3,5);
A_dil1(3,6)=A_dil(3,6);

A_dil1(4,1)=A_dil(4,1);
A_dil1(4,2)=A_dil(4,2);
A_dil1(4,3)=A_dil(4,3);
A_dil1(4,4)=A_dil(4,4);
A_dil1(4,5)=A_dil(4,5);
A_dil1(4,6)=A_dil(4,6);

A_dil1(5,1)=A_dil(5,1);
A_dil1(5,2)=A_dil(5,2);
A_dil1(5,3)=A_dil(5,3);
A_dil1(5,3)=A_dil(5,4);
A_dil1(5,5)=A_dil(5,5);
A_dil1(5,6)=A_dil(5,6);


A_dil1(6,1)=A_dil(6,1);
A_dil1(6,2)=A_dil(6,2);
A_dil1(6,3)=A_dil(6,3);
A_dil1(6,4)=A_dil(6,4);
A_dil1(6,5)=A_dil(6,5);
A_dil1(6,6)=A_dil(6,6);

A_dil1_rotated = M * A_dil1 * M_T; 

BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
%finding the average of components integral
 A_dil1_avg = zeros(6,6);
 for ii=1:6
    for jj=1:6
        if  A_dil1_rotated(ii,jj)~=0
            A_temp = matlabFunction(A_dil1_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
            A_dil1_avg(ii,jj)=(integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
% 			temp10 = ['A(',num2str(ii),',',num2str(jj),')']
% 			fprintf(fileID10,'%s \t',temp10);
% 			fprintf(fileID10,'%12.20f\n',A_dil1_avg(ii,jj));
						
        end
    end
 end 
%
A_dil2=zeros;
A_dil2(1,1)=A_dil(1,7);
A_dil2(1,2)=A_dil(1,8);
A_dil2(1,3)=A_dil(1,9);

A_dil2(2,1)=A_dil(2,7);
A_dil2(2,2)=A_dil(2,8);
A_dil2(2,3)=A_dil(2,9);

A_dil2(3,1)=A_dil(3,7);
A_dil2(3,2)=A_dil(3,8);
A_dil2(3,3)=A_dil(3,9);

A_dil2(4,1)=A_dil(4,7);
A_dil2(4,2)=A_dil(4,8);
A_dil2(4,3)=A_dil(4,9);

A_dil2(5,1)=A_dil(5,7);
A_dil2(5,2)=A_dil(5,8);
A_dil2(5,3)=A_dil(5,9);

A_dil2(6,1)=A_dil(6,7);
A_dil2(6,2)=A_dil(6,8);
A_dil2(6,3)=A_dil(6,9);

A_dil2_rotated = M * A_dil2 * A_T;

BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
%finding the average of components integral
 A_dil2_avg = zeros(6,3);
 for ii=1:6
    for jj=1:3
        if  A_dil2_rotated(ii,jj)~=0
            A_temp = matlabFunction(A_dil2_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
            A_dil2_avg(ii,jj)=(integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
% 			temp11 = ['A_avg(',num2str(ii),',',num2str(jj),')']
% 			fprintf(fileID11,'%s \t',temp11);
% 			fprintf(fileID11,'%12.20f\n',A_dil2_avg(ii,jj));	
		end
    end
 end 

A_dil3=zeros;

A_dil3(1,1)=A_dil(7,1);
A_dil3(1,2)=A_dil(7,2);
A_dil3(1,3)=A_dil(7,3);
A_dil3(1,4)=A_dil(7,4);
A_dil3(1,5)=A_dil(7,5);
A_dil3(1,6)=A_dil(7,6);

A_dil3(2,1)=A_dil(8,1);
A_dil3(2,2)=A_dil(8,2);
A_dil3(2,3)=A_dil(8,3);
A_dil3(2,4)=A_dil(8,4);
A_dil3(2,5)=A_dil(8,5);
A_dil3(2,6)=A_dil(8,6);

A_dil3(3,1)=A_dil(9,1);
A_dil3(3,2)=A_dil(9,2);
A_dil3(3,3)=A_dil(9,3);
A_dil3(3,4)=A_dil(9,4);
A_dil3(3,5)=A_dil(9,5);
A_dil3(3,6)=A_dil(9,6);

A_dil3_rotated = A * A_dil3 * M_T; 

BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
%finding the average of components integral
 A_dil3_avg = zeros(3,6);
 for ii=1:3
    for jj=1:6
        if  A_dil3_rotated(ii,jj)~=0
            A_temp = matlabFunction(A_dil3_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
            A_dil3_avg(ii,jj)= (integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
% 			temp12 = ['A_avg(',num2str(ii),',',num2str(jj),')'];
% 			fprintf(fileID12,'%s \t',temp12);
% 			fprintf(fileID12,'%12.20f\n',A_dil3_avg(ii,jj));
        end
    end
 end 
 
A_dil4=zeros;
A_dil4(1,1)=A_dil(7,7);
A_dil4(1,2)=A_dil(7,8);
A_dil4(1,3)=A_dil(7,9);

A_dil4(2,1)=A_dil(8,7);
A_dil4(2,2)=A_dil(8,8);
A_dil4(2,3)=A_dil(8,9);

A_dil4(3,1)=A_dil(9,7);
A_dil4(3,2)=A_dil(9,8);
A_dil4(3,3)=A_dil(9,9);

A_dil4_rotated = A * A_dil4 * A_T;

BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
%finding the average of components integral
 A_dil4_avg = zeros(3,3);
 for ii=1:3
    for jj=1:3
        if  A_dil4_rotated(ii,jj)~=0
            A_temp = matlabFunction(A_dil4_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
            A_dil4_avg(ii,jj)=(integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
% 			temp13 = ['A_avg(',num2str(ii),',',num2str(jj),')']
% 			fprintf(fileID13,'%s \t',temp13);
% 			fprintf(fileID13,'%12.20f\n',A_dil4_avg(ii,jj));
%             				
        end
    end
 end 

A_dil_avg = [A_dil1_avg(1,1), A_dil1_avg(1,2),A_dil1_avg(1,3),A_dil1_avg(1,4),A_dil1_avg(1,5),A_dil1_avg(1,6),A_dil2_avg(1,1), A_dil2_avg(1,2),A_dil2_avg(1,3);
	         A_dil1_avg(2,1), A_dil1_avg(2,2),A_dil1_avg(2,3),A_dil1_avg(2,4),A_dil1_avg(2,5),A_dil1_avg(2,6),A_dil2_avg(2,1), A_dil2_avg(2,2),A_dil2_avg(2,3);
	         A_dil1_avg(3,1), A_dil1_avg(3,2),A_dil1_avg(3,3),A_dil1_avg(3,4),A_dil1_avg(3,5),A_dil1_avg(3,6),A_dil2_avg(3,1), A_dil2_avg(3,2),A_dil2_avg(3,3);
	         A_dil1_avg(4,1), A_dil1_avg(4,2),A_dil1_avg(4,3),A_dil1_avg(4,4),A_dil1_avg(4,5),A_dil1_avg(4,6),A_dil2_avg(4,1), A_dil2_avg(4,2),A_dil2_avg(4,3);
	         A_dil1_avg(5,1), A_dil1_avg(5,2),A_dil1_avg(5,3),A_dil1_avg(5,4),A_dil1_avg(5,5),A_dil1_avg(5,6),A_dil2_avg(5,1), A_dil2_avg(5,2),A_dil2_avg(5,3);
	         A_dil1_avg(6,1), A_dil1_avg(6,2),A_dil1_avg(6,3),A_dil1_avg(6,4),A_dil1_avg(6,5),A_dil1_avg(6,6),A_dil2_avg(6,1), A_dil2_avg(6,2),A_dil2_avg(6,3);
	         A_dil3_avg(1,1),A_dil3_avg(1,2),A_dil3_avg(1,3),A_dil3_avg(1,4),A_dil3_avg(1,5),A_dil3_avg(1,6),A_dil4_avg(1,1),A_dil4_avg(1,2),A_dil4_avg(1,3);
	         A_dil3_avg(2,1),A_dil3_avg(2,2),A_dil3_avg(2,3),A_dil3_avg(2,4),A_dil3_avg(2,5),A_dil3_avg(2,6),A_dil4_avg(2,1),A_dil4_avg(2,2),A_dil4_avg(2,3);
	         A_dil3_avg(3,1),A_dil3_avg(3,2),A_dil3_avg(3,3),A_dil3_avg(3,4),A_dil3_avg(3,5),A_dil3_avg(3,6),A_dil4_avg(3,1),A_dil4_avg(3,2),A_dil4_avg(3,3);];

Average_term = (E_f-E_m)*A_dil;

Average_term1=zeros;
Average_term1(1,1)=Average_term(1,1);
Average_term1(1,2)=Average_term(1,2);
Average_term1(1,3)=Average_term(1,3);
Average_term1(1,4)=Average_term(1,4);
Average_term1(1,5)=Average_term(1,5);
Average_term1(1,6)=Average_term(1,6);

Average_term1(2,1)=Average_term(2,1);
Average_term1(2,2)=Average_term(2,2);
Average_term1(2,3)=Average_term(2,3);
Average_term1(2,4)=Average_term(2,4);
Average_term1(2,5)=Average_term(2,5);
Average_term1(2,6)=Average_term(2,6);

Average_term1(3,1)=Average_term(3,1);
Average_term1(3,2)=Average_term(3,2);
Average_term1(3,3)=Average_term(3,3);
Average_term1(3,4)=Average_term(3,4);
Average_term1(3,5)=Average_term(3,5);
Average_term1(3,6)=Average_term(3,6);

Average_term1(4,1)=Average_term(4,1);
Average_term1(4,2)=Average_term(4,2);
Average_term1(4,3)=Average_term(4,3);
Average_term1(4,4)=Average_term(4,4);
Average_term1(4,5)=Average_term(4,5);
Average_term1(4,6)=Average_term(4,6);

Average_term1(5,1)=Average_term(5,1);
Average_term1(5,2)=Average_term(5,2);
Average_term1(5,3)=Average_term(5,3);
Average_term1(5,3)=Average_term(5,4);
Average_term1(5,5)=Average_term(5,5);
Average_term1(5,6)=Average_term(5,6);

Average_term1(6,1)=Average_term(6,1);
Average_term1(6,2)=Average_term(6,2);
Average_term1(6,3)=Average_term(6,3);
Average_term1(6,4)=Average_term(6,4);
Average_term1(6,5)=Average_term(6,5);
Average_term1(6,6)=Average_term(6,6);

Average_term1_rotated = M * Average_term1 * M_T; 

BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
%finding the average of components integral
 Average_term1_avg = zeros(6,6);
 for ii=1:6
    for jj=1:6
        if  Average_term1_rotated(ii,jj)~=0
            A_temp = matlabFunction(Average_term1_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
            Average_term1_avg(ii,jj)=(integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
% 			temp15 = ['A_avg(',num2str(ii),',',num2str(jj),')']
% 			fprintf(fileID15,'%s \t',temp15);
% 			fprintf(fileID15,'%12.20f\n',Average_term1_avg(ii,jj));
		end
    end
 end 
%
Average_term2=zeros;
Average_term2(1,1)=Average_term(1,7);
Average_term2(1,2)=Average_term(1,8);
Average_term2(1,3)=Average_term(1,9);

Average_term2(2,1)=Average_term(2,7);
Average_term2(2,2)=Average_term(2,8);
Average_term2(2,3)=Average_term(2,9);

Average_term2(3,1)=Average_term(3,7);
Average_term2(3,2)=Average_term(3,8);
Average_term2(3,3)=Average_term(3,9);

Average_term2(4,1)=Average_term(4,7);
Average_term2(4,2)=Average_term(4,8);
Average_term2(4,3)=Average_term(4,9);

Average_term2(5,1)=Average_term(5,7);
Average_term2(5,2)=Average_term(5,8);
Average_term2(5,3)=Average_term(5,9);

Average_term2(6,1)=Average_term(6,7);
Average_term2(6,2)=Average_term(6,8);
Average_term2(6,3)=Average_term(6,9);

Average_term2_rotated = M * Average_term2 * A_T;

BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
%finding the average of components integral
 Average_term2_avg = zeros(6,3);
 for ii=1:6
    for jj=1:3
        if  Average_term2_rotated(ii,jj)~=0
            A_temp = matlabFunction(Average_term2_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
            Average_term2_avg(ii,jj)=(integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
% 			temp16 = ['A_avg(',num2str(ii),',',num2str(jj),')']
% 			fprintf(fileID16,'%s \t',temp16);
% 			fprintf(fileID16,'%12.20f\n',Average_term2_avg(ii,jj));	
		end
    end
 end 

Average_term3=zeros;

Average_term3(1,1)=Average_term(7,1);
Average_term3(1,2)=Average_term(7,2);
Average_term3(1,3)=Average_term(7,3);
Average_term3(1,4)=Average_term(7,4);
Average_term3(1,5)=Average_term(7,5);
Average_term3(1,6)=Average_term(7,6);

Average_term3(2,1)=Average_term(8,1);
Average_term3(2,2)=Average_term(8,2);
Average_term3(2,3)=Average_term(8,3);
Average_term3(2,4)=Average_term(8,4);
Average_term3(2,5)=Average_term(8,5);
Average_term3(2,6)=Average_term(8,6);

Average_term3(3,1)=Average_term(9,1);
Average_term3(3,2)=Average_term(9,2);
Average_term3(3,3)=Average_term(9,3);
Average_term3(3,4)=Average_term(9,4);
Average_term3(3,5)=Average_term(9,5);
Average_term3(3,6)=Average_term(9,6);

Average_term3_rotated = A * Average_term3 * M_T; 

BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
%finding the average of components integral
 Average_term3_avg = zeros(3,6);
 for ii=1:3
    for jj=1:6
        if  Average_term3_rotated(ii,jj)~=0
            A_temp = matlabFunction(Average_term3_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
            Average_term3_avg(ii,jj)= (integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
% 			temp17 = ['A_avg(',num2str(ii),',',num2str(jj),')'];
% 			fprintf(fileID17,'%s \t',temp17);
% 			fprintf(fileID17,'%12.20f\n',Average_term3_avg(ii,jj));
        end
    end
 end 

Average_term4=zeros;
Average_term4(1,1)=Average_term(7,7);
Average_term4(1,2)=Average_term(7,8);
Average_term4(1,3)=Average_term(7,9);

Average_term4(2,1)=Average_term(8,7);
Average_term4(2,2)=Average_term(8,8);
Average_term4(2,3)=Average_term(8,9);

Average_term4(3,1)=Average_term(9,7);
Average_term4(3,2)=Average_term(9,8);
Average_term4(3,3)=Average_term(9,9);

Average_term4_rotated = A * Average_term4 * A_T;

BB=matlabFunction(sin(PHI),'vars',[THETA, PHI, OMEGA]);
BB1=integral3(BB,-pi,pi,0,pi,0,pi/2);
%finding the average of components integral
 Average_term4_avg = zeros(3,3);
 for ii=1:3
    for jj=1:3
        if  Average_term4_rotated(ii,jj)~=0
            A_temp = matlabFunction(Average_term4_rotated(ii,jj)*sin(PHI),'vars',[THETA, PHI, OMEGA]);
            Average_term4_avg(ii,jj)=(integral3(A_temp,-pi,pi,0,pi,0,pi/2))/BB1;
% 			temp18 = ['A_avg(',num2str(ii),',',num2str(jj),')']
% 			fprintf(fileID18,'%s \t',temp18);
% 			fprintf(fileID18,'%12.20f\n',Average_term4_avg(ii,jj));
        end
    end
 end 

Average = [Average_term1_avg(1,1), Average_term1_avg(1,2),Average_term1_avg(1,3),Average_term1_avg(1,4),Average_term1_avg(1,5),Average_term1_avg(1,6),Average_term2_avg(1,1), Average_term2_avg(1,2),Average_term2_avg(1,3);
	       Average_term1_avg(2,1), Average_term1_avg(2,2),Average_term1_avg(2,3),Average_term1_avg(2,4),Average_term1_avg(2,5),Average_term1_avg(2,6),Average_term2_avg(2,1), Average_term2_avg(2,2),Average_term2_avg(2,3);
	       Average_term1_avg(3,1), Average_term1_avg(3,2),Average_term1_avg(3,3),Average_term1_avg(3,4),Average_term1_avg(3,5),Average_term1_avg(3,6),Average_term2_avg(3,1), Average_term2_avg(3,2),Average_term2_avg(3,3);
	       Average_term1_avg(4,1), Average_term1_avg(4,2),Average_term1_avg(4,3),Average_term1_avg(4,4),Average_term1_avg(4,5),Average_term1_avg(4,6),Average_term2_avg(4,1), Average_term2_avg(4,2),Average_term2_avg(4,3);
	       Average_term1_avg(5,1), Average_term1_avg(5,2),Average_term1_avg(5,3),Average_term1_avg(5,4),Average_term1_avg(5,5),Average_term1_avg(5,6),Average_term2_avg(5,1), Average_term2_avg(5,2),Average_term2_avg(5,3);
	       Average_term1_avg(6,1), Average_term1_avg(6,2),Average_term1_avg(6,3),Average_term1_avg(6,4),Average_term1_avg(6,5),Average_term1_avg(6,6),Average_term2_avg(6,1), Average_term2_avg(6,2),Average_term2_avg(6,3);
	       Average_term3_avg(1,1),Average_term3_avg(1,2),Average_term3_avg(1,3),Average_term3_avg(1,4),Average_term3_avg(1,5),Average_term3_avg(1,6),Average_term4_avg(1,1),Average_term4_avg(1,2),Average_term4_avg(1,3);
	       Average_term3_avg(2,1),Average_term3_avg(2,2),Average_term3_avg(2,3),Average_term3_avg(2,4),Average_term3_avg(2,5),Average_term3_avg(2,6),Average_term4_avg(2,1),Average_term4_avg(2,2),Average_term4_avg(2,3);
	       Average_term3_avg(3,1),Average_term3_avg(3,2),Average_term3_avg(3,3),Average_term3_avg(3,4),Average_term3_avg(3,5),Average_term3_avg(3,6),Average_term4_avg(3,1),Average_term4_avg(3,2),Average_term4_avg(3,3);];
% 
iteration = 1
for c3 = 0.001:0.01:0.6
    c1 = 1-c3;
    c2 = 0;
    E_composite_no_intrfc_avg = E_m+c3*(Average)*inv(c1*I+c3*A_dil_avg);
    C11_no_intrfc_avg= E_composite_no_intrfc_avg(1,1);
    C12_no_intrfc_avg= E_composite_no_intrfc_avg(1,2);
    C13_no_intrfc_avg = E_composite_no_intrfc_avg(1,3);
    C21_no_intrfc_avg = E_composite_no_intrfc_avg(2,1);
    C22_no_intrfc_avg = E_composite_no_intrfc_avg(2,2);
    C23_no_intrfc_avg = E_composite_no_intrfc_avg(2,3);
    C31_no_intrfc_avg = E_composite_no_intrfc_avg(3,1);
    C32_no_intrfc_avg = E_composite_no_intrfc_avg(3,2);
    C33_no_intrfc_avg = E_composite_no_intrfc_avg(3,3);
    C44_no_intrfc_avg = E_composite_no_intrfc_avg(4,4);
    C55_no_intrfc_avg = E_composite_no_intrfc_avg(5,5);
    C66_no_intrfc_avg = E_composite_no_intrfc_avg(6,6);

    e15_no_intrfc_avg=E_composite_no_intrfc_avg(7,5);
    e24_no_intrfc_avg=E_composite_no_intrfc_avg(8,4);
    e31_no_intrfc_avg=E_composite_no_intrfc_avg(9,1);
    e32_no_intrfc_avg=E_composite_no_intrfc_avg(9,2);
    e33_no_intrfc_avg=E_composite_no_intrfc_avg(9,3);
    Cmatrix_no_intrfc_avg  = [C11_no_intrfc_avg C12_no_intrfc_avg C13_no_intrfc_avg 0 0 0;
                   C21_no_intrfc_avg C22_no_intrfc_avg C23_no_intrfc_avg 0 0 0;
                   C31_no_intrfc_avg C32_no_intrfc_avg C33_no_intrfc_avg 0 0 0;
                   0 0 0 C44_no_intrfc_avg 0 0;
                   0 0 0 0 C55_no_intrfc_avg 0;
                   0 0 0 0 0 C66_no_intrfc_avg];
    Smatrix_no_intrfc_avg = inv(Cmatrix_no_intrfc_avg);
    ematrix_no_intrfc_avg = [0 0 0 0 e15_no_intrfc_avg 0;
                      0 0 0 e24_no_intrfc_avg 0 0;
                      e31_no_intrfc_avg e32_no_intrfc_avg e33_no_intrfc_avg 0 0 0];
    dmatrix_no_intrfc_avg = ematrix_no_intrfc_avg*Smatrix_no_intrfc_avg;
    E1_composite_no_intrfc_avg=(1/(Smatrix_no_intrfc_avg(1,1)));
    E2_composite_no_intrfc_avg=(1/(Smatrix_no_intrfc_avg(2,2)));
    E3_composite_no_intrfc_avg=(1/(Smatrix_no_intrfc_avg(3,3)));
    % 
    G23_no_intrfc_avg=(1/(Smatrix_no_intrfc_avg(4,4)));
    G13_no_intrfc_avg=(1/(Smatrix_no_intrfc_avg(5,5)));
    G12_no_intrfc_avg=(1/(Smatrix_no_intrfc_avg(6,6)));

    nu12_no_intrfc_avg=-(E1_composite_no_intrfc_avg*Smatrix_no_intrfc_avg(1,2));
    nu13_no_intrfc_avg=-(E1_composite_no_intrfc_avg*Smatrix_no_intrfc_avg(1,3));
    nu23_no_intrfc_avg=-(E2_composite_no_intrfc_avg*Smatrix_no_intrfc_avg(2,3));

    k11_no_intrfc_avg=-E_composite_no_intrfc_avg(7,7);
    k22_no_intrfc_avg=-E_composite_no_intrfc_avg(8,8);
    k33_no_intrfc_avg=-E_composite_no_intrfc_avg(9,9);

    d15_no_intrfc_avg=(dmatrix_no_intrfc_avg(1,5)/(1e-12))/(1e9);
    d24_no_intrfc_avg=(dmatrix_no_intrfc_avg(2,4)/(1e-12))/(1e9);
    d31_no_intrfc_avg=(dmatrix_no_intrfc_avg(3,1)/(1e-12))/(1e9);
    d32_no_intrfc_avg=(dmatrix_no_intrfc_avg(3,2)/(1e-12))/(1e9);
    d33_no_intrfc_avg=(dmatrix_no_intrfc_avg(3,3)/(1e-12))/(1e9);
    %
    fprintf(fileID7,'%f\t %f\t %f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', c1, c2, c3, E1_composite_no_intrfc_avg, E2_composite_no_intrfc_avg, E3_composite_no_intrfc_avg, G23_no_intrfc_avg, G13_no_intrfc_avg, G12_no_intrfc_avg, nu23_no_intrfc_avg, nu13_no_intrfc_avg, nu12_no_intrfc_avg, d31_no_intrfc_avg, d32_no_intrfc_avg, d33_no_intrfc_avg, d15_no_intrfc_avg, d24_no_intrfc_avg, k11_no_intrfc_avg,k22_no_intrfc_avg,k33_no_intrfc_avg);
    fprintf(fileID8,'%f\t %f\t %f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\t %12.20f\n', c1, c2, c3, C11_no_intrfc_avg, C12_no_intrfc_avg, C13_no_intrfc_avg, C22_no_intrfc_avg, C23_no_intrfc_avg, C33_no_intrfc_avg, C44_no_intrfc_avg, C55_no_intrfc_avg, C66_no_intrfc_avg, e31_no_intrfc_avg, e32_no_intrfc_avg, e33_no_intrfc_avg, e15_no_intrfc_avg, e24_no_intrfc_avg, k11_no_intrfc_avg,k22_no_intrfc_avg,k33_no_intrfc_avg);
    %
    fprintf('Iteration # %d completed.\n',iteration);
    iteration = iteration + 1;
end
disp("Properties of random ESO/BTO composite with no interface calculated.")

fclose(fileID7);
fclose(fileID8);
