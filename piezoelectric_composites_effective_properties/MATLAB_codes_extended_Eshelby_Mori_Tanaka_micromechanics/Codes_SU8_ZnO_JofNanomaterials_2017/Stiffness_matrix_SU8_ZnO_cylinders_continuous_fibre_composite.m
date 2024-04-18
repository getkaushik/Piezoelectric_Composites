%% Code to calculate stiffness matrix of continuous fibre reinforced 
% composite, for a cylindrical reinforcement with the cylinder axis being
% aligned along X-axis, and for random alignment
clc;
clear all;
format long;
nu_m =0.22 ;%  ==nu_SU8
E_m = 4.4*10^9; % ==E_SU8, units: Pa
vf = 0.47; % Volume fraction of reinforcement
%s =[10:10: 100000]'
% s = 1000 ;% aspect ratio
I_2D = eye (6);
%%
% I_1 = (2*s)*(s*(sqrt(s^2 - 1)) - acosh(s))/((sqrt(s^2 - 1)^3));
% I_3 = 4 - (2*I_1);
% Q = 3/(8*(1-nu_m));
% R = (1 -(2*nu_m))/(8*(1-nu_m));
% T = Q*(4 - 3*I_1)/(3*(s^2) - 1);

% % Components of the EshelA_4Dy tensor (6 x6)
% S_1111 = (4*Q/3)+(R*I_3)+(2*(s^2)*T);
% S_2222 = Q+(R.*I_1)+(3.*T/4);
% S_3333 = S_2222;
% S_3322 =(Q/3)-(R.*I_1)+(4.*T/3);
% S_2233 = S_3322;
% S_3311 = -(R.*I_1) - ((s.^2).*T);
% S_2211 =S_3311;
% S_1133 = -(R.*I_3) - T;
% S_1122 = S_1133;
% S_2323 = (Q/3)+(R.*I_1)+(T/4);
% S_3131 = (2*R) - (R.*I_1./2)- ((1+s.^2).*T./2);
% S_1212 = S_3131;
% [epsilon_11, epsilon_22, epsilon_33, epsilon_23,epsilon_31, epsilon_12]'
% = [S].[epsilon*_11, epsilon*_22, epsilon*_33, epsilon*_23,epsilon*_31,
%        epsilon*_12]' 

% Components of an EshelA_4Dy tensor for an infinite cylinder (6 x 6). 
% Cylinder is aligned along x - axis
S_1111 = 0;
S_2222 = (5 - (4*nu_m))/(8*(1-nu_m));
S_3333 = S_2222;
S_3322 = (-1 + (4*nu_m))/(8*(1-nu_m));
S_2233 = S_3322;
S_3311 = nu_m/(2*(1-nu_m));
S_2211 = S_3311;
S_1133 = 0;
S_1122 = S_1133;
S_2323 = (3 - (4*nu_m))/(8*(1-nu_m));
S_3131 = 0.25;
S_1212 = 0.25;
S_2D  = [S_1111, S_1122, S_1133, 0, 0, 0; S_2211, S_2222, S_2233, 0,0,0; S_3311, S_3322, S_3333, 0,0,0;0,0,0, S_2323,0,0; 0,0,0,0,S_3131,0; 0,0,0,0,0, S_1212];

S_4D =[];
S_4D(1,1,1,1) = S_1111;
S_4D(2,2,2,2) = S_2222;
S_4D(3,3,3,3) = S_2222;
S_4D(3,3,2,2) = S_3322;
S_4D(2,2,3,3) = S_3322;
S_4D(3,3,1,1) = S_3311;
S_4D(2,2,1,1) = S_3311;
S_4D(1,1,3,3) = S_1133;
S_4D(1,1,2,2) = S_1122;
S_4D(2,3,2,3) = S_2323;
S_4D(3,1,3,1) = S_3131;
S_4D(1,2,1,2) = S_1212;
%%

%Stiffness matrix of isotropic polymer SU8
E_m1 = E_m/((1+nu_m)*(1-2*(nu_m)));
% [sigma_11, sigma_22, sigma_33, sigma_23,sigma_31, sigma_12]' =
% [c][epsilon_11, epsilon_22, epsilon_33, epsilon_23,epsilon_31, epsilon_12]'
C_m2D = E_m1.*[(1-nu_m), nu_m, nu_m, 0, 0, 0;
             nu_m, (1-nu_m), nu_m, 0, 0, 0;
             nu_m, nu_m, (1-nu_m), 0, 0, 0;
             0, 0, 0, 0.5*(1-(2*nu_m)), 0, 0;
             0, 0, 0, 0, 0.5*(1-(2*nu_m)), 0;
             0, 0, 0, 0, 0, 0.5*(1-(2*nu_m))];
C_m4D = [];
C_m4D(1,1,1,1) = E_m1*(1-nu_m);
C_m4D(1,1,2,2) = E_m1* nu_m;
C_m4D(1,1,2,2) = E_m1* nu_m;
C_m4D(2,2,1,1) = E_m1*nu_m;
C_m4D(2,2,2,2) = E_m1*(1-nu_m);
C_m4D(2,2,3,3) = E_m1*nu_m;
C_m4D(3,3,1,1) = E_m1*nu_m;
C_m4D(3,3,2,2) = E_m1*nu_m;
C_m4D(3,3,3,3) = E_m1*(1-nu_m);
C_m4D(2,3,2,3) = 0.5*E_m1*(1-(2*nu_m));
C_m4D(3,1,3,1) = 0.5*E_m1*(1-(2*nu_m));
C_m4D(1,2,1,2) = 0.5*E_m1*(1-(2*nu_m));
%%
      
