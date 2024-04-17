e0 = 8.85418782e-12; % Permittivity of free space, Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
C11_m=3.8;% units in GPa,Component of stiffness matrix
C12_m=1.9;% units in GPa,Component of stiffness matrix
C13_m=1;% units in GPa,Component of stiffness matrix
C31_m=C13_m;
C21_m=C12_m;
C22_m=3.2;% units in GPa,Component of stiffness matrix
C23_m=0.9;% units in GPa,Component of stiffness matrix
C32_m=C23_m;
C33_m=1.2;% units in GPa,Component of stiffness matrix
C44_m=0.7;% units in GPa,Component of stiffness matrix
C55_m=0.9;% unitss in GPa,Component of stiffness matrix
C66_m=0.9;% units in GPa,Component of stiffness matrix
k11_m=7.4.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k22_m=9.3.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k33_m=7.6.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
e15_m=0;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_m=0;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_m=0.024;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_m=0.001;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_m=-0.027;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
E_m=     [C11_m,C12_m, C13_m, 0, 0, 0;
         C12_m,C22_m, C23_m, 0, 0, 0;
         C13_m,C23_m, C33_m, 0, 0, 0;
         0, 0, 0, C44_m, 0, 0 ;
         0, 0, 0, 0, C55_m, 0;
         0, 0, 0, 0, 0, C66_m];
        
     E_m;
     
     S_PVDF_compliance=inv(E_m);
 %  Material Properties of PZT-7A (reinforcement)
 C11_f=148;% units in GPa,Component of stiffness matrix
C12_f=76.2;% units in GPa,Component of stiffness matrix
C13_f=74.2;% units in GPa,Component of stiffness matrix
C22_f=148;% units in GPa,Component of stiffness matrix
C23_f=74.2;% units in GPa,Component of stiffness matrix
C33_f=131;% units in GPa,Component of stiffness matrix
C44_f=25.4;% units in GPa,Component of stiffness matrix
C55_f=25.4;% unitss in GPa,Component of stiffness matrix
C66_f=35.9;% units in GPa,Component of stiffness matrix
k1_f=460.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k2_f=460.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
k3_f=235.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
e15_f=9.2;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e24_f=9.2;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e31_f=-2.1;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e32_f=-2.1;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
e33_f=9.5;%units [C./m.^2], Component of coupling or piezolectric modulus matrix (in stress-charge form)
E_f=     [C11_f,C12_f, C13_f, 0, 0, 0;
         C12_f,C22_f, C23_f, 0, 0, 0;
         C13_f,C23_f, C33_f, 0, 0, 0;
         0, 0, 0, C44_f, 0, 0;
         0, 0, 0, 0, C55_f, 0;
         0, 0, 0, 0, 0, C66_f];
     S_PZT_compliance=inv(E_f);