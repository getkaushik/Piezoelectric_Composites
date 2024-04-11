%incremental self consistent scheme cicular cylinder
clc
clear all
close all
format long
alpha=2;% aspect ratio a1./a2









header2 = {'vf', 'E1[GPa]', 'E2[GPa]', 'E3[GPa]', 'G23[GPa]', 'G13[GPa]',...
    'G12[GPa]', 'nu23', 'nu13', 'nu12', 'd31[pC/N]', 'd32[pC/N]',...
    'd33[pC/N]', 'd15[pC/N]', 'd24[pC/N]', 'k11','k22','k33'};
filename2='Elliptic_cylinder_Self_Consistent_Properties.xls';
xlswrite(filename2,header2,1,'A1');

header3 = {'total_vf', 'C11', 'C12', 'C13', 'C22', 'C23',...
    'C33', 'C44', 'C55', 'C66', 'e31[C/m2]', 'e32[C/m2]',...
    'e33[C/m2]', 'e15[C/m2]', 'e24[C/m2]', 'k11','k22','k33'};
xlswrite(filename2,header3,2,'A1');






%vf=0.9;% volume fraction of reinforcement

count_vf=1;
for vf = 0:0.01:1
    steps = 100; % Maximum No. of steps
    del_f = vf/steps; %Increment of volume fraction
    %% Material properties of PVDF (matrix)
    e0 = 8.85418782e-12; % Permittivity of free space, Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
    C11_m=3.8e9;% units in Pa,Component of stiffness matrix
    C12_m=1.9e9;% units in Pa,Component of stiffness matrix
    C13_m=1e9;% units in Pa,Component of stiffness matrix
    C31_m=C13_m;
    C21_m=C12_m;
    C22_m=3.2e9;% units in Pa,Component of stiffness matrix
    C23_m=0.9e9;% units in Pa,Component of stiffness matrix
    C32_m=C23_m;
    C33_m=1.2e9;% units in Pa,Component of stiffness matrix
    C44_m=0.7e9;% units in Pa,Component of stiffness matrix
    C55_m=0.9e9;% unitss in Pa,Component of stiffness matrix
    C66_m=0.9e9;% units in Pa,Component of stiffness matrix
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
    %% Material Properties of PZT-7A (reinforcement)
    C11_f=148e9;% units in Pa,Component of stiffness matrix
    C12_f=76.2e9;% units in Pa,Component of stiffness matrix
    C13_f=74.2e9;% units in Pa,Component of stiffness matrix
    C22_f=148e9;% units in Pa,Component of stiffness matrix
    C23_f=74.2e9;% units in Pa,Component of stiffness matrix
    C33_f=131e9;% units in Pa,Component of stiffness matrix
    C44_f=25.4e9;% units in Pa,Component of stiffness matrix
    C55_f=25.4e9;% unitss in Pa,Component of stiffness matrix
    C66_f=35.9e9;% units in Pa,Component of stiffness matrix
    k11_f=460.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
    k22_f=460.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
    k33_f=235.*e0;% Component of dielectric modulus matrix,Units m.^(-3).kg.^(-1).sec.^4.Amp.^2
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
             0, 0, 0, 0, e15_f, 0, -k11_f, 0, 0;
             0, 0, 0, e24_f, 0, 0, 0, -k22_f, 0;
             e31_f, e32_f, e33_f, 0, 0, 0, 0, 0,-k33_f];

         
   header1={'total_vf','steps','del_f_i', 'C11[GPa]', 'C12[GPa]', 'C13[GPa]', 'C22[GPa]', 'C23[GPa]',...
    'C33[GPa]', 'C44[GPa]', 'C55[GPa]', 'C66[GPa]', 'e31[C/m2]', 'e32[C/m2]',...
    'e33[C/m2]', 'e15[C/m2]', 'e24[C/m2]', 'k11','k22','k33'};
    filename1='Elliptic_cylinder_Matrix_properties_different_volume_fractions.xls';
    xlswrite(filename1,header1,count_vf,'A1');      
   
    %% Calculating the properties of the effective matrix
    I=eye(9);
    A = zeros(9,9); % inititiate concentration tensor matrix
    S = zeros(9,9); % initi
    for i=1:steps
        %VF = i*del_f;
        del_f_i=(del_f)/(1-((i-1)*del_f));%final increment volume raction
        

        %%since the inclusion is oriented along x3 axis and is infinitely long
