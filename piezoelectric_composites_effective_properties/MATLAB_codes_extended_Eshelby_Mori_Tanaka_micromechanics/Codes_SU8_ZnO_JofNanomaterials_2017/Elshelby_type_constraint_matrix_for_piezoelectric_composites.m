%% Code to create Eshelby type tensor for an ellipsoidal inclusion for 
% piezoelectric composites
% Source: Dunn, and Taya, MICROMECHANICS PREDICTIONS OF THE EFFECTIVE 
% ELECTROELASTIC MODULI OF PIEZOELECTRIC COMPOSITES, Int. J. Solids 
% Structures Vol. 30, No. 2, pp. 161-175, 1993.
%%
clc
clear all;
format long
S = zeros(9); % Initialize the 9 x 9 Eshelby-type constraint matrix
%% Geometry of the inclusion
% Cylinder is aligned along Z - axis i.e. a3 along Z-axis tends to infinity
a1 = 30e-9; % Unit m
a2 = 30e-9; % Unit m
alpha = a2/a1;
%% Material properties of the matrix
% Matrix is SU8
C11 = 5.023419203747072e+09; % Unit Pa, Component of stiffness matrix
C12 = 1.416861826697892e+09; % Unit Pa, Component of stiffness matrix
C13 = 1.416861826697892e+09; % Unit Pa, Component of stiffness matrix
e31 = 0; % Unit Coulomb per square metre, Component of piezolectric modulus
         % matrix in stress-charge form. This matrix is known as the 
         % piezoelectric matrix in the paper by Dunn and Taya.
%%         
S_1111 = (alpha/(2*(alpha+1)^2))*((((2*C11)+C12)/C11)+((2*alpha)+1));
S_1212 = (alpha/(2*(alpha+1)^2))*(((alpha^2 + alpha + 1)/alpha)-(C12/C11));
S_2121 = S_1212;
S_1221 = S_1212;
S_2112 = S_1212;
S_1313 = alpha/(2*(alpha + 1));
S_3131 = S_1313;
S_1331 = S_1313;
S_3113 = S_1313;
S_1122 = (alpha/(2*(alpha+1)^2))*(((((2*alpha)+1)*C12) - C11)/C11);
S_1133 = (C13/C11)*(alpha/(alpha + 1));
S_1143 = (e31/C11)*(alpha/(alpha + 1));
S_2211 = (alpha/(2*(alpha+1)^2))*((((alpha+2)*C12) - C11)/C11);
S_2222 = (alpha/(2*(alpha+1)^2))*((((2*C11)+C12)/C11)+((alpha+2)/alpha));
S_2323 = 1/(2*(alpha+1));
S_3232 = S_2323;
S_2332 = S_2323;
S_3223 = S_2323;
S_2233 = (C13/C11)*(1/(alpha+1));
S_2243 = (e31/C11)*(1/(alpha+1));
S_4141 = alpha/(alpha+1);
S_4242 = 1/(alpha+1);
%%
S(1,1) = S_1111;
S(1,2) = S_1122;
S(1,3) = S_1133;
S(6,6) = S_1212;
S(5,5) = S_1313;
S(1,9) = S_1143;
S(2,1) = S_2211;
S(2,2) = S_2222;
S(4,4) = S_2323;
S(2,3) = S_2233;
S(2,9) = S_2243;
S(7,7) = S_4141;
S(8,8) = S_4242;
S_constraint = S

