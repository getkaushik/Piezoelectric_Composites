%% predicting the electroelastic modulus of PVDF/PZT composite using 
%Eshelby-Mori-Tanaka method. Reference for properties of PVDF and PZT is 
% Constitutive modelling of piezoeectric polymer composites by Odegard
%and reference for eshelby tensor is An ellipsoidal inclusion or crack in
%orthotropic piezoelectric media by J.H Huang
%the shape of the inclusion is ellipsoidal
%this code is written by neelam mishra
clc
clear all
format long
As=5;% aspect ratio of the ellipsoid
%% Electroelastic Properties of PVDF
e0 = 8.85418782e-12; % Permittivity of free space, Units m^(-3).kg^(-1).sec^4.Amp^2
C11_m=3.8e9;% units in GPa,Component of stiffness matrix
C12_m=1.9e9;% units in GPa,Component of stiffness matrix
C13_m=1e9;% units in GPa,Component of stiffness matrix
C21_m=C12_m;
C22_m=3.2e9;% units in GPa,Component of stiffness matrix
C23_m=0.9e9;% units in GPa,Component of stiffness matrix
C32_m=C23_m;
C33_m=1.2e9;% units in GPa,Component of stiffness matrix
C44_m=0.7e9;% units in GPa,Component of stiffness matrix
C55_m=0.9e9;% unitss in GPa,Component of stiffness matrix
C66_m=0.9e9;% units in GPa,Component of stiffness matrix
k11_m=7.4*e0;% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
k22_m=9.3*e0;% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
k33_m=7.6*e0;% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
e15_m=0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_m=0;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_m=0.024;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_m=0.001;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_m=-0.027;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
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
 %%   Electroelastic Properties of PZT-7A
 C11_f=148e9;% units in GPa,Component of stiffness matrix