%%along x3 axis beta=0, x3=0

 %%
 %zeroes
		I1311=0;I3111=I1311;
		I1312=0;I1321=I1312;;I3112=I1312;I3121=I1312;
		I1313=0;I1331=I1313;I3113=I1313;I3131=I1313;
		I1314=0;I1341=I1314;I3114=I1314;I3141=I1314;
		I1322=0;I3122=I1322;
		I1323=0;I1332=I1323;I3123=I1323;I3132=I1323;
		I1324=0;I1342=I1324;I3124=I1324;I3142=I1324;
		I1333=0;I3133=I1333;
		I1334=0;I1343=I1334;I3134=I1334;I3143=I1334;
		I1344=0;I3144=I1344;
			 
		%%
		I2311=0;I3211=I2311;
		I2312=0;I2321=I2312;;I3212=I2312;I3221=I2312;
		I2313=0;I2331=I2313;I3213=I2313;I3231=I2313;
		I2314=0;I2341=I2314;I3214=I2314;I3241=I2314;
		I2322=0;I3222=I2322;
		I2323=0;I2332=I2323;I3223=I2323;I3232=I2323;
		I2324=0;I2342=I2324;I3224=I2324;I3242=I2324;
		I2333=0;I3233=I2333;
		I2334=0;I2343=I2334;I3234=I2334;I3243=I2334;
		I2344=0;I3244=I2344;

		%%
		I3311=0;
		I3312=0;I3321=I3312;
		I3313=0;I3331=I3313;
		I3314=0;I3341=I3314;
		I3322=0;
		I3323=0;I3332=I3323;
		I3324=0;I3342=I3324;
		I3333=0;
		I3334=0;I3343=I3334;
		I3344=0;

		%%
		syms theta phi y1 y2 y3
		 y1=sin(theta).*cos(phi);   
		 y2=sin(theta).*sin(phi);
		 y3=cos(theta);
		%%
		 aa_11=(C22_m*alpha^2*y2^2 + C66_m*y1^2)/(C11_m*C66_m*y1^4 + C22_m*C66_m*alpha^4*y2^4 + C11_m*C22_m*alpha^2*y1^2*y2^2 - C12_m*C21_m*alpha^2*y1^2*y2^2 - C12_m*C66_m*alpha^2*y1^2*y2^2 - C21_m*C66_m*alpha^2*y1^2*y2^2);

		 
		i1111=matlabFunction(sin(theta).*(y1.^2).*aa_11,'vars',[theta,phi]) 
		I1111=integral2(i1111,0,pi,0,2.*pi)


		i1211=matlabFunction(sin(theta).*(y1.*alpha.*y2).*aa_11,'vars',[theta,phi]) 
		I1211=integral2(i1211,0,pi,0,2.*pi)
		I2111=I1211;



		i2211=matlabFunction((sin(theta).*alpha.*y2.*alpha.*y2).*aa_11,'vars',[theta,phi]) 
		I2211=integral2(i2211,0,pi,0,2.*pi)





		%%
		aa_22=(C66_m*alpha^2*y2^2 + C11_m*y1^2)/(C11_m*C66_m*y1^4 + C22_m*C66_m*alpha^4*y2^4 + C11_m*C22_m*alpha^2*y1^2*y2^2 - C12_m*C21_m*alpha^2*y1^2*y2^2 - C12_m*C66_m*alpha^2*y1^2*y2^2 - C21_m*C66_m*alpha^2*y1^2*y2^2);
		i1122=matlabFunction(sin(theta).*(y1.^2).*aa_22,'vars',[theta,phi]) 
		I1122=integral2(i1122,0,pi,0,2.*pi)


		i1222=matlabFunction((sin(theta).*y1.*alpha.*y2).*aa_22,'vars',[theta,phi]) 
		I1222=integral2(i1222,0,pi,0,2.*pi)
		I2122=I1222;



		i2222=matlabFunction((sin(theta).*alpha.*y2.*alpha.*y2).*aa_22,'vars',[theta,phi]) 
		I2222=integral2(i2222,0,pi,0,2.*pi)



		%%
		aa_33=(k22_m*alpha^2*y2^2 + k11_m*y1^2)/(e15_m^2*y1^4 + alpha^4*e24_m^2*y2^4 + C55_m*k11_m*y1^4 + C44_m*alpha^4*k22_m*y2^4 + C44_m*alpha^2*k11_m*y1^2*y2^2 + C55_m*alpha^2*k22_m*y1^2*y2^2 + 2*alpha^2*e15_m*e24_m*y1^2*y2^2);


		i1133=matlabFunction(sin(theta).*(y1.^2).*aa_33,'vars',[theta,phi]) 
		I1133=integral2(i1133,0,pi,0,2.*pi)


		i1233=matlabFunction(sin(theta).*(y1.*alpha.*y2).*aa_33,'vars',[theta,phi]) 
		I1233=integral2(i1233,0,pi,0,2.*pi)
		I2133=I1233;


		i2233=matlabFunction(sin(theta).*(alpha.*y2.*alpha.*y2).*aa_33,'vars',[theta,phi]) 
		I2233=integral2(i2233,0,pi,0,2.*pi)




		%%
		aa_44=-(C44_m*alpha^2*y2^2 + C55_m*y1^2)/(e15_m^2*y1^4 + alpha^4*e24_m^2*y2^4 + C55_m*k11_m*y1^4 + C44_m*alpha^4*k22_m*y2^4 + C44_m*alpha^2*k11_m*y1^2*y2^2 + C55_m*alpha^2*k22_m*y1^2*y2^2 + 2*alpha^2*e15_m*e24_m*y1^2*y2^2);

		i1144=matlabFunction(sin(theta).*(y1.^2).*aa_44,'vars',[theta,phi]) 
		I1144=integral2(i1144,0,pi,0,2.*pi)


		i1244=matlabFunction(sin(theta).*(y1.*alpha.*y2).*aa_44,'vars',[theta,phi]) 
		I1244=integral2(i1244,0,pi,0,2.*pi)
		I2144=I1244;


		i2244=matlabFunction(sin(theta).*(alpha.*y2.*alpha.*y2).*aa_44,'vars',[theta,phi]) 
		I2244=integral2(i2244,0,pi,0,2.*pi)



		%%
		aa_12=-(alpha*y1*y2*(C12_m + C66_m))/(C11_m*C66_m*y1^4 + C22_m*C66_m*alpha^4*y2^4 + C11_m*C22_m*alpha^2*y1^2*y2^2 - C12_m*C21_m*alpha^2*y1^2*y2^2 - C12_m*C66_m*alpha^2*y1^2*y2^2 - C21_m*C66_m*alpha^2*y1^2*y2^2);
		i1112=matlabFunction(sin(theta).*(y1.^2).*aa_12,'vars',[theta,phi]) 
		I1112=integral2(i1112,0,pi,0,2.*pi)
		I1121=I1112;

		i1212=matlabFunction(sin(theta).*(y1.*alpha.*y2).*aa_12,'vars',[theta,phi]) 
		I1212=integral2(i1212,0,pi,0,2.*pi)
		I1221=I1212;I2112=I1212;I2121=I1212;


		i2212=matlabFunction(sin(theta).*(alpha.*y2.*alpha.*y2).*aa_12,'vars',[theta,phi]) 
		I2212=integral2(i2212,0,pi,0,2.*pi)
		I2221=I2212;


		%%
		aa_13=0;
		I1113=0;
		I1131=I1113;


		I1213=0;
		I1231=I1213;I2113=I1213;I2131=I1213;




		I2213=0;
		I2231=I2213;



		%%
		aa_14=0;

		 
		I1114=0;
		I1141=I1114;


		I1214=0;
		I1241=I1214;I2114=I1214;I2141=I1214;

		 


		 
		I2214=0;
		I2241=I2214;





		%%

		aa_23=0;

		I1123=0;
		I1132=I1123;


		I1223=0;
		I1232=I1223;I2123=I1223;I2132=I1223;




		I2223=0;
		I2232=I2223;


		%%

		aa_24=0;


		I1124=0;
		I1142=I1124;


		I1224=0;
		I1242=I1224;I2124=I1224;I2142=I1224;



		I2224=0;
		I2242=I2224;

		 
		%%


		aa_34=0;

		 
		I1134=0;
		I1143=I1134;


		I1234=0;
		I1243=I1234;I2134=I1234;I2143=I1234;



		I2234=0;
		I2243=I2234;

		
		
		
        %% Components of the piezolectric Eshelby tensor for an orthtropic matrix
        S=zeros(9);% Initiate the Eshelby tensors

        S1111=(1/(4*pi))*(C11_m*I1111+C21_m*I2112+C13_m*I3113+e31_m*I3114)
        S(1,1)=S1111;

        S1122=(1/(4*pi))*(C12_m*I1111+C22_m*I2112+C32_m*I3113+e32_m*I3114)
        S(1,2)=S1122;

        S1133=(1/(4*pi))*(C13_m*I1111+C23_m*I2112+C33_m*I3113+e33_m*I3114)
        S(1,3)=S1133;

        S1123=(1/(4*pi))*(C44_m*(I2113+I3112)+e24_m*I2114)
        S(1,4)=S1123;

        S1113=(1/(4*pi))*(C55_m*(I1113+I3111)+e15_m*I1114);
        S(1,5)=S1113;

        S1112=(1/(4*pi))*(C66_m*(I2111+I1112));
        S(1,6)=S1112;

        S1141=(1/(4*pi))*(e15_m*(I1113+I3111)-k11_m*I1114);
        S(1,7)=S1141;

        S1142=(1/(4*pi))*(e24_m*(I2113+I3112)-k22_m*I2114)'
        S(1,8)=S1142;

        S1143=(1/(4*pi))*(e31_m*I1111+e32_m*I2112+e33_m*I3113-k33_m*I3114);
        S(1,9)=S1143;

        S2211=(1/(4*pi))*(C11_m*I1221+C21_m*I2222+C31_m*I3223+e31_m*I3224);
        S(2,1)=S2211;

        S2222=(1/(4*pi))*(C12_m*I1221+C22_m*I2222+C32_m*I3223+e32_m*I3224)
        S(2,2)=S2222;

        S2233=(1/(4*pi))*(C13_m*I1221+C23_m*I2222+C33_m*I3223+e33_m*I3224)
        S(2,3)=S2211;

        S2223=(1/(4*pi))*(C44_m*(I2223+I3222)+e24_m*I2224)
        S(2,4)=S2223;

        S2213=(1/(4*pi))*(C55_m*(I1223+I3221)+e15_m*I1224)
        S(2,5)=S2213;

        S2212=(1/(4*pi))*(C66_m*(I1222+I2221));
        S(2,6)=S2212;

        S2241=(1/(4*pi))*(e15_m*(I1223+I3221)-k11_m*I1224)
        S(2,7)=S2241;

        S2242=(1/(4*pi))*(e24_m*(I2223+I3222)-k22_m*I2224)
        S(2,8)=S2242;

        S2243=(1/(4*pi))*(e31_m*I1221+e32_m*I2222+e33_m*I3223-k33_m*I3224)
        S(2,9)=S2243;

        S3311=(1/(4*pi))*(C11_m*I1331+C21_m*I2332+C31_m*I3333+e31_m*I3334)
        S(3,1)=S3311;

        S3322=(1/(4*pi))*(C12_m*I1331+C22_m*I2332+C32_m*I3333+e32_m*I3334)
        S(3,2)=S3322;

        S3333=(1/(4*pi))*(C13_m*I1331+C23_m*I2332+C33_m*I3333+e33_m*I3334)
        S(3,3)=S3333;

        S3323=(1/(4*pi))*(C44_m*(I2333+I2332)+e24_m*I2334)
        S(3,4)=S3323;

        S3313=(1/(4*pi))*(C55_m*(I1333+I3331)+e15_m*I1334)
        S(3,5)=S3313;

        S3312=(1/(4*pi))*(C66_m*(I1332+I2331))
        S(3,6)=S3312;

        S3341=(1/(4*pi))*(e15_m*(I1333+I3331)-k11_m*I1334)
        S(3,7)=S3341;

        S3342=(1/(4*pi))*(e24_m*(I2333+I3332)-k22_m*I2334)
        S(3,8)=S3342;

        S3343=(1/(4*pi))*(e31_m*I1331+e32_m*I2332+e33_m*I3333-k33_m*I3334)
        S(3,9)=S3343;

        S2311=(1/(8*pi))*(C11_m*(I1321+I1231)+C21_m*(I2322+I2232)+C31_m*(I3323+I3233)+e31_m*(I3324+I3234));
        S(4,1)=S2311;

        S2322=(1/(8*pi))*(C12_m*(I1321+I1231)+C22_m*(I2322+I2232)+C32_m*(I3323+I3233)+e32_m*(I3324+I3234))
        S(4,2)=S2322;

        S2333=(1/(8*pi))*(C13_m*(I1321+I1231)+C23_m*(I2322+I2232)+C33_m*(I3323+I3233)+e33_m*(I3324+I3234))
        S(4,3)=S2333;

        S2323=(1/(8*pi))*(C44_m*(I2233+I2323+I3232+I2322)+e24_m*(I2234+I2324));
        S(4,4)=S2323;

        S2313=(1/(8*pi))*(C55_m*(I1323+I1233+I3321+I3231)+e15_m*(I1324+I1234));
        S(4,5)=S2313;

        S2312=(1/(8*pi))*(C66_m*(I1322+I1232+I2321+I2231));
        S(4,6)=S2312;

        S2341=(1/(8*pi))*(e15_m*(I1323+I1233+I3321+I3231)-k11_m*(I3321+I3231))
        S(4,7)=S2341;

        S2342=(1/(8*pi))*(e24_m*(I2233+I2323+I3232+I2322)-k22_m*(I2234+I2324))
        S(4,8)=S2342;

        S2343=(1/(8*pi))*(e31_m*(I1321+I1231)+e32_m*(I2322+I2232)+e33_m*(I3323+I3233)-k33_m*(I3324+I3234))
        S(4,9)=S2343;

        S1311=(1/(8*pi))*(C11_m*(I1311+I1131)+C21_m*(I2312+I2132)+C31_m*(I3313+I3133)+e31_m*(I3314+I3134))
        S(5,1)=S1311;

        S1322=(1/(8*pi))*(C12_m*(I1311+I1131)+C22_m*(I2312+I2132)+C32_m*(I3313+I3133)+e32_m*(I3314+I3134))
        S(5,2)=S1322;

        S1333=(1/(8*pi))*(C13_m*(I1311+I1131)+C23_m*(I2312+I2132)+C33_m*(I3313+I3133)+e33_m*(I3314+I3134))
        S(5,3)=S1333;

        S1323=(1/(8*pi))*(C44_m*(I2313+I2132+I3312+I3132)+e24_m*(I2314+I2134));
        S(5,4)=S1323;

        S1313=(1/(8*pi))*(C55_m*(I1133+I1313+I3131+I3311)+e15_m*(I1134+I1314));
        S(5,5)=S1313;

        S1312=(1/(8*pi))*(C66_m*(I1312+I1132+I2311+I2131));
        S(5,6)=S1312;

        S1341=(1/(8*pi))*(e15_m*(I1133+I1313+I3131+I3311)-k11_m*(I1134+I1314))
        S(5,7)=S1341;

        S1342=(1/(8*pi))*(e24_m*(I2313+I2133+I3312+I3132)-k22_m*(I2314+I2134))
        S(5,8)=S1342;

        S1343=(1/(8*pi))*(e31_m*(I1311+I1131)+e32_m*(I2312+I2132)+e33_m*(I3313+I3133)-k33_m*(I3314+I3134))
        S(5,9)=S1343;

        S1211=(1/(8*pi))*(C11_m*(I1211+I1121)+C21_m*(I2212+I2122)+C31_m*(I3213+I3123)+e31_m*(I3214+I3124))
        S(6,1)=S1211;

        S1222=(1/(8*pi))*(C12_m*(I1211+I1121)+C22_m*(I2212+I2122)+C32_m*(I3213+I3123)+e32_m*(I3214+I3124))
        S(6,2)=S1222;

        S1233=(1/(8*pi))*(C13_m*(I1211+I1121)+C23_m*(I2212+I2122)+C33_m*(I3213+I3123)+e33_m*(I3214+I3124))
        S(6,3)=S1233;

        S1223=(1/(8*pi))*(C44_m*(I2213+I2123+I3212+I3122)+e24_m*(I2214+I2124));
        S(6,4)=S1223;

        S1213=(1/(8*pi))*(C55_m*(I1213+I1223+I3211+I3123)+e15_m*(I1214+I1224));
        S(6,5)=S1213;

        S1212=(1/(8*pi))*(C66_m*(I1122+I1212+I2121+I2211));
        S(6,6)=S1212;

        S1241=(1/(8*pi))*(e15_m*(I1213+I1123+I3211+I3121)-k11_m*(I1214+I1124));
        S(6,7)=S1241;

        S1242=(1/(8*pi))*(e24_m*(I2213+I2123+I3212+I3122)-k22_m*(I2214+I2124));
        S(6,8)=S1242;

        S1243=(1/(8*pi))*(e31_m*(I1211+I1121)+e32_m*(I2212+I2122)+e33_m*(I3213+I3123)-k33_m*(I3214+I3124))
        S(6,9)=S1242;

        S4111=(1/(4*pi))*(C11_m*I1141+C21_m*I2142+C31_m*I3143+e31_m*I3144);
        S(7,1)=S4111;

        S4122=(1/(4*pi))*(C12_m*I1141+C22_m*I2142+C32_m*I3143+e32_m*I3144);
        S(7,2)=S4122;

        S4133=(1/(4*pi))*(C13_m*I1141+C23_m*I2142+C33_m*I3143+e33_m*I3144)
        S(7,3)=S4133;

        S4123=(1/(4*pi))*(C44_m*(I2143+I3142)+e24_m*I2144)
        S(7,4)=S4123;

        S4113=(1/(4*pi))*(C55_m*(I1143+I3141)+e15_m*I1144);
        S(7,5)=S4113;

        S4112=(1/(4*pi))*(C66_m*(I1142+I2141))
        S(7,6)=S4112;

        S4141=(1/(4*pi))*(e15_m*(I1143+I3141)-k11_m*I1144)
        S(7,7)=S4141;

        S4142=(1/(4*pi))*(e24_m*(I2143+I3142)-k22_m*I2144);
        S(7,8)=S4142;

        S4143=(1/(4*pi))*(e31_m*I1141+e32_m*I2142+e33_m*I3143-k33_m*I3144);
        S(7,9)=S4143;

        S4211=(1/(4*pi))*(C11_m*I1241+C21_m*I2242+C31_m*I3243+e31_m*I3244);
        S(8,1)=S4211;

        S4222=(1/(4*pi))*(C12_m*I1241+C22_m*I2242+C32_m*I3243+e32_m*I3244);
        S(8,2)=S4222;

        S4233=(1/(4*pi))*(C13_m*I1241+C23_m*I2242+C33_m*I3243+e33_m*I3244);
        S(8,3)=S4233;

        S4223=(1/(4*pi))*(C44_m*(I2243+I3242)+e24_m*I2244);
        S(8,4)=S4223;

        S4213=(1/(4*pi))*(C55_m*I1243+e15_m*I1244+C55_m*I3241);
        S(8,5)=S4213;

        S4212=(1/(4*pi))*(C66_m*(I1242+I3241));
        S(8,6)=S4212;

        S4241=(1/(4*pi))*(e15_m*(I1243+I3241)-k11_m*I1244);
        S(8,7)=S4241;

        S4242=(1/(4*pi))*(e24_m*(I2243+I3242)-k22_m*I2244);
        S(8,8)=S4242;

        S4243=(1/(4*pi))*(e31_m*I1241+e32_m*I2242+e33_m*I3243-k33_m*I3244);
        S(8,9)=S4243;

        S4311= (1/(4*pi))*(C11_m*I1341+C21_m*I2342+C31_m*I3343+e31_m*I3344);
        S(9,1)=S4311;

        S4322=(1/(4*pi))*(C12_m*I1341+C22_m*I2342+C32_m*I3343+e32_m*I3344);
        S(9,2)=S4322;

        S4333=(1/(4*pi))*(C13_m*I1341+C23_m*I2342+C33_m*I3343+e33_m*I3344);
        S(9,3)=S4333;

        S4323=(1/(4*pi))*(C44_m*(I2343+I3342)+e24_m*I2344);
        S(9,4)=S4323;

        S4313=(1/(4*pi))*(C55_m*(I1343+I3341)+e15_m*I1344);
        S(9,5)=S4313;

        S4312=(1/(4*pi))*(C66_m*(I1342+I2341));
        S(9,6)=S4312;

        S4341=(1/(4*pi))*(e15_m*(I1343+I3341)-k11_m*I1344);
        S(9,7)=S4341;

        S4342=(1/(4*pi))*(e24_m*(e24_m*(I2343+I3342)-k22_m*I2344));
        S(9,8)=S4342;

        S4343=(1/(4*pi))*(e31_m*I1341+e32_m*I2342+e33_m*I3343-k33_m*I3344);
        S(9,9)=S4343;
        %%
        data1 = [vf,i, del_f_i, C11_m, C12_m, C13_m, C22_m, C23_m, C33_m, C44_m,...
            C55_m, C66_m, e31_m, e32_m, e33_m, e15_m, e24_m,...
            k11_m/e0,k22_m/e0,k33_m/e0];
        row_file1 = sprintf('A%d',i+1);
        xlswrite(filename1,data1,count_vf,row_file1);

        A=inv(I+S*inv(E_m)*(E_f-E_m));
        E_comp = E_m + del_f_i*(E_f-E_m)*A;
        C11_m=E_comp(1,1);
        C12_m=E_comp(1,2);
        C13_m=E_comp(1,3);
        C21_m=E_comp(2,1);
        C22_m=E_comp(2,2);
        C23_m=E_comp(2,3);
        C31_m=E_comp(3,1);
        C32_m=E_comp(3,2);
        C33_m=E_comp(3,3);
        C44_m=E_comp(4,4);
        C55_m=E_comp(5,5);
        C66_m=E_comp(6,6);
        k11_m=-E_comp(7,7);
        k22_m=-E_comp(8,8);
        k33_m=-E_comp(9,9);
        e15_m=E_comp(7,5);
        e24_m=E_comp(8,4);
        e31_m=E_comp(9,1);
        e32_m=E_comp(9,2);
        e33_m=E_comp(9,3);
        E_m=[C11_m,C12_m, C13_m, 0, 0, 0, 0, 0, e31_m;
             C12_m,C22_m, C23_m, 0, 0, 0, 0, 0, e32_m;
             C13_m,C23_m, C33_m, 0, 0, 0, 0, 0, e33_m;
             0, 0, 0, C44_m, 0, 0, 0, e15_m, 0;
             0, 0, 0, 0, C55_m, 0, e24_m, 0, 0;
             0, 0, 0, 0, 0, C66_m, 0, 0, 0;
             0, 0, 0, 0, e15_m, 0, -k11_m, 0, 0;
             0, 0, 0, e24_m, 0, 0, 0, -k22_m, 0;
             e31_m, e32_m, e33_m, 0, 0, 0, 0, 0,-k33_m];


         % fprintf(fileID,'%d\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'i','VF', 'C11[GPa]', 'C12[GPa]', 'C13[GPa]', 'C22[GPa]', 'C23[GPa]', 'C33[GPa]', 'C44[GPa]', 'C55[GPa]', 'C66[GPa]', 'e31[C/m2]', 'e32[C/m2]', 'e33[C/m2]', 'e15[C/m2]', 'e24[C/m2]', 'k11','k22','k33');
        fprintf('Step No. %d completed. del_f_i = %f. %d steps remaining. total volume fraction = %f.\n',i, del_f_i, (steps-i), vf)
    end
   
    %% Calculate common elastic, dielectric and piezoelectric properties of the composite

    C11_comp=E_comp(1,1);
    C12_comp=E_comp(1,2);
    C13_comp=E_comp(1,3);
    C21_comp=E_comp(2,1);
    C22_comp=E_comp(2,2);
    C23_comp=E_comp(2,3);
    C31_comp=E_comp(3,1);
    C32_comp=E_comp(3,2);
    C33_comp=E_comp(3,3);
    C44_comp=E_comp(4,4);
    C55_comp=E_comp(5,5);
    C66_comp=E_comp(6,6);

    e15_comp=E_comp(7,5);
    e24_comp=E_comp(8,4);
    e31_comp=E_comp(9,1);
    e32_comp=E_comp(9,2);
    e33_comp=E_comp(9,3);
    Cmatrix  = [C11_comp C12_comp C13_comp 0 0 0;
                C21_comp C22_comp C23_comp 0 0 0;
                C31_comp C32_comp C33_comp 0 0 0;
                 0 0 0 C44_comp 0 0;
                 0 0 0 0 C55_comp 0;
                 0 0 0 0 0 C66_comp];
    Smatrix = inv(Cmatrix);
    ematrix = [0 0 0 0 e15_comp 0;
               0 0 0 e24_comp 0 0;
              e31_comp e32_comp e33_comp 0 0 0];
    dmatrix = ematrix*Smatrix;
    E1_comp=(1/(Smatrix(1,1)));
    E2_comp=(1/(Smatrix(2,2)));
    E3_comp=(1/(Smatrix(3,3)));
    %
    G23_comp=(1/(Smatrix(4,4)));
    G13_comp=(1/(Smatrix(5,5)));
    G12_comp=(1/(Smatrix(6,6)));

    nu12_comp=-(E1_comp*Smatrix(1,2));
    nu13_comp=-(E1_comp*Smatrix(1,3));
    nu23_comp=-(E2_comp*Smatrix(2,3));

    k11_comp=-E_comp(7,7)/e0;
    k22_comp=-E_comp(8,8)/e0;
    k33_comp=-E_comp(9,9)/e0;

    d15_comp=dmatrix(1,5)/1e-12;
    d24_comp=dmatrix(2,4)/1e-12;
    d31_comp=dmatrix(3,1)/1e-12;
    d32_comp=dmatrix(3,2)/1e-12;
    d33_comp=dmatrix(3,3)/1e-12;

    %fprintf(fileID2,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'vf', 'E1[GPa]', 'E2[GPa]', 'E3[GPa]', 'G23[GPa]', 'G13[GPa]', 'G12[GPa]', 'nu23', 'nu13', 'nu12', 'd31[pC/N]', 'd32[pC/N]', 'd33[pC/N]', 'd15[pC/N]', 'd24[pC/N]', 'k11','k22','k33');
    data2 = [ vf, E1_comp, E2_comp, E3_comp, G23_comp, G13_comp,...
        G12_comp, nu23_comp, nu13_comp, nu12_comp, d31_comp,...
        d32_comp, d33_comp, d15_comp, d24_comp, k11_comp,...
        k22_comp,k33_comp];
    row_file2 = sprintf('A%d',count_vf+1);
    xlswrite(filename2,data2,1,row_file2);
	
	data3 = [vf, C11_comp, C12_comp, C13_comp, C22_comp, C23_comp, C33_comp, C44_comp,...
            C55_comp, C66_comp, e31_comp, e32_comp, e33_comp, e15_comp, e24_comp,...
            k11_comp,k22_comp,k33_comp];
    row_file3 = sprintf('A%d',count_vf+1);
    xlswrite(filename2,data3,2,row_file3);
    

	
	
	
	
    count_vf=count_vf+1;


    end
