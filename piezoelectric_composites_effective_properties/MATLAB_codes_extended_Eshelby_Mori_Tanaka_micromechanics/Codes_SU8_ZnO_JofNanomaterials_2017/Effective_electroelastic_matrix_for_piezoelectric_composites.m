%% Code to create Eshelby type tensor for an ellipsoidal inclusion for 
% piezoelectric composites
% Source: Dunn, and Taya, MICROMECHANICS PREDICTIONS OF THE EFFECTIVE 
% ELECTROELASTIC MODULI OF PIEZOELECTRIC COMPOSITES, Int. J. Solids 
% Structures Vol. 30, No. 2, pp. 161-175, 1993.
%%
clc
clear all;
format longg
% vf = 0.22447;  % Volume fraction of the reinforcement phase
fileID = fopen('ZnO_SU8_effective_electroelastic_moduli.txt','w');
fprintf(fileID,'%20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s    %20s\r\n','volfrac', 'C11[Pa]', 'C12[Pa]', 'C13[Pa]', 'C21[Pa]', 'C22[Pa]', 'C23[Pa]', 'C31[Pa]', 'C32[Pa]', 'C33[Pa]', 'C44[Pa]', 'C55[Pa]', 'C66[Pa]', 'e31[C/m2]', 'e33[C/m2]', 'e15[C/m2]', 'K11[C2/Nm2]',  'K33[C2/Nm2]', 'E1[Pa]', 'E2[Pa]', 'E3[Pa]', 'G23[Pa]', 'G13[Pa]', 'G12[Pa]', 'nu12', 'nu21', 'nu13', 'nu31', 'nu23', 'nu32', 'd31[C/N]', 'd32[C/N]', 'd33[C/N]', 'dh[C/N]', 'd15[C/N]', 'd24[C/N]', 'e15', 'e24') 
%for vf = 0.005:(0.7-0.005)/19:0.7
for vf = 0.001:0.005:1
vm = 1-vf; % Volume fraction of the matrix phase
%% Geometry of the inclusion
% Cylinder is aligned along Z - axis i.e. a3 along Z-axis tends to infinity
a1 = 30e-9; % Unit m
a2 = 30e-9; % Unit m
alpha = a2/a1;
%% Material properties of the matrix
% Matrix is SU8
C11 = (5.023419203747072e+09)/(1e9); % Unit GPa, Component of stiffness matrix
C12 = (1.416861826697892e+09)/(1e9); % Unit GPa, Component of stiffness matrix
C13 = (1.416861826697892e+09)/(1e9); % Unit GPa, Component of stiffness matrix
C44 = (C11-C12)/2;
e31 = 0; % Unit Coulomb per square metre, Component of coupling modulus
         % matrix in stress-charge form. This matrix is known as the 
         % piezoelectric matrix in the paper by Dunn and Taya.
%%
S = zeros(9); % Initialize the 9 x 9 Eshelby-type constraint matrix
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
S_2D = S;
%% Electroelastic modulus matrix for the matrix
% matrix: SU8
e0 = 8.85418782e-12; % Permittivity of free space, Units m^(-3).kg^(-1).sec^4.Amp^2
E_m2D = [ C11, C12, C12, 0, 0, 0, 0, 0, 0;
          C12, C11, C12, 0, 0, 0, 0, 0, 0;
          C12, C12, C11, 0, 0, 0, 0, 0, 0;
           0, 0, 0, C44, 0, 0, 0, 0, 0;
           0, 0, 0, 0, C44, 0, 0, 0, 0;
           0, 0, 0, 0, 0, C44, 0, 0, 0;
           0, 0, 0, 0, 0, 0, -(4*e0/e0), 0, 0;
           0, 0, 0, 0, 0, 0, 0, -(4*e0/e0), 0;
           0, 0, 0, 0, 0, 0, 0, 0, -(4*e0/e0)];