C12_f=76.2e9;% units in GPa,Component of stiffness matrix
C13_f=74.2e9;% units in GPa,Component of stiffness matrix
C22_f=148e9;% units in GPa,Component of stiffness matrix
C23_f=74.2e9;% units in GPa,Component of stiffness matrix
C33_f=131e9;% units in GPa,Component of stiffness matrix
C44_f=25.4e9;% units in GPa,Component of stiffness matrix
C55_f=25.4e9;% unitss in GPa,Component of stiffness matrix
C66_f=35.9e9;% units in GPa,Component of stiffness matrix
k1_f=460*e0;% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
k2_f=460*e0;% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
k3_f=235*e0;% Component of dielectric modulus matrix,Units m^(-3).kg^(-1).sec^4.Amp^2
e15_f=9.2;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_f=9.2;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_f=-2.1;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_f=-2.1;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_f=9.5;%units [C/m^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
E_f=     [C11_f,C12_f, C13_f, 0, 0, 0, 0, 0, e31_f;
         C12_f,C22_f, C23_f, 0, 0, 0, 0, 0, e32_f;
         C13_f,C23_f, C33_f, 0, 0, 0, 0, 0, e33_f;
         0, 0, 0, C44_f, 0, 0, 0, e15_f, 0;
         0, 0, 0, 0, C55_f, 0, e24_f, 0, 0;
         0, 0, 0, 0, 0, C66_f, 0, 0, 0;
         0, 0, 0, 0, e15_f, 0, -k1_f, 0, 0;
         0, 0, 0, e24_f, 0, 0, 0, -k2_f, 0;
         e31_f, e32_f, e33_f, 0, 0, 0, 0, 0,-k3_f];

%calculating GMJin
syms x
A=(C11_m.*C66_m).*((cos(x)).^4)+(C11_m.*C22_m-C12_m.^2-2.*C12_m.*C66_m).*As.^2.*((cos(x)).^2).*((sin(x)).^2)+C22_m.*C66_m.*As.^4.*((sin(x)).^4);
B=(C55_m.*k11_m+e15_m.^2).*(cos(x))+(C44_m.*k11_m+C55_m.*k22_m+2.*e15_m.*e24_m).*As.^2.*((cos(x)).^2).*((sin(x)).^2)+(C44_m.*k22_m+e24_m.^2).*As.^4.*((sin(x)).^4);           

g1111=(1./A)*(((cos(x))^2)*(C66_m*((cos(x))^2))+C22_m*As^2*((sin(x))^2));
G1111=double(2*int(g1111,0,2*pi));

g1122=(1./A)*(As^2*((sin(x))^2)*(C66_m*((cos(x))^2)+C22_m*As^2*((sin(x))^2)));
G1122=double(2*int(g1122,0,2*pi));


g1212=(1/A)*(As^2*((cos(x))^2)*((sin(x))^2)*(C12_m+C66_m));
G1212=double(-2*int(g1212,0,2*pi));
G1221=G1212;
G2112=G1212;
G2121=G1212;

g2211=(1/A)*(((cos(x))^2)*(C11_m*((cos(x))^2)+C66_m*As^2*((sin(x))^2)));
G2211=double(2*int(g2211,0,2*pi));


g2222=(1/A)*(As^2*((sin(x))^2)*(C11_m*((cos(x))^2)+C66_m*As^2+((sin(x))^2)));
G2222=double(2*int(g2222,0,2*pi));


g3311= @(x) (1./((C55_m.*k11_m+e15_m.^2).*(cos(x))+(C44_m.*k11_m+C55_m.*k22_m+2.*e15_m.*e24_m).*As.^2.*((cos(x)).^2).*((sin(x)).^2)+(C44_m.*k22_m+e24_m.^2).*As.^4.*((sin(x)).^4))).*(((cos(x)).^2).*(k11_m.*((cos(x)).^2)+k22_m.*As.^2.*((sin(x)).^2)));
G3311=2*integral(g3311,0,2*pi);


g3322=@(x) (1./((C55_m.*k11_m+e15_m.^2).*(cos(x))+(C44_m.*k11_m+C55_m.*k22_m+2.*e15_m.*e24_m).*As.^2.*((cos(x)).^2).*((sin(x)).^2)+(C44_m.*k22_m+e24_m.^2).*As.^4.*((sin(x)).^4))).*(As.^2.*((sin(x)).^2).*(k11_m.*((cos(x)).^2)+k22_m.*As.^2.*((sin(x)).^2)));
G3322=2*integral(g3322,0,2*pi);


g4311=@(x)(1./((C55_m.*k11_m+e15_m.^2).*(cos(x))+(C44_m.*k11_m+C55_m.*k22_m+2.*e15_m.*e24_m).*As.^2.*((cos(x)).^2).*((sin(x)).^2)+(C44_m.*k22_m+e24_m.^2).*As.^4.*((sin(x)).^4))).*(((cos(x)).^2).*(e15_m.*((cos(x)).^2)+e24_m.*As.^2.*((sin(x)).^2)));
G4311=2*integral(g4311,0,2*pi);
G3411=G4311;

g4322=@(x) (1./((C55_m.*k11_m+e15_m.^2).*(cos(x))+(C44_m.*k11_m+C55_m.*k22_m+2.*e15_m.*e24_m).*As.^2.*((cos(x)).^2).*((sin(x)).^2)+(C44_m.*k22_m+e24_m.^2).*As.^4.*((sin(x)).^4))).*(As.^2.*((sin(x)).^2).*(e15_m.*((cos(x)).^2)+e24_m.*As.^2.*((sin(x)).^2)));
G4322=2*integral(g4322,0,2*pi);
G3422=G4322;

g4411=@(x) (1./((C55_m.*k11_m+e15_m.^2).*(cos(x))+(C44_m.*k11_m+C55_m.*k22_m+2.*e15_m.*e24_m).*As.^2.*((cos(x)).^2).*((sin(x)).^2)+(C44_m.*k22_m+e24_m.^2).*As.^4.*((sin(x)).^4))).*(((cos(x)).^2).*(C55_m.*((cos(x)).^2)+C44_m.*As.^2.*((sin(x)).^2)));
G4411=-2*integral(g4411,0,2*pi);
 
g4422=@(x) (1./((C55_m.*k11_m+e15_m.^2).*(cos(x))+(C44_m.*k11_m+C55_m.*k22_m+2.*e15_m.*e24_m).*As.^2.*((cos(x)).^2).*((sin(x)).^2)+(C44_m.*k22_m+e24_m.^2).*As.^4.*((sin(x)).^4))).*(As.^2.*((sin(x)).^2).*(C55_m.*((cos(x)).^2)+C44_m.*As.^2.*((sin(x)).^2)));
G4422=-2*integral(g4422,0,2*pi);



%% the eshelby tensors

S=zeros(9);

S1111=(1/(4*pi))*(C11_m*G1111+C21_m*G1221);
S(1,1)=S1111;

S1122=(1/(4*pi))*(C12_m*G1111+C22_m*G1221);
S(1,2)=S1122;

S1133=(1/(4*pi))*(C13_m*G1111+C23_m*G1221);
S(1,3)=S1133;

S1143=(1/(4*pi))*(e31_m*G1111+e32_m*G1221);
S(1,9)=S1143;

S2211=(1/(4*pi))*(C11_m*G2112+C21_m*G2222);
S(2,1)=S2211;

S2222=(1/(4*pi))*(C11_m*G2112+C22_m*G2222);
S(2,2)=S2222;

S2233=(1/(4*pi))*(C13_m*G2112+C23_m*G2222);
S(2,3)=S2233;

S2243=(1/(4*pi))*(e31_m*G2112+e32_m*G2222);
S(2,9)=S2243;

S3311=0;
S(3,1)=S3311;

S3322=0;
S(3,1)=S3322;

S3333=0;
S(3,3)=S3333;

S3343=0;
S(3,9)=S3343;

S2323=(1/(8*pi))*(C44_m*G3322+e24_m*G3422);
S(4,4)=S2323;

S2342=(1/(8*pi))*(e24_m*G3322-k22_m*G3422);
S(4,8)=S2342;

S1313=(1/(8*pi))*(C55_m*G3311+e15_m*G3411);
S(5,5)=S1313;

S1341=(1/(8*pi))*(e15_m*G3311-k11_m*G3411);
S(5,7)=S1341;

S1212=(1/(8*pi))*(C66_m*(G1212+G2211+G1122+G2121));
S(6,6)=S1212;

S4113=(1/(4*pi))*(C55_m*G4311+e15_m*G4411);
S(7,5)=S4113;

S4141=(1/(4*pi))*(e15_m*G4311-k11_m*G4411);
S(7,7)=S4141;

S4223=(1/(4*pi))*(C44_m*G4322+e24_m*G4422);
S(8,4)=S4223;

S4242=(1/(4*pi))*(e24_m*G4322-k22_m*G4422);
S(8,8)=S4242;

S4311=0;
S(9,1)=S4311;

S4322=0;
S(9,2)=S4322;

S4333=0;
S(9,3)=S4333;

S4343=0;
S(9,9)=S4343;
fileID = fopen('PVDF_PZT_eshelby_ellipsoidal_by_huang.xls','w');
fprintf(fileID,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'vf', 'E1[GPa]', 'E2[GPa]', 'E3[GPa]', 'G23[GPa]', 'G13[GPa]', 'G12[GPa]', 'nu23', 'nu13', 'nu12', 'd31[C/GN]', 'd32[pC/N]', 'd33[pC/N]', 'd15[pC/N]', 'd24[pC/N]', 'k11','k22','k33');

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