% Stiffness matrix of ZnO
% Note: c-axis of ZnO is aligned along x-direction of the gloA_4Dal coordinate
% system

C_f2D=(10^9)*[210.9000 105.1000 105.1000 0 0 0;
            105.1000 209.7000 121.1000 0 0 0;
            105.1000 121.1000 209.7000 0 0 0;
            0 0 0 44.2900 0 0;
            0 0 0 0 42.4700 0;
            0 0 0 0 0 42.4700];
   
C_f4D =[];
C_f4D(1,1,1,1) = C_f2D(1,1);
C_f4D(1,1,2,2) = C_f2D(1,2);
C_f4D(1,1,3,3) = C_f2D(1,2);
C_f4D(2,2,1,1) = C_f2D(1,2);
C_f4D(2,2,2,2) = C_f2D(2,2);
C_f4D(2,2,3,3) = C_f2D(2,3);
C_f4D(3,3,1,1) = C_f2D(1,2);
C_f4D(3,3,2,2) = C_f2D(2,2);
C_f4D(3,3,3,3) = C_f2D(2,2);
C_f4D(2,3,2,3) = C_f2D(4,4);
C_f4D(3,1,3,1) = C_f2D(5,5);
C_f4D(1,2,1,2) = C_f2D(6,6);
%%
A_2D = inv(I_2D  + (S_2D*(inv(C_m2D))*(C_f2D - C_m2D)));
CA_2D = (C_f2D - C_m2D)*A_2D;
C_composite_aligned_2D = C_m2D + (vf*CA_2D*(inv((1-vf)*I_2D + vf*A_2D)));
%%
% I_4D = [];
% delta =eye(3)
% for i = 1:1:3
%     for j = 1:1:3
%         for k = 1:1:3
%             for l = 1:1:3
%                 I_4D(i,j,k,l) =0.5*(delta(i,k)*delta(j,l) + delta(i,l)*delta(j,k))
%             end
%         end
%     end
% end
%%
A_4D =[];
A_4D(1,1,1,1) = A_2D(1,1);
A_4D(1,1,2,2) = A_2D(1,2);
A_4D(1,1,3,3) = A_2D(1,3);
A_4D(2,2,1,1) = A_2D(2,1);
A_4D(2,2,2,2) = A_2D(2,2);
A_4D(2,2,3,3) = A_2D(2,3);
A_4D(3,3,1,1) = A_2D(3,1);
A_4D(3,3,2,2) = A_2D(3,2);
A_4D(3,3,3,3) = A_2D(3,3);
A_4D(2,3,2,3) = A_2D(4,4);
A_4D(3,1,3,1) = A_2D(5,5);
A_4D(1,2,1,2) = A_2D(6,6);
%%
syms  phi psi gamma

c(1,1) = cos(phi)*cos(psi) - sin(phi)*cos(gamma)*sin(psi);
c(1,2) = sin(phi)*cos(psi) - cos(phi)*cos(gamma)*sin(psi);
c(1,3) = sin(psi)*sin(gamma);
c(2,1) = -cos(phi)*sin(psi) - sin(phi)*cos(gamma)*cos(psi);
c(2,2) = -sin(phi)*sin(psi) + cos(phi)*cos(gamma)*cos(psi);
c(2,3) = sin(gamma)*cos(psi);
c(3,1) = sin(phi)*sin(gamma);
c(3,2) = -cos(phi)*sin(gamma);
c(3,3) = cos(gamma);
%%


for i = 1:1:3
    for j = 1:1:3
        for k = 1:1:3
            for l = 1:1:3
                A_bar_4D(i,j,k,l) = vpa(0)
                for p =1:1:3
                    for q =1:1:3
                        for r = 1:1:3
                           for s = 1:1:3
                           A_bar_4D(i,j,k,l) = (c(i,p)*c(j,q)*c(k,r)*c(l,s)*A_4D(p,q,r,s))+ A_bar_4D(i,j,k,l);
                           end
                        end
                    end
                end
            end
        end
    end
end
%%
for i =1:1:3
    for j =1:1:3
        for k =1:1:3
            for l = 1:1:3
                A_avg_4D_symb(i,j,k,l) = ((int(int(int(A_bar_4D(i,j,k,l)*sin(gamma),0,(pi/2)),0,pi),(-pi/2),(pi/2)))/(int(int(int(sin(gamma),0,(pi/2)),0,pi),(-pi/2),(pi/2))));
                A_avg4D(i,j,k,l) = eval(A_avg_4D_symb(i,j,k,l));
            end
        end
    end
end
%%
A_avg6x6 = [];
A_avg6x6(1,1) = A_avg4D(1,1,1,1);
A_avg6x6(1,2) = A_avg4D(1,1,2,2);
A_avg6x6(1,3) = A_avg4D(1,1,3,3);
A_avg6x6(2,1) = A_avg4D(2,2,1,1);
A_avg6x6(2,2) = A_avg4D(2,2,2,2);
A_avg6x6(2,3) = A_avg4D(2,2,3,3);
A_avg6x6(3,1) = A_avg4D(3,3,1,1);
A_avg6x6(3,2) = A_avg4D(3,3,2,2);
A_avg6x6(3,3) = A_avg4D(3,3,3,3);
A_avg6x6(4,4) = A_avg4D(2,3,2,3);
A_avg6x6(5,5) = A_avg4D(3,1,3,1);
A_avg6x6(6,6) = A_avg4D(1,2,1,2);
%%
CA_avg2D = [];
CA_avg2D = (C_f2D - C_m2D)*A_avg6x6;
C_composite_random_2D = C_m2D + (vf*CA_avg2D*(inv((1-vf)*I_2D + vf*A_avg6x6)));


                