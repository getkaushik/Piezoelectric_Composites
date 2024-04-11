# -*- coding: mbcs -*-
from part import *
from material import *
from section import *
from assembly import *
from step import *
from interaction import *
from load import *
from mesh import *
from optimization import *
from job import *
from odbAccess import *
from sketch import *
from visualization import *
from connectorBehavior import *
from abaqus import *
from abaqusConstants import *
import __main__
from caeModules import *
from odbAccess import *
from numpy import *
import math
import section
import regionToolset
import displayGroupMdbToolset as dgm
import part
import material
import assembly
import step
import interaction
import load
import mesh
import optimization
import job
import sketch
import visualization
import xyPlot
import displayGroupOdbToolset as dgo
import connectorBehavior
import os
import numpy

cwd = os.getcwd()
thickness = 5.0
vf = numpy.arange(0.001125,0.0165,0.001125)
vf_length=len(vf)
mesh_size = 6
file=open('Result_multiparticle_mixed_AR_ESO_BT_PANI_50nm_E22.txt','w')
file.write('Vol_Frac \t C21\t C22\t C23\t C24\t C25\t C26\t e12\t e22\t e32 \n')

for vol_frac,jjj in zip(vf,range(1,vf_length+1)):

    Max_x = 50.0
    Min_x = -50.0
    Max_y = 50.0
    Min_y = -50.0
    Max_z = 50.0
    Min_z =-50.0
    RVEvolume = (Max_x-Min_x)*(Max_y-Min_y)*(Max_z-Min_z)
    
    alpha = 1.3 #Aspect_ratio = alpha
    radius_H=((RVEvolume*vol_frac*3)/(4*alpha*(22/7)))**(1.0/3.0)
    H = (alpha*radius_H)
    
    
    beta = 1.15 #Aspect_ratio = alpha
    radius_G=((RVEvolume*vol_frac*3)/(4*beta*(22/7)))**(1.0/3.0)
    G = (beta*radius_G)
    
    theta = 1.0 #Aspect_ratio = alpha
    radius_T=((RVEvolume*vol_frac*3)/(4*theta*(22/7)))**(1.0/3.0)
    T = (theta*radius_T)
    
    nnn = str(vol_frac)
    nn = nnn[2:]
    print 'Volume Fraction=',vol_frac
    print 'RVE Volume =',RVEvolume
    print 'Aspect_ratio is ', alpha, beta, theta
    print 'Height is ', H, G, T
    print 'radius is ',radius_H, radius_G, radius_T
    
    cen = 0
    ModelName = 'Model-'+str(jjj)
    
    #Create Viewport 
    session.viewports['Viewport: 1'].setValues(displayedObject=None)
    s1 = mdb.models[ModelName].ConstrainedSketch(name='__profile__', sheetSize=360) 
    g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints 
    s1.setPrimaryObject(option=STANDALONE) 
   
    # MATRIX SECTION 
    s1.rectangle(point1=(50.0,-50.0), point2=(-50.0,50.0)) 
    p = mdb.models[ModelName].Part(name='Matrix', dimensionality=THREE_D,type=DEFORMABLE_BODY)
    p = mdb.models[ModelName].parts['Matrix']
    p.BaseSolidExtrude(sketch=s1, depth=100)
    s1.unsetPrimaryObject() 
    p = mdb.models[ModelName].parts['Matrix'] 
    session.viewports['Viewport: 1'].setValues(displayedObject=p) 
   
    # Reinforcemental_PARTICULATES SECTION 
    #Aspect ratio Alpha_H
    del mdb.models[ModelName].sketches['__profile__'] 
    s = mdb.models[ModelName].ConstrainedSketch(name='__profile__', sheetSize=120) 
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints 
    s.setPrimaryObject(option=STANDALONE) 
    s.ConstructionLine(point1=(-100, 0.0), point2=(100, 0.0)) 
    s.FixedConstraint(entity=g[2]) 
    s.EllipseByCenterPerimeter(center=(0.0, 0.0), axisPoint1=(H , 0.0), axisPoint2=(0.0, radius_H )) 
    s.Line(point1=(-H, 0.0), point2=(H , 0.0)) 
    s.autoTrimCurve(curve1=g[3], point1=(-0.0, radius_H )) 
    p = mdb.models[ModelName].Part(name='Reinforcement1', dimensionality=THREE_D,
       type=DEFORMABLE_BODY) 
    p = mdb.models[ModelName].parts['Reinforcement1'] 
    p.BaseSolidRevolve(sketch=s, angle=360.0, flipRevolveDirection=OFF)
    s.unsetPrimaryObject() 
    p = mdb.models[ModelName].parts['Reinforcement1'] 
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models[ModelName].sketches['__profile__'] 
    # Reinforcemental_PARTICULATES SECTION 
    #Aspect ratio Beta_G
    s = mdb.models[ModelName].ConstrainedSketch(name='__profile__', sheetSize=120) 
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints 
    s.setPrimaryObject(option=STANDALONE) 
    s.ConstructionLine(point1=(-100, 0.0), point2=(100, 0.0)) 
    s.FixedConstraint(entity=g[2]) 
    s.EllipseByCenterPerimeter(center=(0.0, 0.0), axisPoint1=(G , 0.0), axisPoint2=(0.0, radius_G )) 
    s.Line(point1=(-G, 0.0), point2=(G , 0.0)) 
    s.autoTrimCurve(curve1=g[3], point1=(-0.0, radius_G )) 
    p = mdb.models[ModelName].Part(name='Reinforcement2', dimensionality=THREE_D,
       type=DEFORMABLE_BODY) 
    p = mdb.models[ModelName].parts['Reinforcement2'] 
    p.BaseSolidRevolve(sketch=s, angle=360.0, flipRevolveDirection=OFF)
    s.unsetPrimaryObject() 
    p = mdb.models[ModelName].parts['Reinforcement2'] 
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    # Reinforcemental_PARTICULATES SECTION 
    #Aspect ratio Theta_T
    s = mdb.models[ModelName].ConstrainedSketch(name='__profile__', sheetSize=120) 
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints 
    s.setPrimaryObject(option=STANDALONE) 
    s.ConstructionLine(point1=(-100, 0.0), point2=(100, 0.0)) 
    s.FixedConstraint(entity=g[2]) 
    s.EllipseByCenterPerimeter(center=(0.0, 0.0), axisPoint1=(T , 0.0), axisPoint2=(0.0, radius_T )) 
    s.Line(point1=(-T, 0.0), point2=(T , 0.0)) 
    s.autoTrimCurve(curve1=g[3], point1=(-0.0, radius_T )) 
    p = mdb.models[ModelName].Part(name='Reinforcement3', dimensionality=THREE_D,
       type=DEFORMABLE_BODY) 
    p = mdb.models[ModelName].parts['Reinforcement3'] 
    p.BaseSolidRevolve(sketch=s, angle=360.0, flipRevolveDirection=OFF)
    s.unsetPrimaryObject() 
    p = mdb.models[ModelName].parts['Reinforcement3'] 
    session.viewports['Viewport: 1'].setValues(displayedObject=p)     
    del mdb.models[ModelName].sketches['__profile__']
    
    #AR_1.3
    mdb.models[ModelName].Part(name='Reinforcement4', objectToCopy=
        mdb.models[ModelName].parts['Reinforcement1'])
    
    #AR_1.15
    mdb.models[ModelName].Part(name='Reinforcement5', objectToCopy=
        mdb.models[ModelName].parts['Reinforcement2'])
    mdb.models[ModelName].Part(name='Reinforcement6', objectToCopy=
        mdb.models[ModelName].parts['Reinforcement2'])
   
   #AR_1.0 
    mdb.models[ModelName].Part(name='Reinforcement7', objectToCopy=
        mdb.models[ModelName].parts['Reinforcement3'])
    mdb.models[ModelName].Part(name='Reinforcement8', objectToCopy=
        mdb.models[ModelName].parts['Reinforcement3'])
    mdb.models[ModelName].Part(name='Reinforcement9', objectToCopy=
        mdb.models[ModelName].parts['Reinforcement3'])         

    #Interficial_Layer SECTION 

    #Aspect ratio Alpha_H
    s = mdb.models[ModelName].ConstrainedSketch(name='__profile__', sheetSize=120) 
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints 
    s.setPrimaryObject(option=STANDALONE) 
    s.ConstructionLine(point1=(-100, 0.0), point2=(100, 0.0)) 
    s.FixedConstraint(entity=g[2]) 
    s.EllipseByCenterPerimeter(center=(0.0, 0.0), axisPoint1=(H+thickness , 0.0), axisPoint2=(0.0, radius_H+thickness )) 
    s.Line(point1=(-(H+thickness), 0.0), point2=(H+thickness , 0.0)) 
    s.autoTrimCurve(curve1=g[3], point1=(-0.0, radius_H+thickness )) 
    p = mdb.models[ModelName].Part(name='Interphase1', dimensionality=THREE_D,
       type=DEFORMABLE_BODY) 
    p = mdb.models[ModelName].parts['Interphase1'] 
    p.BaseSolidRevolve(sketch=s, angle=360.0, flipRevolveDirection=OFF)
    s.unsetPrimaryObject() 
    p = mdb.models[ModelName].parts['Interphase1'] 
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models[ModelName].sketches['__profile__'] 
    # Interficial_Layer SECTION 
    
    #Aspect ratio Beta_G
    s = mdb.models[ModelName].ConstrainedSketch(name='__profile__', sheetSize=120) 
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints 
    s.setPrimaryObject(option=STANDALONE) 
    s.ConstructionLine(point1=(-100, 0.0), point2=(100, 0.0)) 
    s.FixedConstraint(entity=g[2]) 
    s.EllipseByCenterPerimeter(center=(0.0, 0.0), axisPoint1=(G+thickness , 0.0), axisPoint2=(0.0, radius_G+thickness )) 
    s.Line(point1=(-(G+thickness), 0.0), point2=(G+thickness , 0.0)) 
    s.autoTrimCurve(curve1=g[3], point1=(-0.0, radius_G+thickness )) 
    p = mdb.models[ModelName].Part(name='Interphase2', dimensionality=THREE_D,
       type=DEFORMABLE_BODY) 
    p = mdb.models[ModelName].parts['Interphase2'] 
    p.BaseSolidRevolve(sketch=s, angle=360.0, flipRevolveDirection=OFF)
    s.unsetPrimaryObject() 
    p = mdb.models[ModelName].parts['Interphase2'] 
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    # Interficial_Layer SECTION 
    
    #Aspect ratio Theta_T
    s = mdb.models[ModelName].ConstrainedSketch(name='__profile__', sheetSize=120) 
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints 
    s.setPrimaryObject(option=STANDALONE) 
    s.ConstructionLine(point1=(-100, 0.0), point2=(100, 0.0)) 
    s.FixedConstraint(entity=g[2]) 
    s.EllipseByCenterPerimeter(center=(0.0, 0.0), axisPoint1=(T+thickness , 0.0), axisPoint2=(0.0, radius_T+thickness )) 
    s.Line(point1=(-(T+thickness), 0.0), point2=(T+thickness , 0.0)) 
    s.autoTrimCurve(curve1=g[3], point1=(-0.0, radius_T+thickness )) 
    p = mdb.models[ModelName].Part(name='Interphase3', dimensionality=THREE_D,
       type=DEFORMABLE_BODY) 
    p = mdb.models[ModelName].parts['Interphase3'] 
    p.BaseSolidRevolve(sketch=s, angle=360.0, flipRevolveDirection=OFF)
    s.unsetPrimaryObject() 
    p = mdb.models[ModelName].parts['Interphase3'] 
    session.viewports['Viewport: 1'].setValues(displayedObject=p)     
    del mdb.models[ModelName].sketches['__profile__']
    
    #AR_1.3
    mdb.models[ModelName].Part(name='Interphase4', objectToCopy=
        mdb.models[ModelName].parts['Interphase1'])
    
    #AR_1.15
    mdb.models[ModelName].Part(name='Interphase5', objectToCopy=
        mdb.models[ModelName].parts['Interphase2'])
    mdb.models[ModelName].Part(name='Interphase6', objectToCopy=
        mdb.models[ModelName].parts['Interphase2'])
   
   #AR_1.0 
    mdb.models[ModelName].Part(name='Interphase7', objectToCopy=
        mdb.models[ModelName].parts['Interphase3'])
    mdb.models[ModelName].Part(name='Interphase8', objectToCopy=
        mdb.models[ModelName].parts['Interphase3'])
    mdb.models[ModelName].Part(name='Interphase9', objectToCopy=
        mdb.models[ModelName].parts['Interphase3'])  

    
    # Saved by Kabir Baidya 21/07/2022
    
    
    # material properties ESO matrix {Isotropic}
    # Stiffness Matrix of matrix in the absence of applied electric field
    # E_m = Youngs modulus of matrix
    # nu_m = Poisson's ratio of matrix
    # K_m = Dielectric constant of matrix
    E_m = 34.0*(10**6) #Units Pa
    nu_m = 0.4
    K_m = 3.38
    e_0 = 8.8542*(10**(-12)) # Units F/m
    C_m11 = (E_m*(1-nu_m))/((1+nu_m)*(1-(2*nu_m))) # Units Pa    
    C_m12 = (E_m*nu_m)/((1+nu_m)*(1-(2*nu_m))) # Units Pa
    C_m13 = C_m12 # Units Pa
    C_m14 = 0 # Units Pa
    C_m15 = 0 # Units Pa
    C_m16 = 0 # Units Pa
    C_m22 = C_m11 # Units Pa
    C_m23 = C_m12 # Units Pa
    C_m24 = 0 # Units Pa
    C_m25 = 0 # Units Pa
    C_m26 = 0 # Units Pa
    C_m33 = C_m11 # Units Pa
    C_m34 = 0 # Units Pa
    C_m35 = 0 # Units Pa
    C_m36 = 0 # Units Pa
    C_m44 = (C_m11-C_m12)/2 # Units Pa
    C_m45 = 0 # Units Pa
    C_m46 = 0 # Units Pa
    C_m55 = (C_m11-C_m12)/2 # Units Pa # Units Pa
    C_m56 = 0 # Units Pa
    C_m66 = (C_m11-C_m12)/2 # Units Pa
    # Piezoelectric stress-coefficient matrix
    e_m11 = 0 # Units C/(m**2)
    e_m12 = 0 # Units C/(m**2)
    e_m13 = 0 # Units C/(m**2)
    e_m14 = 0 # Units C/(m**2)
    e_m15 = 0 # Units C/(m**2)
    e_m16 = 0 # Units C/(m**2)
    e_m21 = 0 # Units C/(m**2)
    e_m22 = 0 # Units C/(m**2)
    e_m23 = 0 # Units C/(m**2)
    e_m24 = 0 # Units C/(m**2)
    e_m25 = 0 # Units C/(m**2)
    e_m26 = 0 # Units C/(m**2)
    e_m31 = 0 # Units C/(m**2)
    e_m32 = 0 # Units C/(m**2)
    e_m33 = 0 # Units C/(m**2)
    e_m34 = 0 # Units C/(m**2)
    e_m35 = 0 # Units C/(m**2)
    e_m36 = 0 # Units C/(m**2)
    # Dielectric matrix of matrix
    K_m11 = (K_m*e_0) # Units F/m
    K_m12 = 0 # Units C/(V.m)
    K_m13 = 0 # Units C/(V.m)
    K_m22 = (K_m*e_0) # Units F/m
    K_m23 = 0 # Units C/(V.m)
    K_m33 = (K_m*e_0) # Units F/m
    
    # Reinforcement: BT {Transversely Isotropic}
    # Stiffness Matrix of Reinforcement in the absence of applied electric field
    C_f11 = 2.75121*(10**11) # Units Pa
    C_f12 = 1.78967*(10**11) # Units Pa
    C_f13 = 1.51555*(10**11) # Units Pa
    C_f14 = 0 # Units Pa
    C_f15 = 0 # Units Pa
    C_f16 = 0 # Units Pa
    C_f22 = 2.75121*(10**11) # Units Pa
    C_f23 = 1.51555*(10**11) # Units Pa
    C_f24 = 0 # Units Pa
    C_f25 = 0 # Units Pa
    C_f26 = 0 # Units Pa
    C_f33 = 1.6486*(10**11) # Units Pa
    C_f34 = 0 # Units Pa
    C_f35 = 0 # Units Pa
    C_f36 = 0 # Units Pa
    C_f44 = 5.43478*(10**10) # Units Pa
    C_f45 = 0 # Units Pa
    C_f46 = 0 # Units Pa
    C_f55 = 5.43478*(10**10) # Units Pa
    C_f56 = 0 # Units Pa
    C_f66 = 1.13122*(10**11) # Units Pa
    # Piezoelectric stress-coefficient matrix of reinforcement
    e_f11 = 0 # Units C/(m**2)
    e_f12 = 0 # Units C/(m**2)
    e_f13 = 0 # Units C/(m**2)
    e_f14 = 0 # Units C/(m**2)
    e_f15 = 21.3043 # Units C/(m**2)
    e_f16 = 0 # Units C/(m**2)
    e_f21 = 0 # Units C/(m**2)
    e_f22 = 0 # Units C/(m**2)
    e_f23 = 0 # Units C/(m**2)
    e_f24 = 21.3043 # Units C/(m**2)
    e_f25 = 0 # Units C/(m**2)
    e_f26 = 0 # Units C/(m**2)
    e_f31 = -2.69289 # Units C/(m**2)
    e_f32 = -2.69289 # Units C/(m**2)
    e_f33 = 3.65468 # Units C/(m**2)
    e_f34 = 0 # Units C/(m**2)
    e_f35 = 0 # Units C/(m**2)
    e_f36 = 0 # Units C/(m**2)
    # Dielectric matrix of reinforcement
    K_f11 = 1750.3*(10**(-11)) # Units F/m
    K_f12 = 0 # Units C/(V.m)
    K_f13 = 0 # Units C/(V.m)
    K_f22 = 1750.3*(10**(-11)) # Units F/m
    K_f23 = 0 # Units C/(V.m)
    K_f33 = 98.9*(10**(-11))# Units F/m
    
    ## Interphase Material (Polyaniline)
    # Stiffness Matrix of interphase in the absence of applied electric field
    
    C_11 = 1.685*(10**9)  # Units Pa
    C_12 = 1.033*(10**9)  # Units Pa
    C_13 = 1.033*(10**9)  # Units Pa
    C_14 = 0 # Units Pa
    C_15 = 0 # Units Pa
    C_16 = 0 # Units Pa
    C_22 = 1.685*(10**9)  # Units Pa
    C_23 = 1.033*(10**9)  # Units Pa
    C_24 = 0 # Units Pa
    C_25 = 0 # Units Pa
    C_26 = 0 # Units Pa
    C_33 = 1.685*(10**9) # Units Pa
    C_34 = 0 # Units Pa
    C_35 = 0 # Units Pa
    C_36 = 0 # Units Pa
    C_44 = 3.261*(10**8)  # Units Pa
    C_45 = 0 # Units Pa
    C_46 = 0 # Units Pa
    C_55 = 3.261*(10**8)  # Units Pa
    C_56 = 0 # Units Pa
    C_66 = 3.261*(10**8)  # Units Pa
    # Piezoelectric stress-coefficient matrix
    e_11 = 0 # Units C/(m**2)
    e_12 = 0 # Units C/(m**2)
    e_13 = 0 # Units C/(m**2)
    e_14 = 0 # Units C/(m**2)
    e_15 = 0 # Units C/(m**2)
    e_16 = 0 # Units C/(m**2)
    e_21 = 0 # Units C/(m**2)
    e_22 = 0 # Units C/(m**2)
    e_23 = 0 # Units C/(m**2)
    e_24 = 0 # Units C/(m**2)
    e_25 = 0 # Units C/(m**2)
    e_26 = 0 # Units C/(m**2)
    e_31 = 0 # Units C/(m**2)
    e_32 = 0 # Units C/(m**2)
    e_33 = 0 # Units C/(m**2)
    e_34 = 0 # Units C/(m**2)
    e_35 = 0 # Units C/(m**2)
    e_36 = 0 # Units C/(m**2)
    # Dielectric matrix of interphase
    K_11 = 7.88*(10**(-11)) # Units F/m
    K_12 = 0 # Units C/(V.m)
    K_13 = 0 # Units C/(V.m)
    K_22 = 7.88*(10**(-11)) # Units F/m
    K_23 = 0 # Units C/(V.m)
    K_33 = 7.88*(10**(-11)) # Units F/m 
    
    session.viewports['Viewport: 1'].partDisplay.setValues(sectionAssignments=ON, 
        engineeringFeatures=ON)
    session.viewports['Viewport: 1'].partDisplay.geometryOptions.setValues(
        referenceRepresentation=OFF)
        
    mdb.models[ModelName].Material(name='ESO')
    mdb.models[ModelName].materials['ESO'].Piezoelectric(table=((e_m11, e_m12, e_m13, e_m16, e_m15, e_m14, e_m21, e_m22, e_m23, e_m26, e_m25, e_m24, e_m31, e_m32, e_m33, e_m36, e_m35, e_m34), ))
    mdb.models[ModelName].materials['ESO'].Elastic(type=ANISOTROPIC, table=((C_m11, C_m12, C_m22, C_m13, C_m23, C_m33, C_m16, C_m26, C_m36, C_m66, C_f15, C_f25, C_m35, C_m56, C_m55, C_m14, C_m24, C_m34, C_m46, C_m45, C_m44), ))
    mdb.models[ModelName].materials['ESO'].Dielectric(type=ANISOTROPIC, table=((K_m11, K_m12, K_m22, K_m13, K_m23, K_m33), ))
    mdb.models[ModelName].Material(name='BT')
    mdb.models[ModelName].materials['BT'].Piezoelectric(table=((e_f11, e_f12, e_f13, e_f16, e_f15, e_f14, e_f21, e_f22, e_f23, e_f26, e_f25, e_f24, e_f31, e_f32, e_f33, e_f36, e_f35, e_f34), ))
    mdb.models[ModelName].materials['BT'].Elastic(type=ANISOTROPIC, table=((C_f11, C_f12, C_f22, C_f13, C_f23, C_f33, C_f16, C_f26, C_f36, C_f66, C_f15, C_f25, C_f35, C_f56, C_f55, C_f14, C_f24, C_f34, C_f46, C_f45, C_f44), ))
    mdb.models[ModelName].materials['BT'].Dielectric(type=ANISOTROPIC,table=((K_f11, K_f12, K_f22, K_f13, K_f23, K_f33), ))
    mdb.models[ModelName].Material(name='Interphase')
    mdb.models[ModelName].materials['Interphase'].Piezoelectric(table=((e_11, e_12, e_13, e_16, e_15, e_14, e_21, e_22, e_23, e_26, e_25, e_24, e_31, e_32, e_33, e_36, e_35, e_34), ))
    mdb.models[ModelName].materials['Interphase'].Elastic(type=ANISOTROPIC, table=((C_11, C_12, C_22, C_13, C_23, C_33, C_16, C_26, C_36, C_66, C_15, C_25, C_35, C_56, C_55, C_14, C_24, C_34, C_46, C_45, C_44), ))
    mdb.models[ModelName].materials['Interphase'].Dielectric(type=ANISOTROPIC,table=((K_11, K_12, K_22, K_13, K_23, K_33), ))     
    
    #create sections
    mdb.models[ModelName].HomogeneousSolidSection(material='ESO', name=
        'Matrixsection', thickness=None)
    mdb.models[ModelName].HomogeneousSolidSection(material='BT', name=
        'Fibersection', thickness=None)
    mdb.models[ModelName].HomogeneousSolidSection(material='Interphase', name=
        'Interphasesection', thickness=None)
        
    mdb.models[ModelName].rootAssembly.DatumCsysByDefault(CARTESIAN)
    
    #Sction Assignment
    mdb.models[ModelName].parts['Matrix'].Set(cells=
        mdb.models[ModelName].parts['Matrix'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='MatrixSet')
    mdb.models[ModelName].parts['Matrix'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Matrix'].sets['MatrixSet'], sectionName=
        'Matrixsection', thicknessAssignment=FROM_SECTION)

    ## Reiforcement Section Assignent
    mdb.models[ModelName].parts['Reinforcement1'].Set(cells=
        mdb.models[ModelName].parts['Reinforcement1'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='ReinforcementSet1')
    mdb.models[ModelName].parts['Reinforcement1'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Reinforcement1'].sets['ReinforcementSet1'], 
        sectionName='Fibersection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Reinforcement2'].Set(cells=
        mdb.models[ModelName].parts['Reinforcement2'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='ReinforcementSet2')
    mdb.models[ModelName].parts['Reinforcement2'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Reinforcement2'].sets['ReinforcementSet2'], 
        sectionName='Fibersection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Reinforcement3'].Set(cells=
        mdb.models[ModelName].parts['Reinforcement3'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='ReinforcementSet3')
    mdb.models[ModelName].parts['Reinforcement3'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Reinforcement3'].sets['ReinforcementSet3'], 
        sectionName='Fibersection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Reinforcement4'].Set(cells=
        mdb.models[ModelName].parts['Reinforcement4'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='ReinforcementSet4')
    mdb.models[ModelName].parts['Reinforcement4'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Reinforcement4'].sets['ReinforcementSet4'], 
        sectionName='Fibersection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Reinforcement5'].Set(cells=
        mdb.models[ModelName].parts['Reinforcement5'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='ReinforcementSet5')
    mdb.models[ModelName].parts['Reinforcement5'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Reinforcement5'].sets['ReinforcementSet5'], 
        sectionName='Fibersection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Reinforcement6'].Set(cells=
        mdb.models[ModelName].parts['Reinforcement6'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='ReinforcementSet6')
    mdb.models[ModelName].parts['Reinforcement6'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Reinforcement6'].sets['ReinforcementSet6'], 
        sectionName='Fibersection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Reinforcement7'].Set(cells=
        mdb.models[ModelName].parts['Reinforcement7'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='ReinforcementSet7')
    mdb.models[ModelName].parts['Reinforcement7'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Reinforcement7'].sets['ReinforcementSet7'], 
        sectionName='Fibersection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Reinforcement8'].Set(cells=
        mdb.models[ModelName].parts['Reinforcement8'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='ReinforcementSet8')
    mdb.models[ModelName].parts['Reinforcement8'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Reinforcement8'].sets['ReinforcementSet8'], 
        sectionName='Fibersection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Reinforcement9'].Set(cells=
        mdb.models[ModelName].parts['Reinforcement9'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='ReinforcementSet9')
    mdb.models[ModelName].parts['Reinforcement9'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Reinforcement9'].sets['ReinforcementSet9'], 
        sectionName='Fibersection', thicknessAssignment=FROM_SECTION)

    ## Interphase Section Assignent
    mdb.models[ModelName].parts['Interphase1'].Set(cells=
        mdb.models[ModelName].parts['Interphase1'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='InterphaseSet1')
    mdb.models[ModelName].parts['Interphase1'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Interphase1'].sets['InterphaseSet1'], 
        sectionName='Interphasesection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Interphase2'].Set(cells=
        mdb.models[ModelName].parts['Interphase2'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='InterphaseSet2')
    mdb.models[ModelName].parts['Interphase2'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Interphase2'].sets['InterphaseSet2'], 
        sectionName='Interphasesection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Interphase3'].Set(cells=
        mdb.models[ModelName].parts['Interphase3'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='InterphaseSet3')
    mdb.models[ModelName].parts['Interphase3'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Interphase3'].sets['InterphaseSet3'], 
        sectionName='Interphasesection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Interphase4'].Set(cells=
        mdb.models[ModelName].parts['Interphase4'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='InterphaseSet4')
    mdb.models[ModelName].parts['Interphase4'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Interphase4'].sets['InterphaseSet4'], 
        sectionName='Interphasesection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Interphase5'].Set(cells=
        mdb.models[ModelName].parts['Interphase5'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='InterphaseSet5')
    mdb.models[ModelName].parts['Interphase5'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Interphase5'].sets['InterphaseSet5'], 
        sectionName='Interphasesection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Interphase6'].Set(cells=
        mdb.models[ModelName].parts['Interphase6'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='InterphaseSet6')
    mdb.models[ModelName].parts['Interphase6'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Interphase6'].sets['InterphaseSet6'], 
        sectionName='Interphasesection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Interphase7'].Set(cells=
        mdb.models[ModelName].parts['Interphase7'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='InterphaseSet7')
    mdb.models[ModelName].parts['Interphase7'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Interphase7'].sets['InterphaseSet7'], 
        sectionName='Interphasesection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Interphase8'].Set(cells=
        mdb.models[ModelName].parts['Interphase8'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='InterphaseSet8')
    mdb.models[ModelName].parts['Interphase8'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Interphase8'].sets['InterphaseSet8'], 
        sectionName='Interphasesection', thicknessAssignment=FROM_SECTION)
    mdb.models[ModelName].parts['Interphase9'].Set(cells=
        mdb.models[ModelName].parts['Interphase9'].cells.getSequenceFromMask(('[#1 ]', 
        ), ), name='InterphaseSet9')
    mdb.models[ModelName].parts['Interphase9'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models[ModelName].parts['Interphase9'].sets['InterphaseSet9'], 
        sectionName='Interphasesection', thicknessAssignment=FROM_SECTION)

    # ------------------------------------------------------------------- 
    #Create  exact number of PARTICULATE instances 
    
    mdb.models[ModelName].rootAssembly.Instance(dependent=OFF, name='Matrix-1', 
        part=mdb.models[ModelName].parts['Matrix'])
    mdb.models[ModelName].rootAssembly.translate(instanceList=('Matrix-1', ), 
        vector=(0.0, 0.0, -50.0))
        
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Reinforcement1'] 
    a1.Instance(name='Reinforcement-1', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Reinforcement2'] 
    a1.Instance(name='Reinforcement-2', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Reinforcement3'] 
    a1.Instance(name='Reinforcement-3', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Reinforcement4'] 
    a1.Instance(name='Reinforcement-4', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Reinforcement5'] 
    a1.Instance(name='Reinforcement-5', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Reinforcement6'] 
    a1.Instance(name='Reinforcement-6', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Reinforcement7'] 
    a1.Instance(name='Reinforcement-7', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Reinforcement8'] 
    a1.Instance(name='Reinforcement-8', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Reinforcement9'] 
    a1.Instance(name='Reinforcement-9', part=p, dependent=ON)
 
    # Interphase Instances        
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Interphase1'] 
    a1.Instance(name='Interphase-1', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Interphase2'] 
    a1.Instance(name='Interphase-2', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Interphase3'] 
    a1.Instance(name='Interphase-3', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Interphase4'] 
    a1.Instance(name='Interphase-4', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Interphase5'] 
    a1.Instance(name='Interphase-5', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Interphase6'] 
    a1.Instance(name='Interphase-6', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Interphase7'] 
    a1.Instance(name='Interphase-7', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Interphase8'] 
    a1.Instance(name='Interphase-8', part=p, dependent=ON)
    a1 = mdb.models[ModelName].rootAssembly 
    p = mdb.models[ModelName].parts['Interphase9'] 
    a1.Instance(name='Interphase-9', part=p, dependent=ON)
    
    # Reinforcement and Interphase Location    
    a1 = mdb.models[ModelName].rootAssembly 
    a1.translate(instanceList=('Reinforcement-1','Interphase-1' ), vector=(23.19,26.42,27.63))
    a = mdb.models[ModelName].rootAssembly
    a.rotate(instanceList=('Reinforcement-1','Interphase-1'), axisPoint=(0.0, 0.0, 0.0), axisDirection=(0.0, 1.0, 0.0), angle=90.0) 
    a1 = mdb.models[ModelName].rootAssembly 
    a1.translate(instanceList=('Reinforcement-2','Interphase-2' ), vector=(-24.3184,-23.6081,27.9699))
    a = mdb.models[ModelName].rootAssembly
    a.rotate(instanceList=('Reinforcement-2','Interphase-2'), axisPoint=(0.0, 0.0, 0.0), axisDirection=(0.0, 1.0, 0.0), angle=90.0) 
    a1 = mdb.models[ModelName].rootAssembly 
    a1.translate(instanceList=('Reinforcement-3','Interphase-3' ), vector=(-25.0,-23.1,-27.50))
    a = mdb.models[ModelName].rootAssembly
    a.rotate(instanceList=('Reinforcement-3','Interphase-3'), axisPoint=(0.0, 0.0, 0.0), axisDirection=(0.0, 1.0, 0.0), angle=90.0) 
    a1 = mdb.models[ModelName].rootAssembly 
    a1.translate(instanceList=('Reinforcement-4','Interphase-4' ), vector=(0.5702,-0.11803,-1.8764))
    a = mdb.models[ModelName].rootAssembly
    a.rotate(instanceList=('Reinforcement-4','Interphase-4'), axisPoint=(0.0, 0.0, 0.0), axisDirection=(0.0, 1.0, 0.0), angle=90.0) 
    a1 = mdb.models[ModelName].rootAssembly 
    a1.translate(instanceList=('Reinforcement-5','Interphase-5' ), vector=(-25.394,27.2484,-21.9012))
    a = mdb.models[ModelName].rootAssembly
    a.rotate(instanceList=('Reinforcement-5','Interphase-5'), axisPoint=(0.0, 0.0, 0.0), axisDirection=(0.0, 1.0, 0.0), angle=90.0) 
    a1 = mdb.models[ModelName].rootAssembly 
    a1.translate(instanceList=('Reinforcement-6','Interphase-6' ), vector=(25.5107,-27.62,-22.24))  
    a = mdb.models[ModelName].rootAssembly
    a.rotate(instanceList=('Reinforcement-6','Interphase-6'), axisPoint=(0.0, 0.0, 0.0), axisDirection=(0.0, 1.0, 0.0), angle=90.0)
    a1 = mdb.models[ModelName].rootAssembly 
    a1.translate(instanceList=('Reinforcement-7','Interphase-7' ), vector=(20.19,-26.42,24.63))
    a = mdb.models[ModelName].rootAssembly
    a.rotate(instanceList=('Reinforcement-7','Interphase-7'), axisPoint=(0.0, 0.0, 0.0), axisDirection=(0.0, 1.0, 0.0), angle=90.0) 
    a1 = mdb.models[ModelName].rootAssembly 
    a1.translate(instanceList=('Reinforcement-8','Interphase-8' ), vector=(25.0,26.32,-26.24)) 
    a = mdb.models[ModelName].rootAssembly
    a.rotate(instanceList=('Reinforcement-8','Interphase-8'), axisPoint=(0.0, 0.0, 0.0), axisDirection=(0.0, 1.0, 0.0), angle=90.0)     
    a1 = mdb.models[ModelName].rootAssembly 
    a1.translate(instanceList=('Reinforcement-9','Interphase-9' ), vector=(-24.93184,24.1081,22.8096))
    a = mdb.models[ModelName].rootAssembly
    a.rotate(instanceList=('Reinforcement-9','Interphase-9'), axisPoint=(0.0, 0.0, 0.0), axisDirection=(0.0, 1.0, 0.0), angle=90.0)
    
    
    mdb.models[ModelName].rootAssembly.InstanceFromBooleanMerge(domain=GEOMETRY, 
        instances=(mdb.models[ModelName].rootAssembly.instances['Matrix-1'], 
        mdb.models[ModelName].rootAssembly.instances['Reinforcement-1'],
        mdb.models[ModelName].rootAssembly.instances['Reinforcement-2'],
        mdb.models[ModelName].rootAssembly.instances['Reinforcement-3'],
        mdb.models[ModelName].rootAssembly.instances['Reinforcement-4'],
        mdb.models[ModelName].rootAssembly.instances['Reinforcement-5'],
        mdb.models[ModelName].rootAssembly.instances['Reinforcement-6'],
        mdb.models[ModelName].rootAssembly.instances['Reinforcement-7'],
        mdb.models[ModelName].rootAssembly.instances['Reinforcement-8'],
        mdb.models[ModelName].rootAssembly.instances['Reinforcement-9'],
        mdb.models[ModelName].rootAssembly.instances['Interphase-1'],
        mdb.models[ModelName].rootAssembly.instances['Interphase-2'],
        mdb.models[ModelName].rootAssembly.instances['Interphase-3'],
        mdb.models[ModelName].rootAssembly.instances['Interphase-4'],
        mdb.models[ModelName].rootAssembly.instances['Interphase-5'],
        mdb.models[ModelName].rootAssembly.instances['Interphase-6'],
        mdb.models[ModelName].rootAssembly.instances['Interphase-7'],
        mdb.models[ModelName].rootAssembly.instances['Interphase-8'],
        mdb.models[ModelName].rootAssembly.instances['Interphase-9']), 
        keepIntersections=ON, name='Composite', originalInstances=SUPPRESS)
        
#    #Orientation
#    mdb.models[ModelName].parts['Composite'].MaterialOrientation(
#        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
#        None, orientationType=GLOBAL, region=Region(
#        cells=mdb.models[ModelName].parts['Composite'].cells.getSequenceFromMask(
#        mask=('[#7 ]', ), )), stackDirection=STACK_3)
        
    #Orientation
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['MatrixSet'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['ReinforcementSet1'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['ReinforcementSet2'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['ReinforcementSet3'], stackDirection=
        STACK_3)        
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['ReinforcementSet4'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['ReinforcementSet5'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['ReinforcementSet6'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['ReinforcementSet7'], stackDirection=
        STACK_3) 
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['ReinforcementSet8'], stackDirection=
        STACK_3)        
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['ReinforcementSet9'], stackDirection=
        STACK_3)        
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['InterphaseSet1'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['InterphaseSet2'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['InterphaseSet3'], stackDirection=
        STACK_3)        
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['InterphaseSet4'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['InterphaseSet5'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['InterphaseSet6'], stackDirection=
        STACK_3)
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['InterphaseSet7'], stackDirection=
        STACK_3) 
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['InterphaseSet8'], stackDirection=
        STACK_3)        
    mdb.models['Model-'+str(jjj)].parts['Composite'].MaterialOrientation(
        additionalRotationType=ROTATION_NONE, axis=AXIS_1, fieldName='', localCsys=
        None, orientationType=GLOBAL, region=
        mdb.models['Model-'+str(jjj)].parts['Composite'].sets['InterphaseSet9'], stackDirection=
        STACK_3)
               
    ##Set mesh controls

    mdb.models[ModelName].rootAssembly.makeIndependent(instances=(
    mdb.models[ModelName].rootAssembly.instances['Composite-1'], ))

    mdb.models[ModelName].rootAssembly.setMeshControls(elemShape=TET, regions=
        mdb.models[ModelName].rootAssembly.instances['Composite-1'].cells.getSequenceFromMask(
        ('[#7ffff  ]', ), ), technique=FREE)
    mdb.models[ModelName].rootAssembly.setElementType(elemTypes=(ElemType(
        elemCode=C3D20R, elemLibrary=STANDARD), ElemType(elemCode=C3D15, 
        elemLibrary=STANDARD), ElemType(elemCode=C3D10, elemLibrary=STANDARD)), 
        regions=(
        mdb.models[ModelName].rootAssembly.instances['Composite-1'].cells.getSequenceFromMask(
        ('[#7ffff  ]', ), ), ))
    mdb.models[ModelName].rootAssembly.setElementType(elemTypes=(ElemType(
        elemCode=C3D8E, elemLibrary=STANDARD), ElemType(elemCode=C3D6E, 
        elemLibrary=STANDARD), ElemType(elemCode=C3D4E, elemLibrary=STANDARD)), 
        regions=(
        mdb.models[ModelName].rootAssembly.instances['Composite-1'].cells.getSequenceFromMask(
        ('[#7ffff   ]', ), ), ))
    mdb.models[ModelName].rootAssembly.seedPartInstance(deviationFactor=0.1, 
        minSizeFactor=0.1, regions=(
        mdb.models[ModelName].rootAssembly.instances['Composite-1'], ), size=mesh_size)
    mdb.models[ModelName].rootAssembly.generateMesh(boundaryPreview=ON, regions=(
        mdb.models[ModelName].rootAssembly.instances['Composite-1'], ))
    mdb.models[ModelName].rootAssembly.generateMesh(regions=(
        mdb.models[ModelName].rootAssembly.instances['Composite-1'], ))
    
    # Display the meshed beam.
    myViewport= session.Viewport(name='Kabir',
        origin=(0, 0), width=100, height=70)
    myViewport.assemblyDisplay.setValues(mesh=ON)
    myViewport.assemblyDisplay.meshOptions.setValues(meshTechnique=ON)
    myViewport.setValues(displayedObject=mdb.models[ModelName].rootAssembly)


    #Creating Reference Points
    mdb.models[ModelName].rootAssembly.regenerate()
    mdb.models[ModelName].rootAssembly.ReferencePoint(point=(-60.0, -60.0, 0.0))
    mdb.models[ModelName].rootAssembly.ReferencePoint(point=(60.0, 60.0, 0.0))
    mdb.models[ModelName].rootAssembly.ReferencePoint(point=(-60.0, 0.0, 0.0))
    mdb.models[ModelName].rootAssembly.ReferencePoint(point=(60.0, 0.0, 0.0))
    mdb.models[ModelName].rootAssembly.ReferencePoint(point=(0.0, 60.0, 0.0))
    mdb.models[ModelName].rootAssembly.ReferencePoint(point=(0.0, -60.0, 0.0))
    mdb.models[ModelName].rootAssembly.ReferencePoint(point=(0.0, 0.0, 60.0))
    mdb.models[ModelName].rootAssembly.ReferencePoint(point=(0.0, 0.0, -60.0))
    mdb.models[ModelName].rootAssembly.ReferencePoint(point=(-60.0, -60.0, -60.0))
    
    a = mdb.models[ModelName].rootAssembly
    kf = mdb.models[ModelName].rootAssembly.referencePoints.items()
    ks=len(kf) 
    k=kf[ks -1][0] 
    r1 = mdb.models[ModelName].rootAssembly.referencePoints
    refPoints1=(r1[k], r1[k+1], r1[k+2], r1[k+3], r1[k+4], r1[k+5], r1[k+6], r1[k+7], r1[k+8],)
    a.Set(referencePoints=refPoints1, name='ReferenceSet')    
       
    ##def CreateStep (RVE_para,RVEModel):
    mdb.models[ModelName].StaticStep(name='Step-1', previous='Initial')
    session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
    mdb.models[ModelName].fieldOutputRequests['F-Output-1'].setValues(variables=(
        'S', 'E', 'U','EVOL', 'IVOL','EPOT','EPG','EFLX'))
    # Saved by KABIR BAIDYA 07/04/2022
    
    
    ModelName = 'Model-'+str(jjj)
    InstanceName = 'Composite-1'
    Noeuds = mdb.models[ModelName].rootAssembly.instances[InstanceName].nodes
    # Get the dimensions of the RVE
    Nb_noeuds = len(Noeuds)
    for i in range(Nb_noeuds): 
        Cx = Noeuds[i].coordinates[0]
        Cy = Noeuds[i].coordinates[1] 
        Cz = Noeuds[i].coordinates[2]
        if Max_x <= Cx: 
            Max_x = Cx
        if Cx <= Min_x:
            Min_x = Cx
        if Max_y <= Cy:
            Max_y = Cy
        if Cy <= Min_y:
            Min_y = Cy
        if Max_z <= Cz:
            Max_z = Cz
        if Cz <= Min_z:
            Min_z = Cz
    
    lx = Max_x - Min_x 
    ly = Max_y - Min_y
    lz = Max_z - Min_z
    lxc = (Max_x + Min_x)/2 
    lyc = (Max_y + Min_y)/2
    lzc = (Max_z + Min_z)/2
    
    
    
    # Storing of nodes belonging to the external Faces 
    # (Used for the treatment of constraints equation; 
    # important note: this is not node label stored but array index of Noeuds)
    
    # 6 Faces
    # Normal to +X
    Set_XP = []
    # Normal to -X
    Set_XM = []
    # Normal to +Y
    Set_YP = []
    # Normal to -Y
    Set_YM = []
    # Normal to +Z
    Set_ZP = []
    # Normal to -Z
    Set_ZM = []
    
    lSet_XP = [] 
    lSet_XM = []
    lSet_YP =[] 
    lSet_YM = [] 
    lSet_ZP = [] 
    lSet_ZM = []
    
    # 8 Vertices
    #Bottom coner. Coordinates = (Minimum X, Minimum Y, Minimum Z)
    Set_A =[]
    lSet_A = []
    #Bottom coner. Coordinates = (Maximum X, Minimum Y, Minimum Z)
    Set_B = []
    lSet_B = []
    #Top Corner. Coordinates = (Maximum X, Maximum Y, Minimum Z)
    Set_C = []
    lSet_C = []
    #Top Corner. Coordinates = (Minimum X, Maximum Y, Minimum Z)
    Set_D = []
    lSet_D = []
    #Bottom Corner. Coordinates = (Minimum X, Minimum Y, Maximum Z)
    Set_AA =[]
    lSet_AA = []
    #Bottom Corner. Coordinates = (Maximum X, Minimum Y, Maximum Z)
    Set_BB = []
    lSet_BB = []
    #Top Corner. Coordinates = (Maximum X, Maximum Y, Maximum Z)
    Set_CC = []
    lSet_CC = []
    #Top Corner. Coordinates = (Minimum X, Maximum Y, Maximum Z)
    Set_DD = []
    lSet_DD = []
    
    # 12 Edges
    # Between A and D
    Set_R =[]
    lSet_R = []
    # Between B and C
    Set_S =[]
    lSet_S = []
    # Between C and D
    Set_T =[]
    lSet_T = []
    # Between A and B
    Set_U =[]
    lSet_U = []
    # Between A and AA
    Set_V =[]
    lSet_V = []
    # Between B and BB
    Set_W =[]
    lSet_W = []
    # Between AA and DD
    Set_RR =[]
    lSet_RR = []
    # Between BB and CC
    Set_SS =[]
    lSet_SS = []
    # Between CC and DD
    Set_TT =[]
    lSet_TT = []
    # Between AA and BB
    Set_UU =[]
    lSet_UU = []
    # Between DD and D
    Set_VV =[]
    lSet_VV = []
    # Between CC and C
    Set_WW =[]
    lSet_WW = []
    
    # Only store the nodes included in the constraint equations
    for i in range (Nb_noeuds):
        Cx= Noeuds[i].coordinates[0]
        Cy= Noeuds[i].coordinates[1]
        Cz= Noeuds[i].coordinates[2]
        if (Cx==Min_x) and (Cy==Min_y) and (Cz==Min_z):
            Set_A.append(i)
            lSet_A.append(i+1)
        if (Cx==Max_x) and (Cy==Min_y) and (Cz==Min_z):
            Set_B.append(i)
            lSet_B.append(i+1)
        if (Cx==Max_x) and (Cy==Max_y) and (Cz==Min_z):
            Set_C.append(i)
            lSet_C.append(i+1)
        if (Cx==Min_x) and (Cy==Max_y) and (Cz==Min_z):
            Set_D.append(i)
            lSet_D.append(i+1)
        if (Cx==Min_x) and (Cy==Min_y) and (Cz==Max_z):
            Set_AA.append(i)
            lSet_AA.append(i+1)    
        if (Cx==Max_x) and (Cy==Min_y) and (Cz==Max_z):
            Set_BB.append(i)
            lSet_BB.append(i+1)
        if (Cx==Max_x) and (Cy==Max_y) and (Cz==Max_z):
            Set_CC.append(i)
            lSet_CC.append(i+1)
        if (Cx==Min_x) and (Cy==Max_y) and (Cz==Max_z):
            Set_DD.append(i)
            lSet_DD.append(i+1)
        if (Cx==Min_x) and (Cy!=Min_y) and (Cy!=Max_y) and (Cz==Min_z):
            Set_R.append(i)
            lSet_R.append(i+1)
        if (Cx==Max_x) and (Cy!=Min_y) and (Cy!=Max_y) and (Cz==Min_z):
            Set_S.append(i)
            lSet_S.append(i+1)
        if (Cx!=Min_x) and (Cx!=Max_x) and (Cy==Max_y) and (Cz==Min_z):
            Set_T.append(i)
            lSet_T.append(i+1)    
        if (Cx!=Min_x) and (Cx!=Max_x) and (Cy==Min_y) and (Cz==Min_z):
            Set_U.append(i)
            lSet_U.append(i+1)
        if (Cx==Min_x) and (Cy==Min_y) and (Cz!=Min_z) and (Cz!=Max_z) :
            Set_V.append(i)
            lSet_V.append(i+1)
        if (Cx==Max_x) and (Cy==Min_y) and (Cz!=Min_z) and (Cz!=Max_z) :
            Set_W.append(i)
            lSet_W.append(i+1) 
        if (Cx==Min_x) and (Cy!=Min_y) and (Cy!=Max_y) and (Cz==Max_z):
            Set_RR.append(i)
            lSet_RR.append(i+1)
        if (Cx==Max_x) and (Cy!=Min_y) and (Cy!=Max_y) and (Cz==Max_z):
            Set_SS.append(i)
            lSet_SS.append(i+1)
        if (Cx!=Min_x) and (Cx!=Max_x) and (Cy==Max_y) and (Cz==Max_z):
            Set_TT.append(i)
            lSet_TT.append(i+1)    
        if (Cx!=Min_x) and (Cx!=Max_x) and (Cy==Min_y) and (Cz==Max_z):
            Set_UU.append(i)
            lSet_UU.append(i+1)
        if (Cx==Min_x) and (Cy==Max_y) and (Cz!=Min_z) and (Cz!=Max_z) :
            Set_VV.append(i)
            lSet_VV.append(i+1)
        if (Cx==Max_x) and (Cy==Max_y) and (Cz!=Min_z) and (Cz!=Max_z) :
            Set_WW.append(i)
            lSet_WW.append(i+1)
        if (Cx==Max_x) and (Cy!=Max_y) and (Cy!=Min_y) and (Cz!=Max_z) and (Cz!=Min_z): 
            Set_XP.append(i)
            lSet_XP.append(i+1)
        if (Cx==Min_x) and (Cy!=Max_y) and (Cy!=Min_y) and (Cz!=Max_z) and (Cz!=Min_z): 
            Set_XM.append(i)
            lSet_XM.append(i+1)
        if (Cy==Max_y) and (Cz!=Max_z ) and (Cz!=Min_z) and (Cx!=Min_x) and (Cx!=Max_x):
            Set_YP.append(i)
            lSet_YP.append(i+1)
        if (Cy==Min_y) and (Cz!=Max_z ) and (Cz!=Min_z) and (Cx!=Min_x) and (Cx!=Max_x): 
            Set_YM.append(i)
            lSet_YM.append( i+1)
        if (Cz==Max_z) and (Cx!=Max_x) and (Cx!=Min_x) and (Cy!=Min_y) and (Cy!=Max_y):
            Set_ZP.append(i) 
            lSet_ZP.append(i+1)
        if (Cz==Min_z) and (Cx!=Max_x) and (Cx!=Min_x) and (Cy!=Min_y) and (Cy!=Max_y):
            Set_ZM.append(i) 
            lSet_ZM.append(i+1)
        
    
    # Build the sets for individual faces. It is convenient for checking.
    
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_A', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_A)),)
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_B', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_B)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_C', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_C)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_D', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_D)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_AA', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_AA)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_BB', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_BB)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_CC', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_CC)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_DD', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_DD)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_R', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_R)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_S', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_S)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_T', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_T)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_U', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_U)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_V', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_V)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_W', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_W)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_RR', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_RR)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_SS', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_SS)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_TT', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_TT)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_UU', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_UU)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_VV', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_VV)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_WW', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_WW)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_XP', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_XP)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_XM', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_XM)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_YP', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_YP)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_YM', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_YM)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_ZP', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_ZP)))
    mdb.models[ModelName].rootAssembly.SetFromNodeLabels(name='Set_ZM', nodeLabels=((InstanceName, (2,3,5,7)),(InstanceName, lSet_ZM)))
    
    # Creating unique set for the previously identified nodes 
    Set_name= 'Set_'
    
    for i in range(len(Set_A)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'A'+str(i), nodes=Noeuds[Set_A[i]:Set_A[i]+1])
                                            
    for i in range(len(Set_B)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'B'+str(i), nodes=Noeuds[Set_B[i]:Set_B[i]+1])
                                            
    for i in range(len(Set_C)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'C'+str(i), nodes=Noeuds[Set_C[i]:Set_C[i]+1])
                                            
    for i in range(len(Set_D)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'D'+str(i), nodes=Noeuds[Set_D[i]:Set_D[i]+1])
                                            
    for i in range(len(Set_AA)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'AA'+str(i), nodes=Noeuds[Set_AA[i]:Set_AA[i]+1])
                                            
    for i in range(len(Set_BB)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'BB'+str(i), nodes=Noeuds[Set_BB[i]:Set_BB[i]+1])
                                            
    for i in range(len(Set_CC)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'CC'+str(i), nodes=Noeuds[Set_CC[i]:Set_CC[i]+1])
                                            
    for i in range(len(Set_DD)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'DD'+str(i), nodes=Noeuds[Set_DD[i]:Set_DD[i]+1])
                                            
    for i in range(len(Set_R)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'R'+ str(i), nodes=Noeuds[Set_R[i]:Set_R[i]+1])
                                            
    for i in range(len(Set_S)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'S'+ str(i), nodes=Noeuds[Set_S[i]:Set_S[i]+1])
                                            
    for i in range(len(Set_T)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'T'+ str(i), nodes=Noeuds[Set_T[i]:Set_T[i]+1])
                                            
    for i in range(len(Set_U)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'U'+ str(i), nodes=Noeuds[Set_U[i]:Set_U[i]+1])
                                            
    for i in range(len(Set_V)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'V'+ str(i), nodes=Noeuds[Set_V[i]:Set_V[i]+1])
                                            
    for i in range(len(Set_W)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'W'+ str(i), nodes=Noeuds[Set_W[i]:Set_W[i]+1])
    
    for i in range(len(Set_RR)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'RR'+ str(i), nodes=Noeuds[Set_RR[i]:Set_RR[i]+1])
                                            
    for i in range(len(Set_SS)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'SS'+ str(i), nodes=Noeuds[Set_SS[i]:Set_SS[i]+1])
                                            
    for i in range(len(Set_TT)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'TT'+ str(i), nodes=Noeuds[Set_TT[i]:Set_TT[i]+1])
                                            
    for i in range(len(Set_UU)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'UU'+ str(i), nodes=Noeuds[Set_UU[i]:Set_UU[i]+1])
                                            
    for i in range(len(Set_VV)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'VV'+ str(i), nodes=Noeuds[Set_VV[i]:Set_VV[i]+1])
                                            
    for i in range(len(Set_WW)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'WW'+ str(i), nodes=Noeuds[Set_WW[i]:Set_WW[i]+1])
    
    for i in range(len(Set_XP)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'XP'+ str(i), nodes=Noeuds[Set_XP[i]:Set_XP[i]+1])
    
    for i in range(len(Set_XM)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'XM'+ str(i), nodes=Noeuds[Set_XM[i]:Set_XM[i]+1])
    
    for i in range(len(Set_YP)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'YP'+ str(i), nodes=Noeuds[Set_YP[i]:Set_YP[i]+1])
        
    for i in range(len(Set_YM)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'YM'+ str(i), nodes=Noeuds[Set_YM[i]:Set_YM[i]+1])
    
    for i in range(len(Set_ZP)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'ZP'+ str(i), nodes=Noeuds[Set_ZP[i]:Set_ZP[i]+1])
    
    for i in range(len(Set_ZM)):
        mdb.models[ModelName].rootAssembly.Set(name= Set_name +'ZM' + str(i), nodes=Noeuds[Set_ZM[i]:Set_ZM[i]+1])
    
    
    
    
    
    
    kf = mdb.models[ModelName].rootAssembly.referencePoints.items()
    ks=len(kf) 
    k=kf[ks -1][0] 
    r1 = mdb.models[ModelName].rootAssembly.referencePoints
    refPoints1=(r1[k],)
    mdb.models[ModelName].rootAssembly.Set(referencePoints = refPoints1, name='E11')
    refPoints1=(r1[k+1],)
    mdb.models[ModelName].rootAssembly.Set(referencePoints = refPoints1, name='E22')
    refPoints1=(r1[k+2],)
    mdb.models[ModelName].rootAssembly.Set(referencePoints = refPoints1, name='GAMMA12')
    refPoints1=(r1[k+3],)
    mdb.models[ModelName].rootAssembly.Set(referencePoints = refPoints1, name='E33')
    refPoints1=(r1[k+4],)
    mdb.models[ModelName].rootAssembly.Set(referencePoints = refPoints1, name='GAMMA13')
    refPoints1=(r1[k+5],)
    mdb.models[ModelName].rootAssembly.Set(referencePoints = refPoints1, name='GAMMA23')
    refPoints1=(r1[k+6],)
    mdb.models[ModelName].rootAssembly.Set(referencePoints = refPoints1, name='ELEC1')                                        
    refPoints1=(r1[k+7],)
    mdb.models[ModelName].rootAssembly.Set(referencePoints = refPoints1, name='ELEC2')
    refPoints1=(r1[k+8],)
    mdb.models[ModelName].rootAssembly.Set(referencePoints = refPoints1, name='ELEC3')
                                            
    ##mdb.models[ModelName].rootAssembly.editNode(nodes = Noeuds[cen], coordinate1=lxc, coordinate2=lyc, coordinate3=lzc, projectToGeometry=ON)
    ##mdb.models[ModelName].rootAssembly.Set(nodes = Noeuds[cen:cen+1], name='Centre')
    
    torl = 0.01
    
    # Creating the constraint equations 
    Constraint_name='Eq-X-surfaces-XP-XM'
    s=0 
    for i in range(len(Set_XP)):
        coord_X_XP = Noeuds[Set_XP[i]].coordinates[0]
        coord_Y_XP = Noeuds[Set_XP[i]].coordinates[1]
        coord_Z_XP = Noeuds[Set_XP[i]].coordinates[2]
        for j in range(len(Set_XM)):
            coord_X_XM= Noeuds[Set_XM[j]].coordinates[0]
            coord_Y_XM= Noeuds[Set_XM[j]].coordinates[1]
            coord_Z_XM= Noeuds[Set_XM[j]].coordinates[2]
            Wx = coord_X_XP - coord_X_XM
            Wy = coord_Y_XP - coord_Y_XM
            Wz = coord_Z_XP - coord_Z_XM 
            if (abs(coord_Y_XP - coord_Y_XM)<torl) and (abs(coord_Z_XP - coord_Z_XM)<torl):
                mdb.models[ModelName].Equation(name=Constraint_name+str(s), terms=((1.0, Set_name +'XP'+ str(i),1),(-1.0, Set_name + 'XM' + str(j), 1), (-Wx, 'E11', 1),(-Wy/2,'GAMMA12',1),(-Wz/2,'GAMMA13',1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+1),terms =((1.0,Set_name +'XP'+ str(i),2), (-1.0, Set_name + 'XM' + str(j),2),(-Wx/2, 'GAMMA12', 1),(-Wy,'E22',1),(-Wz/2,'GAMMA23',1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+2),terms=((1.0, Set_name +'XP'+  str(i),3),(-1.0, Set_name + 'XM' + str(j),3),(-Wx/2,'GAMMA13', 1),(-Wy/2,'GAMMA23',1),(-Wz,'E33',1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'XP'+  str(i),9),(-1.0, Set_name + 'XM' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
    
    Constraint_name='Eq-Y-surfaces-YP-YM' 
    s=0 
    for i in range(len(Set_YP)): 
        coord_X_YP=Noeuds[Set_YP[i]].coordinates[0]
        coord_Y_YP=Noeuds[Set_YP[i]].coordinates[1]
        coord_Z_YP=Noeuds[Set_YP[i]].coordinates[2] 
        for j in range(len(Set_YM)):
            coord_X_YM= Noeuds[Set_YM[j]].coordinates[0]
            coord_Y_YM= Noeuds[Set_YM[j]].coordinates[1]
            coord_Z_YM= Noeuds[Set_YM[j]].coordinates[2]
            Wx = coord_X_YP - coord_X_YM
            Wy = coord_Y_YP - coord_Y_YM
            Wz = coord_Z_YP - coord_Z_YM
            if (abs(coord_X_YP - coord_X_YM)<torl) and (abs(coord_Z_YP - coord_Z_YM)<torl): 
                mdb.models[ModelName].Equation(name= Constraint_name+str(s+1), terms=((1.0, Set_name +'YP'+str(i),1), (-1.0, Set_name +'YM' +str(j),1),(-Wx, 'E11', 1), (-Wy/2, 'GAMMA12', 1),(-Wz/2,'GAMMA13',1)))
                mdb.models[ModelName].Equation(name= Constraint_name+str(s), terms=((1.0, Set_name +'YP'+ str(i),2), (-1.0, Set_name +'YM' +str(j),2),(-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1),(-Wz/2,'GAMMA23',1))) 
                mdb.models[ModelName].Equation(name= Constraint_name+str(s+2), terms =((1.0, Set_name +'YP'+str(i),3), (-1.0, Set_name +'YM' +str(j),3),(-Wx/2,'GAMMA13', 1), (-Wy/2, 'GAMMA23', 1),(-Wz,'E33',1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'YP'+  str(i),9),(-1.0, Set_name + 'YM' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
                
    Constraint_name='Eq-Z-surfaces-ZP-ZM' 
    s=0 
    for i in range(len(Set_ZP)):
        coord_X_ZP=Noeuds[Set_ZP[i]].coordinates[0]
        coord_Y_ZP=Noeuds[Set_ZP[i]].coordinates[1]
        coord_Z_ZP=Noeuds[Set_ZP[i]].coordinates[2]
        for j in range(len(Set_ZM)):
            coord_X_ZM= Noeuds[Set_ZM[j]].coordinates[0]
            coord_Y_ZM= Noeuds[Set_ZM[j]].coordinates[1]
            coord_Z_ZM= Noeuds[Set_ZM[j]].coordinates[2]
            Wx = coord_X_ZP - coord_X_ZM
            Wy = coord_Y_ZP - coord_Y_ZM
            Wz = coord_Z_ZP - coord_Z_ZM
            if (abs(coord_X_ZP-coord_X_ZM)<torl) and (abs(coord_Y_ZP-coord_Y_ZM)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name +'ZP'+str(i), 1), (-1.0, Set_name +'ZM'+str(j), 1), (-Wx, 'E11', 1),(-Wy/2,'GAMMA12',1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name +'ZP'+str(i), 2), (-1.0, Set_name +'ZM'+str(j), 2), (-Wx/2, 'GAMMA12', 1),(-Wy,'E22',1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name +'ZP'+str(i), 3), (-1.0, Set_name +'ZM'+str(j), 3), (-Wx/2,'GAMMA13', 1),(-Wy/2,'GAMMA23',1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'ZP'+  str(i),9),(-1.0, Set_name + 'ZM' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
    
    Constraint_name='Eq-Edges_S_R' 
    s=0 
    for i in range(len(Set_S)):
        coord_X_S=Noeuds[Set_S[i]].coordinates[0]
        coord_Y_S=Noeuds[Set_S[i]].coordinates[1]
        coord_Z_S=Noeuds[Set_S[i]].coordinates[2]
        for j in range(len(Set_R)):
            coord_X_R= Noeuds[Set_R[j]].coordinates[0]
            coord_Y_R= Noeuds[Set_R[j]].coordinates[1]
            coord_Z_R= Noeuds[Set_R[j]].coordinates[2]
            Wx = coord_X_S - coord_X_R
            Wy = coord_Y_S - coord_Y_R
            Wz = coord_Z_S - coord_Z_R
            if (abs(coord_Y_S-coord_Y_R)<torl) and (abs(coord_Z_S-coord_Z_R)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name +'S'+str(i), 1), (-1.0, Set_name + 'R'+str(j), 1), (-Wx, 'E11', 1),(-Wy/2,'GAMMA12',1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name+'S' +str(i), 2), (-1.0, Set_name + 'R'+str(j), 2), (-Wx/2, 'GAMMA12', 1),(-Wy,'E22',1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name+'S'+str(i), 3), (-1.0, Set_name + 'R'+str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2,'GAMMA23',1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'S'+  str(i),9),(-1.0, Set_name + 'R' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
    
    Constraint_name='Eq-Edges_SS_RR' 
    s=0 
    for i in range(len(Set_SS)):
        coord_X_SS=Noeuds[Set_SS[i]].coordinates[0]
        coord_Y_SS=Noeuds[Set_SS[i]].coordinates[1]
        coord_Z_SS=Noeuds[Set_SS[i]].coordinates[2]
        for j in range(len(Set_RR)):
            coord_X_RR= Noeuds[Set_RR[j]].coordinates[0]
            coord_Y_RR= Noeuds[Set_RR[j]].coordinates[1]
            coord_Z_RR= Noeuds[Set_RR[j]].coordinates[2]
            Wx = coord_X_SS - coord_X_RR
            Wy = coord_Y_SS - coord_Y_RR
            Wz = coord_Z_SS - coord_Z_RR
            if (abs(coord_Y_SS-coord_Y_RR)<torl) and (abs(coord_Z_SS-coord_Z_RR)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'SS'+str(i), 1), (-1.0, Set_name + 'RR'+str(j), 1), (-Wx, 'E11', 1),(-Wy/2,'GAMMA12',1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'SS' +str(i), 2), (-1.0, Set_name + 'RR'+str(j), 2), (-Wx/2, 'GAMMA12', 1),(-Wy,'E22',1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'SS'+str(i), 3), (-1.0, Set_name + 'RR'+str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2,'GAMMA23',1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'SS'+  str(i),9),(-1.0, Set_name + 'RR' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
    
    Constraint_name='Eq-Edges_W_V' 
    s=0 
    for i in range(len(Set_W)):
        coord_X_W=Noeuds[Set_W[i]].coordinates[0]
        coord_Y_W=Noeuds[Set_W[i]].coordinates[1]
        coord_Z_W=Noeuds[Set_W[i]].coordinates[2]
        for j in range(len(Set_V)):
            coord_X_V= Noeuds[Set_V[j]].coordinates[0]
            coord_Y_V= Noeuds[Set_V[j]].coordinates[1]
            coord_Z_V= Noeuds[Set_V[j]].coordinates[2]
            Wx = coord_X_W - coord_X_V
            Wy = coord_Y_W - coord_Y_V
            Wz = coord_Z_W - coord_Z_V
            if (abs(coord_Y_W-coord_Y_V)<torl) and (abs(coord_Z_W-coord_Z_V)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'W'+str(i), 1), (-1.0, Set_name + 'V'+str(j), 1), (-Wx, 'E11', 1),(-Wy/2,'GAMMA12',1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'W' +str(i), 2), (-1.0, Set_name + 'V'+str(j), 2), (-Wx/2, 'GAMMA12', 1),(-Wy,'E22',1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'W'+str(i), 3), (-1.0, Set_name + 'V'+str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2,'GAMMA23',1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'W'+  str(i),9),(-1.0, Set_name + 'V' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
    
    Constraint_name='Eq-Edges_WW_VV' 
    s=0 
    for i in range(len(Set_WW)):
        coord_X_WW=Noeuds[Set_WW[i]].coordinates[0]
        coord_Y_WW=Noeuds[Set_WW[i]].coordinates[1]
        coord_Z_WW=Noeuds[Set_WW[i]].coordinates[2]
        for j in range(len(Set_VV)):
            coord_X_VV= Noeuds[Set_VV[j]].coordinates[0]
            coord_Y_VV= Noeuds[Set_VV[j]].coordinates[1]
            coord_Z_VV= Noeuds[Set_VV[j]].coordinates[2]
            Wx = coord_X_WW - coord_X_VV
            Wy = coord_Y_WW - coord_Y_VV
            Wz = coord_Z_WW - coord_Z_VV
            if (abs(coord_Y_WW-coord_Y_VV)<torl) and (abs(coord_Z_WW-coord_Z_VV)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'WW'+str(i), 1), (-1.0, Set_name + 'VV'+str(j), 1), (-Wx, 'E11', 1),(-Wy/2,'GAMMA12',1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'WW' +str(i), 2), (-1.0, Set_name + 'VV'+str(j), 2), (-Wx/2, 'GAMMA12', 1),(-Wy,'E22',1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'WW'+str(i), 3), (-1.0, Set_name + 'VV'+str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2,'GAMMA23',1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'WW'+  str(i),9),(-1.0, Set_name + 'VV' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
    
    Constraint_name='Eq-Edges_T_U' 
    s=0 
    for i in range(len(Set_T)): 
        coord_X_T=Noeuds[Set_T[i]].coordinates[0]
        coord_Y_T=Noeuds[Set_T[i]].coordinates[1]
        coord_Z_T=Noeuds[Set_T[i]].coordinates[2] 
        for j in range(len(Set_U)):
            coord_X_U= Noeuds[Set_U[j]].coordinates[0]
            coord_Y_U= Noeuds[Set_U[j]].coordinates[1]
            coord_Z_U= Noeuds[Set_U[j]].coordinates[2]
            Wx = coord_X_T - coord_X_U
            Wy = coord_Y_T - coord_Y_U
            Wz = coord_Z_T - coord_Z_U
            if (abs(coord_X_T - coord_X_U)<torl) and (abs(coord_Z_T - coord_Z_U)<torl): 
                mdb.models[ModelName].Equation(name= Constraint_name+str(s+1), terms=((1.0, Set_name + 'T'+str(i),1), (-1.0, Set_name + 'U'+str(j),1),(-Wx, 'E11', 1), (-Wy/2, 'GAMMA12', 1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name= Constraint_name+str(s), terms=((1.0, Set_name + 'T'+str(i),2), (-1.0, Set_name + 'U'+str(j),2), (-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1),(-Wz/2, 'GAMMA23', 1))) 
                mdb.models[ModelName].Equation(name= Constraint_name+str(s+2), terms =((1.0, Set_name + 'T'+str(i),3), (-1.0, Set_name + 'U' +str(j),3),(-Wx/2, 'GAMMA13', 1),(-Wy/2, 'GAMMA23', 1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'T'+  str(i),9),(-1.0, Set_name + 'U' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
    
    Constraint_name='Eq-Edges_UU_U' 
    s=0 
    for i in range(len(Set_UU)):
        coord_X_UU=Noeuds[Set_UU[i]].coordinates[0]
        coord_Y_UU=Noeuds[Set_UU[i]].coordinates[1]
        coord_Z_UU=Noeuds[Set_UU[i]].coordinates[2]
        for j in range(len(Set_U)):
            coord_X_U= Noeuds[Set_U[j]].coordinates[0]
            coord_Y_U= Noeuds[Set_U[j]].coordinates[1]
            coord_Z_U= Noeuds[Set_U[j]].coordinates[2]
            Wx = coord_X_UU - coord_X_U
            Wy = coord_Y_UU - coord_Y_U
            Wz = coord_Z_UU - coord_Z_U
            if (abs(coord_X_UU-coord_X_U)<torl) and (abs(coord_Y_UU-coord_Y_U)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'UU'+str(i), 1), (-1.0, Set_name + 'U'+str(j), 1),(-Wx, 'E11', 1), (-Wy/2, 'GAMMA12', 1), (-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'UU' +str(i), 2), (-1.0, Set_name + 'U'+str(j), 2), (-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'UU'+str(i), 3), (-1.0, Set_name + 'U'+str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2, 'GAMMA23', 1), (-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'UU'+  str(i),9),(-1.0, Set_name + 'U' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
                
    Constraint_name='Eq-Edges_VV_V' 
    s=0 
    for i in range(len(Set_VV)): 
        coord_X_VV=Noeuds[Set_VV[i]].coordinates[0] 
        coord_Y_VV=Noeuds[Set_VV[i]].coordinates[1]
        coord_Z_VV=Noeuds[Set_VV[i]].coordinates[2] 
        for j in range(len(Set_V)):
            coord_X_V= Noeuds[Set_V[j]].coordinates[0]
            coord_Y_V= Noeuds[Set_V[j]].coordinates[1]
            coord_Z_V= Noeuds[Set_V[j]].coordinates[2]
            Wx = coord_X_VV - coord_X_V
            Wy = coord_Y_VV - coord_Y_V
            Wz = coord_Z_VV - coord_Z_V
            if (abs(coord_X_VV - coord_X_V)<torl) and (abs(coord_Z_VV - coord_Z_V)<torl): 
                mdb.models[ModelName].Equation(name= Constraint_name+str(s+1), terms=((1.0, Set_name + 'VV'+str(i),1), (-1.0, Set_name + 'V'+str(j),1),(-Wx, 'E11', 1), (-Wy/2, 'GAMMA12', 1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name= Constraint_name+str(s), terms=((1.0, Set_name + 'VV'+str(i),2), (-1.0, Set_name + 'V'+str(j),2),(-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1),(-Wz/2, 'GAMMA23', 1))) 
                mdb.models[ModelName].Equation(name= Constraint_name+str(s+2), terms =((1.0, Set_name + 'VV'+str(i),3), (-1.0, Set_name + 'V' +str(j),3),(-Wx/2, 'GAMMA13', 1), (-Wy/2, 'GAMMA23', 1), (-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'VV'+  str(i),9),(-1.0, Set_name + 'V' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
                
    
    Constraint_name='Eq-Edges_RR_R' 
    s=0 
    for i in range(len(Set_RR)):
        coord_X_RR=Noeuds[Set_RR[i]].coordinates[0]
        coord_Y_RR=Noeuds[Set_RR[i]].coordinates[1]
        coord_Z_RR=Noeuds[Set_RR[i]].coordinates[2]
        for j in range(len(Set_R)):
            coord_X_R= Noeuds[Set_R[j]].coordinates[0]
            coord_Y_R= Noeuds[Set_R[j]].coordinates[1]
            coord_Z_R= Noeuds[Set_R[j]].coordinates[2]
            Wx = coord_X_RR - coord_X_R
            Wy = coord_Y_RR - coord_Y_R
            Wz = coord_Z_RR - coord_Z_R
            if (abs(coord_X_RR-coord_X_R)<torl) and (abs(coord_Y_RR-coord_Y_R)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'RR'+str(i), 1), (-1.0, Set_name + 'R'+str(j), 1),(-Wx, 'E11', 1), (-Wy/2, 'GAMMA12', 1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'RR' +str(i), 2), (-1.0, Set_name + 'R'+str(j), 2),(-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'RR'+str(i), 3), (-1.0, Set_name + 'R'+str(j), 3),(-Wx/2, 'GAMMA13', 1), (-Wy/2, 'GAMMA23', 1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'RR'+  str(i),9),(-1.0, Set_name + 'R' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
                
    Constraint_name='Eq-Edges_TT_T' 
    s=0 
    for i in range(len(Set_TT)):
        coord_X_TT=Noeuds[Set_TT[i]].coordinates[0]
        coord_Y_TT=Noeuds[Set_TT[i]].coordinates[1]
        coord_Z_TT=Noeuds[Set_TT[i]].coordinates[2]
        for j in range(len(Set_T)):
            coord_X_T= Noeuds[Set_T[j]].coordinates[0]
            coord_Y_T= Noeuds[Set_T[j]].coordinates[1]
            coord_Z_T= Noeuds[Set_T[j]].coordinates[2]
            Wx = coord_X_TT - coord_X_T
            Wy = coord_Y_TT - coord_Y_T
            Wz = coord_Z_TT - coord_Z_T
            if (abs(coord_X_TT-coord_X_T)<torl) and (abs(coord_Y_TT-coord_Y_T)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'TT'+str(i), 1), (-1.0, Set_name + 'T'+str(j), 1),(-Wx, 'E11', 1), (-Wy/2, 'GAMMA12', 1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'TT' +str(i), 2), (-1.0, Set_name + 'T'+str(j), 2), (-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'TT'+str(i), 3), (-1.0, Set_name + 'T'+str(j), 3),(-Wx/2, 'GAMMA13', 1),(-Wy/2, 'GAMMA23', 1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'TT'+  str(i),9),(-1.0, Set_name + 'T' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
                
    Constraint_name='Eq-Corners_B_A' 
    s=0 
    for i in range(len(Set_B)):
        coord_X_B=Noeuds[Set_B[i]].coordinates[0]
        coord_Y_B=Noeuds[Set_B[i]].coordinates[1]
        coord_Z_B=Noeuds[Set_B[i]].coordinates[2]
        for j in range(len(Set_A)):
            coord_X_A= Noeuds[Set_A[j]].coordinates[0]
            coord_Y_A= Noeuds[Set_A[j]].coordinates[1]
            coord_Z_A= Noeuds[Set_A[j]].coordinates[2]
            Wx = coord_X_B - coord_X_A
            Wy = coord_Y_B - coord_Y_A
            Wz = coord_Z_B - coord_Z_A
            if (abs(coord_Y_B-coord_Y_A)<torl) and (abs(coord_Z_B-coord_Z_A)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'B' + str(i), 1), (-1.0, Set_name + 'A'+ str(j), 1), (-Wx, 'E11', 1),(-Wy/2, 'GAMMA12', 1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'B'  + str(i), 2), (-1.0, Set_name + 'A'+ str(j), 2), (-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'B' + str(i), 3), (-1.0, Set_name + 'A'+ str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2, 'GAMMA23', 1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'B'+  str(i),9),(-1.0, Set_name + 'A' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
                
    Constraint_name='Eq-Corners_BB_AA' 
    s=0 
    for i in range(len(Set_BB)):
        coord_X_BB=Noeuds[Set_BB[i]].coordinates[0]
        coord_Y_BB=Noeuds[Set_BB[i]].coordinates[1]
        coord_Z_BB=Noeuds[Set_BB[i]].coordinates[2]
        for j in range(len(Set_AA)):
            coord_X_AA= Noeuds[Set_AA[j]].coordinates[0]
            coord_Y_AA= Noeuds[Set_AA[j]].coordinates[1]
            coord_Z_AA= Noeuds[Set_AA[j]].coordinates[2]
            Wx = coord_X_BB - coord_X_AA
            Wy = coord_Y_BB - coord_Y_AA
            Wz = coord_Z_BB - coord_Z_AA
            if (abs(coord_Y_BB-coord_Y_AA)<torl) and (abs(coord_Z_BB-coord_Z_AA)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'BB' + str(i), 1), (-1.0, Set_name + 'AA'+ str(j), 1), (-Wx, 'E11', 1),(-Wy/2, 'GAMMA12', 1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'BB'  + str(i), 2), (-1.0, Set_name + 'AA'+ str(j), 2), (-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'BB' + str(i), 3), (-1.0, Set_name + 'AA'+ str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2, 'GAMMA23', 1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'BB'+  str(i),9),(-1.0, Set_name + 'AA' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4            
    
    Constraint_name='Eq-Corners_C_D' 
    s=0
    for i in range(len(Set_C)):
        coord_X_C=Noeuds[Set_C[i]].coordinates[0]
        coord_Y_C=Noeuds[Set_C[i]].coordinates[1]
        coord_Z_C=Noeuds[Set_C[i]].coordinates[2]
        for j in range(len(Set_D)):
            coord_X_D= Noeuds[Set_D[j]].coordinates[0]
            coord_Y_D= Noeuds[Set_D[j]].coordinates[1]
            coord_Z_D= Noeuds[Set_D[j]].coordinates[2]
            Wx = coord_X_C - coord_X_D
            Wy = coord_Y_C - coord_Y_D
            Wz = coord_Z_C - coord_Z_D
            if (abs(coord_Y_C-coord_Y_D)<torl) and (abs(coord_Z_C-coord_Z_D)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'C' + str(i), 1), (-1.0, Set_name + 'D'+ str(j), 1), (-Wx, 'E11', 1),(-Wy/2, 'GAMMA12', 1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'C' + str(i), 2), (-1.0, Set_name + 'D'+ str(j), 2), (-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1),(-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'C' + str(i), 3), (-1.0, Set_name + 'D'+ str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2, 'GAMMA23', 1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'C'+  str(i),9),(-1.0, Set_name + 'D' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
    
    
    Constraint_name='Eq-Corners_CC_C' 
    s=0
    for i in range(len(Set_CC)):
        coord_X_CC=Noeuds[Set_CC[i]].coordinates[0]
        coord_Y_CC=Noeuds[Set_CC[i]].coordinates[1]
        coord_Z_CC=Noeuds[Set_CC[i]].coordinates[2]
        for j in range(len(Set_C)):
            coord_X_C= Noeuds[Set_C[j]].coordinates[0]
            coord_Y_C= Noeuds[Set_C[j]].coordinates[1]
            coord_Z_C= Noeuds[Set_C[j]].coordinates[2]
            Wx = coord_X_CC - coord_X_C
            Wy = coord_Y_CC - coord_Y_C
            Wz = coord_Z_CC - coord_Z_C
            if (abs(coord_X_CC-coord_X_C)<torl) and (abs(coord_Y_CC-coord_Y_C)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'CC' + str(i), 1), (-1.0, Set_name + 'C'+ str(j), 1),(-Wx, 'E11', 1),(-Wy/2, 'GAMMA12', 1), (-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'CC' + str(i), 2), (-1.0, Set_name + 'C'+ str(j), 2),(-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1), (-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'CC' + str(i), 3), (-1.0, Set_name + 'C'+ str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2, 'GAMMA23', 1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'CC'+  str(i),9),(-1.0, Set_name + 'C' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
    
    Constraint_name='Eq-Corners_AA_A' 
    s=0
    for i in range(len(Set_AA)):
        coord_X_AA=Noeuds[Set_AA[i]].coordinates[0]
        coord_Y_AA=Noeuds[Set_AA[i]].coordinates[1]
        coord_Z_AA=Noeuds[Set_AA[i]].coordinates[2]
        for j in range(len(Set_A)):
            coord_X_A= Noeuds[Set_A[j]].coordinates[0]
            coord_Y_A= Noeuds[Set_A[j]].coordinates[1]
            coord_Z_A= Noeuds[Set_A[j]].coordinates[2]
            Wx = coord_X_AA - coord_X_A
            Wy = coord_Y_AA - coord_Y_A
            Wz = coord_Z_AA - coord_Z_A
            if (abs(coord_X_AA-coord_X_A)<torl) and (abs(coord_Y_AA-coord_Y_A)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'AA' + str(i), 1), (-1.0, Set_name + 'A'+ str(j), 1),(-Wx, 'E11', 1),(-Wy/2, 'GAMMA12', 1), (-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'AA' + str(i), 2), (-1.0, Set_name + 'A'+ str(j), 2),(-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1), (-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'AA' + str(i), 3), (-1.0, Set_name + 'A'+ str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2, 'GAMMA23', 1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'AA'+  str(i),9),(-1.0, Set_name + 'A' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4           
                
                
    Constraint_name='Eq-Corners_DD_D' 
    s=0
    for i in range(len(Set_DD)):
        coord_X_DD=Noeuds[Set_DD[i]].coordinates[0]
        coord_Y_DD=Noeuds[Set_DD[i]].coordinates[1]
        coord_Z_DD=Noeuds[Set_DD[i]].coordinates[2]
        for j in range(len(Set_D)):
            coord_X_D= Noeuds[Set_D[j]].coordinates[0]
            coord_Y_D= Noeuds[Set_D[j]].coordinates[1]
            coord_Z_D= Noeuds[Set_D[j]].coordinates[2]
            Wx = coord_X_DD - coord_X_D
            Wy = coord_Y_DD - coord_Y_D
            Wz = coord_Z_DD - coord_Z_D
            if (abs(coord_Y_DD-coord_Y_D)<torl) and (abs(coord_X_DD-coord_X_D)<torl):
                mdb.models[ModelName].Equation(name = Constraint_name+str(s),terms = ((1.0, Set_name + 'DD' + str(i), 1), (-1.0, Set_name + 'D'+ str(j), 1),(-Wx, 'E11', 1),(-Wy/2, 'GAMMA12', 1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+1), terms = ((1.0, Set_name + 'DD' + str(i), 2), (-1.0, Set_name + 'D'+ str(j), 2),(-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1), (-Wz/2, 'GAMMA23', 1)))
                mdb.models[ModelName].Equation(name = Constraint_name+str(s+2), terms = ((1.0, Set_name + 'DD' + str(i), 3), (-1.0, Set_name + 'D'+ str(j), 3), (-Wx/2, 'GAMMA13', 1),(-Wy/2, 'GAMMA23', 1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'DD'+  str(i),9),(-1.0, Set_name + 'D' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4            
                
    
    Constraint_name='Eq-Corners_D_A' 
    s=0 
    for i in range(len(Set_D)): 
        coord_X_D=Noeuds[Set_D[i]].coordinates[0]
        coord_Y_D=Noeuds[Set_D[i]].coordinates[1]
        coord_Z_D=Noeuds[Set_D[i]].coordinates[2] 
        for j in range(len(Set_A)):
            coord_X_A= Noeuds[Set_A[j]].coordinates[0]
            coord_Y_A= Noeuds[Set_A[j]].coordinates[1]
            coord_Z_A= Noeuds[Set_A[j]].coordinates[2] 
            Wx = coord_X_D - coord_X_A
            Wy = coord_Y_D - coord_Y_A
            Wz = coord_Z_D - coord_Z_A
            if (abs(coord_X_D - coord_X_A)<torl) and (abs(coord_Z_D - coord_Z_A)<torl): 
                mdb.models[ModelName].Equation(name= Constraint_name+str(s+1), terms=((1.0, Set_name + 'D' + str(i),1), (-1.0, Set_name + 'A'+ str(j),1),(-Wx, 'E11', 1),(-Wy/2, 'GAMMA12', 1),(-Wz/2, 'GAMMA13', 1)))
                mdb.models[ModelName].Equation(name= Constraint_name+str(s), terms=((1.0, Set_name + 'D' + str(i),2), (-1.0, Set_name + 'A'+ str(j),2),(-Wx/2, 'GAMMA12', 1),(-Wy, 'E22', 1), (-Wz/2, 'GAMMA23', 1))) 
                mdb.models[ModelName].Equation(name= Constraint_name+str(s+2), terms =((1.0, Set_name + 'D' + str(i),3), (-1.0, Set_name + 'A'+ str(j),3),(-Wx/2, 'GAMMA13', 1),(-Wy/2, 'GAMMA23', 1),(-Wz, 'E33', 1)))
                mdb.models[ModelName].Equation(name=Constraint_name+str(s+3),terms=((1.0, Set_name +'D'+  str(i),9),(-1.0, Set_name + 'A' + str(j),9),(-Wx,'ELEC1', 9),(-Wy,'ELEC2',9),(-Wz,'ELEC3',9)))
                s=s+4
    
    # Applying Boundary Conditions through Reference Points...............BC-E11
    #def CreateLoad (RVE_para,RVEModel ,RVEAssembly):
    r1 = mdb.models[ModelName].rootAssembly.referencePoints
    refPoints1=(r1[k], ) 
    region = refPoints1
    mdb.models[ModelName].DisplacementBC(name='BC-E11', createStepName='Step-1', 
            region=region, u1=0, u2=UNSET, u3=UNSET, ur1=UNSET, ur2=UNSET, 
            ur3=UNSET, amplitude=UNSET, fixed=OFF, distributionType=UNIFORM, 
            fieldName='', localCsys=None)
    
    refPoints1=(r1[k+1], ) 
    region = refPoints1
    mdb.models[ModelName].DisplacementBC(name='BC-E22', createStepName='Step-1', 
            region=region, u1=1.0, u2=UNSET, u3=UNSET, ur1=UNSET, ur2=UNSET, 
            ur3=UNSET, amplitude=UNSET, fixed=OFF, distributionType=UNIFORM, 
            fieldName='', localCsys=None)
    
    refPoints1=(r1[k+2], ) 
    region = refPoints1
    mdb.models[ModelName].DisplacementBC(name='BC-GAMMA12', createStepName='Step-1', 
            region=region, u1=0, u2=UNSET, u3=UNSET, ur1=UNSET, ur2=UNSET, 
            ur3=UNSET, amplitude=UNSET, fixed=OFF, distributionType=UNIFORM, 
            fieldName='', localCsys=None)
    
    refPoints1=(r1[k+3], ) 
    region = refPoints1
    mdb.models[ModelName].DisplacementBC(name='BC-E33', createStepName='Step-1', 
            region=region, u1=0, u2=UNSET, u3=UNSET, ur1=UNSET, ur2=UNSET, 
            ur3=UNSET, amplitude=UNSET, fixed=OFF, distributionType=UNIFORM, 
            fieldName='', localCsys=None)
    
    refPoints1=(r1[k+4], ) 
    region = refPoints1
    mdb.models[ModelName].DisplacementBC(name='BC-GAMMA13', createStepName='Step-1', 
            region=region, u1=0, u2=UNSET, u3=UNSET, ur1=UNSET, ur2=UNSET, 
            ur3=UNSET, amplitude=UNSET, fixed=OFF, distributionType=UNIFORM, 
            fieldName='', localCsys=None)
    
    refPoints1=(r1[k+5], ) 
    region = refPoints1
    mdb.models[ModelName].DisplacementBC(name='BC-GAMMA23', createStepName='Step-1', 
            region=region, u1=0, u2=UNSET, u3=UNSET, ur1=UNSET, ur2=UNSET, 
            ur3=UNSET, amplitude=UNSET, fixed=OFF, distributionType=UNIFORM, 
            fieldName='', localCsys=None)
    
    refPoints1=(r1[k+6], ) 
    region = refPoints1
    mdb.models[ModelName].ElectricPotentialBC(name='BC-ELEC1', createStepName='Step-1', region=region, fixed=OFF, 
            distributionType=UNIFORM, fieldName='', magnitude=0.0, amplitude=UNSET)
            
    refPoints1=(r1[k+7], ) 
    region = refPoints1
    mdb.models[ModelName].ElectricPotentialBC(name='BC-ELEC2', createStepName='Step-1', region=region, fixed=OFF, 
            distributionType=UNIFORM, fieldName='', magnitude=0.0, amplitude=UNSET)
            
    refPoints1=(r1[k+8], ) 
    region = refPoints1
    mdb.models[ModelName].ElectricPotentialBC(name='BC-ELEC3', createStepName='Step-1', region=region, fixed=OFF, 
            distributionType=UNIFORM, fieldName='', magnitude=0.0, amplitude=UNSET)
            
    ##region = mdb.models[ModelName].rootAssembly.sets ['Centre']
    ##mdb.models[ModelName].DisplacementBC(name='BC-centre', createStepName='Step-1', region=region , u1=0.0, u2=0.0, u3=0.0, fixed=OFF, fieldName=' ', localCsys=None)
    ##region = mdb.models[ModelName].rootAssembly.sets ['Centre']
    ##mdb.models[ModelName].ElectricPotentialBC(name='BC-centre-elec', createStepName='Step-1', region=region, fixed=OFF, distributionType=UNIFORM, fieldName='', magnitude=0.0, amplitude=UNSET)
    
    ##Create the job 
    #def CreateJob (RVE_para): # Inital parameter 
    JobName = 'multiparticle_RVE_ESO_BT_PANI_50nm_E22_'+ nn
    RVEJob = mdb.Job(name=JobName, model=ModelName) 
    # Submit job
    #mdb.jobs[JobName].submit(consistencyChecking=OFF, datacheckJob=True)
    RVEJob.submit(consistencyChecking=OFF)
    #Wait the job to complete 
    RVEJob.waitForCompletion()
    
    mdb.Model(modelType=STANDARD_EXPLICIT, name='Model-'+str(jjj+1))
    
    print 'Post-processing of Results for Model-'+str(jjj)+' BC-E22'
    
    #def CreateResult (RVE_para,stif): 
    # Inital parameter 
    odb = openOdb(path=cwd+'\\'+JobName+'.odb')
    for instanceName in odb.rootAssembly.instances.keys():
        print instanceName
    for stepName in odb.steps.keys():
        print stepName
    stepName='Step-1'
    lastFrame=odb.steps[stepName].frames[-1]
    instanceName='Composite-1'
    for fieldName in lastFrame.fieldOutputs.keys():
        print fieldName
        
    for f in lastFrame.fieldOutputs.values():
        print f.name, ':', f.description
        print 'Type: ', f.type
    # For each location value, print the position.
        for loc in f.locations:
           print 'Position:',loc.position
           print
           
    myInstance = odb.rootAssembly.instances['COMPOSITE-1']
    
    stressField = lastFrame.fieldOutputs['S']
    strainField = lastFrame.fieldOutputs['E']
    elecdispField=lastFrame.fieldOutputs['EFLX']
    elecpotField=lastFrame.fieldOutputs['EPOT']
    elecpotgradField=lastFrame.fieldOutputs['EPG']
    elementVolume=lastFrame.fieldOutputs['EVOL']
    
    num_elements=len(myInstance.elements)
    
        
    f1=open('Stress_BC_E33_volFrac_'+nn+'.txt','w')
    f1.write('Elements\t Stress11\t Stress22\t Stress33\t Stress12\t Stress13\t Stress23 \n')
    vol_stress11=0
    vol_stress22=0
    vol_stress33=0
    vol_stress12=0
    vol_stress13=0
    vol_stress23=0
    vol_elements_total=0       
    stressvalues=stressField.values
    elementVolumevalues=elementVolume.values
    for i in range(len(elementVolumevalues)):
        #print 'EVOL = %6.4f\n' % elementVolumevalues[i].data
        vol_elements_total=vol_elements_total+elementVolumevalues[i].data
        field = stressField.getSubset(region=myInstance.elements[i],position=CENTROID, elementType = 'C3D4E')
        fieldValues = field.values
        for v_stress in fieldValues:
            vol_stress11=vol_stress11+(v_stress.data[0]*elementVolumevalues[i].data)
            vol_stress22=vol_stress22+(v_stress.data[1]*elementVolumevalues[i].data)
            vol_stress33=vol_stress33+(v_stress.data[2]*elementVolumevalues[i].data)
            vol_stress12=vol_stress12+(v_stress.data[3]*elementVolumevalues[i].data)
            vol_stress13=vol_stress13+(v_stress.data[4]*elementVolumevalues[i].data)
            vol_stress23=vol_stress23+(v_stress.data[5]*elementVolumevalues[i].data)
            f1.write('%d\t %12.8f \t %12.8f \t %12.8f \t %12.8f \t %12.8f \t %12.8f\n' %(v_stress.elementLabel,v_stress.data[0],v_stress.data[1],v_stress.data[2],v_stress.data[3],v_stress.data[4],v_stress.data[5]))
    
    avg_stress11=vol_stress11/vol_elements_total
    avg_stress22=vol_stress22/vol_elements_total
    avg_stress33=vol_stress33/vol_elements_total
    avg_stress12=vol_stress12/vol_elements_total
    avg_stress13=vol_stress13/vol_elements_total
    avg_stress23=vol_stress23/vol_elements_total
    print vol_elements_total
    print 'average stress11=' , avg_stress11
    print 'average stress22=' , avg_stress22
    print 'average stress33=' , avg_stress33
    print 'average stress12=' , avg_stress12
    print 'average stress13=' , avg_stress13
    print 'average stress23=' , avg_stress23
    
    f1.write('\n volume average stress11 = %20.8f' %avg_stress11)
    f1.write('\n volume average stress22 = %20.8f' %avg_stress22)
    f1.write('\n volume average stress33 = %20.8f' %avg_stress33)
    f1.write('\n volume average stress12 = %20.8f' %avg_stress12)
    f1.write('\n volume average stress13 = %20.8f' %avg_stress13)
    f1.write('\n volume average stress23 = %20.8f' %avg_stress23)
    f1.close()
    
    
    f2=open('Strain_BC_E33_volFrac_'+nn+'.txt','w')
    f2.write('Elements\t Strain11\t Strain22\t Strain33\t Strain12\t Strain13\t Strain23 \n')
    f2.write('Elements\t Strain12 \n')
    vol_strain11=0
    vol_strain22=0
    vol_strain33=0
    vol_strain12=0
    vol_strain13=0
    vol_strain23=0
    vol_elements_total=0       
    strainvalues=strainField.values
    elementVolumevalues=elementVolume.values
    for i in range(len(elementVolumevalues)):
        #print 'EVOL = %6.4f\n' % elementVolumevalues[i].data
        vol_elements_total=vol_elements_total+elementVolumevalues[i].data
        field = strainField.getSubset(region=myInstance.elements[i],position=CENTROID, elementType = 'C3D4E')
        fieldValues = field.values
        for v_strain in fieldValues:
            vol_strain11=vol_strain11+(v_strain.data[0]*elementVolumevalues[i].data)
            vol_strain22=vol_strain22+(v_strain.data[1]*elementVolumevalues[i].data)
            vol_strain33=vol_strain33+(v_strain.data[2]*elementVolumevalues[i].data)
            vol_strain12=vol_strain12+(v_strain.data[3]*elementVolumevalues[i].data)
            vol_strain13=vol_strain13+(v_strain.data[4]*elementVolumevalues[i].data)
            vol_strain23=vol_strain23+(v_strain.data[5]*elementVolumevalues[i].data)
            f2.write('%d\t %20.8f \t %20.8f \t %20.8f \t %20.8f \t %20.8f \t %20.8f\n' %(v_strain.elementLabel,v_strain.data[0],v_strain.data[1],v_strain.data[2],v_strain.data[3],v_strain.data[4],v_strain.data[5]))
##            f2.write('%d\t %6.8f\n' %(v_strain.elementLabel,v_strain.data[3]))

    avg_strain11=vol_strain11/vol_elements_total
    avg_strain22=vol_strain22/vol_elements_total
    avg_strain33=vol_strain33/vol_elements_total
    avg_strain12=vol_strain12/vol_elements_total
    avg_strain13=vol_strain13/vol_elements_total
    avg_strain23=vol_strain23/vol_elements_total
    print vol_elements_total
    print 'average strain11=' , avg_strain11
    print 'average strain22=' , avg_strain22
    print 'average strain33=' , avg_strain33
    print 'average strain12=' , avg_strain12
    print 'average strain13=' , avg_strain13
    print 'average strain23=' , avg_strain23

    f2.write('\n volume average strain11 = %20.6f' %avg_strain11)
    f2.write('\n volume average strain22 = %20.6f' %avg_strain22)
    f2.write('\n volume average strain33 = %20.6f' %avg_strain33)
    f2.write('\n volume average strain12 = %20.6f' %avg_strain12)
    f2.write('\n volume average strain13 = %20.6f' %avg_strain13)
    f2.write('\n volume average strain23 = %20.6f' %avg_strain23)
    f2.close()

    f3=open('Electric_Displacement_BC_E33_volFrac_'+nn+'.txt','w')
    f3.write('Elements\t D1\t D2\t D3 \n')
    vol_elec_disp1=0
    vol_elec_disp2=0
    vol_elec_disp3=0
    vol_elements_total=0  
    elecdispvalues=elecdispField.values
    elementVolumevalues=elementVolume.values
    for i in range(len(elementVolumevalues)):
        #print 'EVOL = %6.4f\n' % elementVolumevalues[i].data
        vol_elements_total=vol_elements_total+elementVolumevalues[i].data
        field = elecdispField.getSubset(region=myInstance.elements[i],position=CENTROID, elementType = 'C3D4E')
        fieldValues = field.values
        for v_elec_disp in fieldValues:
            vol_elec_disp1=vol_elec_disp1+(v_elec_disp.data[0]*elementVolumevalues[i].data)
            vol_elec_disp2=vol_elec_disp2+(v_elec_disp.data[1]*elementVolumevalues[i].data)
            vol_elec_disp3=vol_elec_disp3+(v_elec_disp.data[2]*elementVolumevalues[i].data)
            f3.write('%d\t %20.8f \t %20.8f \t %20.8f  \n' %(v_elec_disp.elementLabel,v_elec_disp.data[0],v_elec_disp.data[1],v_elec_disp.data[2]))

    avg_elec_disp1=vol_elec_disp1/vol_elements_total
    avg_elec_disp2=vol_elec_disp2/vol_elements_total
    avg_elec_disp3=vol_elec_disp3/vol_elements_total

    print vol_elements_total
    print 'average electricdisplacement1=' , avg_elec_disp1
    print 'average  electricdisplacement2=' , avg_elec_disp2
    print 'average  electricdisplacement3=' , avg_elec_disp3

    f3.write('\n volume average electricdisplacement1 = %20.20f' %avg_elec_disp1)
    f3.write('\n volume average electricdisplacement2 = %20.20f' %avg_elec_disp2)
    f3.write('\n volume average electricdisplacement3 = %20.20f' %avg_elec_disp3)

    f3.close()

#   f4=open('Electric_Potential_Gradient_BC_E33_volFrac_'+nn+'.txt','w')
#   f4.write('Elements\t EPG1\t EPG2\t EPG3 \n')
#   vol_elec_pot_grad1=0
#   vol_elec_pot_grad2=0
#   vol_elec_pot_grad3=0
#   vol_elements_total=0  
#   elecpotgradvalues=elecpotgradField.values
#   elementVolumevalues=elementVolume.values
#   for i in range(len(elementVolumevalues)):
#       #print 'EVOL = %6.4f\n' % elementVolumevalues[i].data
#       vol_elements_total=vol_elements_total+elementVolumevalues[i].data
#       field = elecpotgradField.getSubset(region=myInstance.elements[i],position=CENTROID, elementType = 'C3D4E')
#       fieldValues = field.values
#       for v_elec_pot_grad in fieldValues:
#           vol_elec_pot_grad1=vol_elec_pot_grad1+(v_elec_pot_grad.data[0]*elementVolumevalues[i].data)
#           vol_elec_pot_grad2=vol_elec_pot_grad2+(v_elec_pot_grad.data[1]*elementVolumevalues[i].data)
#           vol_elec_pot_grad3=vol_elec_pot_grad3+(v_elec_pot_grad.data[2]*elementVolumevalues[i].data)
#           f4.write('%d\t %20.8f \t %20.8f \t %20.8f \n' %(v_elec_pot_grad.elementLabel,v_elec_pot_grad.data[0],v_elec_pot_grad.data[1],v_elec_pot_grad.data[2]))
#
#   avg_elec_pot_grad1=vol_elec_pot_grad1/vol_elements_total
#   avg_elec_pot_grad2=vol_elec_pot_grad2/vol_elements_total
#   avg_elec_pot_grad3=vol_elec_pot_grad3/vol_elements_total
#
#   print vol_elements_total
#   print 'average electricpotentialgrad1=' , avg_elec_pot_grad1
#   print 'average  electricpotentialgrad2=' , avg_elec_pot_grad2
#   print 'average  electricpotentialgrad3=' , avg_elec_pot_grad3
#
#   f4.write('\n volume average electricpotentialgrad1 = %20.20f' %avg_elec_pot_grad1)
#   f4.write('\n volume average electricpotentialgrad2 = %20.20f' %avg_elec_pot_grad2)
#   f4.write('\n volume average electricpotentialgrad3 = %20.20f' %avg_elec_pot_grad3)
#   f4.close()

    C21=avg_stress11/avg_strain22
    C22=avg_stress22/avg_strain22
    C23=avg_stress33/avg_strain22
    C24=avg_stress23/avg_strain22
    C25=avg_stress13/avg_strain22
    C26=avg_stress12/avg_strain22
    e12=avg_elec_disp1/avg_strain22
    e22=avg_elec_disp2/avg_strain22
    e32=avg_elec_disp3/avg_strain22
    
    
    file.write('%4.5f \t  %12.8f \t %12.8f \t %12.8f \t %12.8f \t%12.8f \t %12.8f \t %12.8f \t %12.8f \t %12.8f\n '%(vol_frac,C21,C22,C23,C24,C25,C26,e12,e22,e32))




file.close()