%% Electroelastic modulus matrix for the reinforcement       
% reinforcement: ZnO (wurtzite structure)
Cf11 = (2.09714e+011)/(1e9); % [GPa], Component of stiffness matrix
Cf12 = (1.2114e+011)/(1e9); %  [GPa], Component of stiffness matrix
Cf13 = (1.05359e+011)/(1e9); % [GPa], Component of stiffness matrix
Cf33 = (2.11194e+011)/(1e9); % [GPa], Component of stiffness matrix
Cf44 = (4.23729e+010)/(1e9); % [GPa], Component of stiffness matrix
Cf66 = (4.42478e+010)/(1e9); % [GPa], Component of stiffness matrix
ef15 = -0.480508; % [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
ef31 = -0.567005; % [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
ef33 = 1.32044; % [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form) 
Kf11 = (8.5446*e0); % Component of dielectric modulus matrix
Kf33 = (10.204*e0); % Component of dielectric modulus matrix
E_f2D = [Cf11, Cf12, Cf13, 0, 0, 0, 0, 0, ef31;
         Cf12, Cf11, Cf13, 0, 0, 0, 0, 0, ef31;
         Cf13, Cf13, Cf33, 0, 0, 0, 0, 0, ef33;
         0, 0, 0, Cf44, 0, 0, 0, ef15, 0;
         0, 0, 0, 0, Cf44, 0, ef15, 0, 0;
         0, 0, 0, 0, 0, Cf66, 0, 0, 0;
         0, 0, 0, 0, ef15, 0, -Kf11/e0, 0, 0;
         0, 0, 0, ef15, 0, 0, 0, -Kf11/e0, 0;
         ef31, ef31, ef33, 0, 0, 0, 0, 0, -Kf33/e0];
F_f2D = inv(E_f2D);
d31_f = (-F_f2D(9,1)/F_f2D(9,9))/(1e9);
d32_f = (-F_f2D(9,2)/F_f2D(9,9))/(1e9);
d33_f = (-F_f2D(9,3)/F_f2D(9,9))/(1e9);
d15_f = (-F_f2D(7,5)/F_f2D(7,7))/(1e9);
d24_f = (-F_f2D(8,4)/F_f2D(8,8))/(1e9);
%% Calculation of effective electro-elastic modulus matrix of a continuous 
% aligned composite

I_2D = eye(9);
A_dil2D = inv(I_2D  + (S_2D*(inv(E_m2D))*(E_f2D - E_m2D)));
A_MT2D = A_dil2D*(inv((vm*I_2D) + (vf*A_dil2D)));
% EA_2D = (E_f2D - E_m2D)*A_dil2D;
% E_composite_aligned_2D = E_m2D + (vf*EA_2D*(inv((1-vf)*I_2D + vf*A_dil2D)));
E_composite_aligned_2D = E_m2D + (vf*(E_f2D-E_m2D)*A_MT2D)
F_composite_aligned_2D = inv(E_composite_aligned_2D)
%% Calculation of E_composite_aligned_2D in terms of the matrix in [Pa], [C/m^2], and [C^2/Nm^2]
for i =1:6
    for j = 1:6
        E_composite_aligned2D(i,j) = E_composite_aligned_2D(i,j)*(1e9);
    end
end
for i = 7:9
    for j = 1:6
        E_composite_aligned2D(i,j) = E_composite_aligned_2D(i,j);
    end
end
for i = 1:6
    for j = 7:9
        E_composite_aligned2D(i,j) = E_composite_aligned_2D(i,j);
    end
end
for i = 7:9
    for j = 7:9
        E_composite_aligned2D(i,j) = E_composite_aligned_2D(i,j)*(e0);
    end
end
%% Calculation of E_composite_aligned_2D in terms of the matrix in [Pa-1], [C/m^2]-1, and [C^2/Nm^2]-1
for i =1:6
    for j = 1:6
        F_composite_aligned2D(i,j) = F_composite_aligned_2D(i,j)/1e9;
    end
end
for i = 7:9
    for j = 1:6
        F_composite_aligned2D(i,j) = F_composite_aligned_2D(i,j);
    end
end
for i = 1:6
    for j = 7:9
        F_composite_aligned2D(i,j) = F_composite_aligned_2D(i,j);
    end
end
for i = 7:9
    for j = 7:9
        F_composite_aligned2D(i,j) = F_composite_aligned_2D(i,j)/(e0);
    end
end
%% Calculation of E1, E2, E3, G23, G13, G12
e15 = E_composite_aligned2D(7,5);
e24 = E_composite_aligned2D(8,4);
E1 = 1/F_composite_aligned2D(1,1);
E2 = 1/F_composite_aligned2D(2,2);
E3 = 1/F_composite_aligned2D(3,3);
G23 = 1/F_composite_aligned2D(4,4);
G13 = 1/F_composite_aligned2D(5,5);
G12 = 1/F_composite_aligned2D(6,6);
nu12 = -F_composite_aligned2D(2,1)/F_composite_aligned2D(1,1);
nu13 = -F_composite_aligned2D(3,1)/F_composite_aligned2D(1,1);
nu21 = -F_composite_aligned2D(1,2)/F_composite_aligned2D(2,2);
nu31 = -F_composite_aligned2D(1,3)/F_composite_aligned2D(3,3);
nu23 = -F_composite_aligned2D(3,2)/F_composite_aligned2D(2,2);
nu32 = -F_composite_aligned2D(2,3)/F_composite_aligned2D(3,3);
d31 = (-F_composite_aligned_2D(9,1)/F_composite_aligned_2D(9,9))/(1e9)
d32 = (-F_composite_aligned_2D(9,2)/F_composite_aligned_2D(9,9))/(1e9)
d33 = (-F_composite_aligned_2D(9,3)/F_composite_aligned_2D(9,9))/(1e9)
dh = d31 + d32 + d33
d15 = (-F_composite_aligned_2D(7,5)/F_composite_aligned_2D(7,7))/(1e9)
d24 = (-F_composite_aligned_2D(8,4)/F_composite_aligned_2D(8,8))/(1e9)
%% Saving data to a file
fprintf(fileID,'%12.8f, %12.8f, %12.8f, %12.8f,  %12.8f,  %12.8f,  %12.8f,  %12.8f,  %12.8f,  %12.8f,  %12.8f,  %12.8f,  %12.8f,  %12.8f,  %12.8f,  %12.8f, %12.8f, %12.8f, %12.8e, %12.8e, %12.8f, %12.8f, %12.8f, %12.8f, %12.8f, %12.8f, %12.8f, %12.8f, %12.8f, %12.8f, %12.8f, %12.8f, %12.8e, %12.8e, %12.8e, %12.8e, %12.8e, %12.8e\r\n',vf, E_composite_aligned2D(1,1), E_composite_aligned2D(1,2), E_composite_aligned2D(1,3), E_composite_aligned2D(2,1), E_composite_aligned2D(2,2), E_composite_aligned2D(2,3), E_composite_aligned2D(3,1), E_composite_aligned2D(3,2), E_composite_aligned2D(3,3), E_composite_aligned2D(4,4), E_composite_aligned2D(5,5), E_composite_aligned2D(6,6), E_composite_aligned2D(9,1), E_composite_aligned2D(9,3), E_composite_aligned2D(7,5), -E_composite_aligned2D(7,7), -E_composite_aligned2D(9,9), E1, E2, E3, G23, G13, G12, nu12, nu21, nu13, nu31, nu23, nu32, d31, d32, d33, dh, d15, d24, e15, e24);
end
fclose(fileID);

