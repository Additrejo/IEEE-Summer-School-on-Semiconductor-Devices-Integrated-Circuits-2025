# (c) Silvaco Inc., 2024

# 55nm CMOS Core Device Characterization

# Required Modules
# Victory Process
# -2D Diffusion & Implantation
# -2D Oxidation
# Victory Mesh
# -2D Meshing
# Victory Device
# -2D Simulator

# Example Name
SET name='Adv_CMOS_ex04'

# Full flow from process to device simulation of CMOS
55nm Core Device
# Process simulation:
# -Various process modules are integrated into a single flow
# -Calibration steps are included in comments
# Electrical Simulation:
# -Transfer Characterization: IdWglin and IdWgsat Simulation
# -Parameter extraction: Vtqm/Vtlin/Idlin/Visat/Idsat/Idoff/OIBL Extraction

###** PROCESS SIMULATION ###**

# Symmetrical 55nm core device structure. Only half simulated to SAVE time.
# Mirrored at the end of process simulation.

## ...... ##
## ...... Initialization ...... ##
## ...... ##

60 victoryprocess simflags="-P 4"

SET type="NMOS"

SET Lgate=0.06    # Poly Gate Length [μm]
SET Lsd = 0.12    # Source/Drain half AA Length [μm]
SET Ldomain=$Lgate/2+$Lsd    # Simulation Domain (half-Device) [μm]

INIT material=silicon orientation=100 sub.rot=45 dopant=boron resistivity=10 \
depth=5.0 gasHeight=1 from=0.0 to=$Ldomain \
resolution=0.008 meshdepth=3

LINE x location=0    spacing=$Lgate/20
LINE x location=$Ldomain    spacing=$Lsd/10

LINE z location=-0.1    spacing=0.02
LINE z location=0.0    spacing=0.002
LINE z location=0.1    spacing=0.01
LINE z location=0.5    spacing=0.05
LINE z location=2.0    spacing=0.1
LINE z location=5.0    spacing=0.3

# Load calibration file:
SOURCE $'name'_Calib

## ...... ##
## ...... Well Loop ...... ##
## ...... ##

DEPOSIT min material=oxide thickness=0.01

if cond=($type="PMOS")
## PMe11
IMPLANT phosphorus energy=300 dose=5.0e12 tilt=0 rotation=22 bca n.ion=5000 plus.n
IMPLANT phosphorus energy=200 dose=5.0e12 tilt=0 rotation=22 bca n.ion=5000 plus.n
IMPLANT phosphorus energy=100 dose=5.0e12 tilt=0 rotation=22 bca n.ion=5000 plus.n
IMPLANT arsenic energy=100 dose=8.0e12 tilt=0 rotation=22 bca n.ion=5000 plus.n
if.end

if cond=($type="NMOS")
## NMOS Well formation
IMPLANT boron energy=150 dose=5.0e12 tilt=0 rotation=22 bca n.ion=5000 plus.n
IMPLANT boron energy=100 dose=5.0e12 tilt=0 rotation=22 bca n.ion=5000 plus.n
IMPLANT boron energy=50 dose=5.0e12 tilt=0 rotation=22 bca n.ion=5000 plus.n
IMPLANT bf2 energy=50 dose=1.0e13 tilt=0 rotation=22 bca n.ion=5000 plus.n
if.end

## Well RTA
DIFFUSE time=10 sec temperature=600 t.final=1000
DIFFUSE time=20 sec temperature=1000
DIFFUSE time=10 sec temperature=1000 t.final=600

ETCH dry material=oxide thickness=0.011

SAVE name=$'name'_$'type'_VP_Well conformalstr

## ...... ##
## ...... 60X Loop ...... ##
## ...... ##

# Local Parameters: OED (may adjust for calibration purpose)

# GOX1: IO thick oxide
DIFFUSE time=20 temperature=900 f.o2=10 pressure=1

EXTRACT name="Tgox1" thickness material="Sio-2" mat.occno=1 x.val=$Lgate/4 
STRIP material=oxide

# GOX2: core thin oxide 
DIFFUSE time=20 temperature=850 f.o2=1 f.h2=1 f.n2=10 pressure=1

EXTRACT name="Tgox2" thickness material="Sio-2" mat.occno=1 x.val=$Lgate/4 
STRIP material=oxide

# precisely control the Oxide thickness 
DEPOSIT min material=oxide thickness=0.0025

## PMA 
DIFFUSE time=10 sec temperature=600 t.final=1100 
DIFFUSE time=20 sec temperature=1100 
DIFFUSE time=10 sec temperature=1100 t.final=600

## ...... ## 
## ...... Poly Loop ...... ## 
## ...... ##

# Local Parameters: OED (may adjust for calibration purpose)

# mesh adjustment
LINE x location=$Lgate/2    spacing=0.005
DEPOSIT conformal material=Polysilicon thickness=0.1
ETCH dry material="Polysilicon,oxide" thickness=0.1+0.0025+0.01 right.to.x=$Lgate/2

# PolyReOX
DIFFUSE time=10 sec temperature=600 t.final=1000 f.n2=10 pressure=1
DIFFUSE time=20 sec temperature=1000 f.o2=10 pressure=1
DIFFUSE time=10 sec temperature=1000 t.final=600 f.n2=10 pressure=1

EXTRACT name="TpolyReOx" thickness material="Sio-2" mat.occno=1 x.val=$Lgate/4
EXTRACT name="TgoxReOx" thickness material="Sio-2" mat.occno=2 x.val=$Lgate/4

SAVE name=$'name'_$'type'_VP_Poly conformalstr

# Mesh Adjustment
LINE x location=$Lgate/2    spacing=0.005 remove
LINE x location=$Lgate/2-0.02    spacing=0.003
LINE x location=$Lgate/2    spacing=0.002
LINE x location=$Lgate/2+0.03    spacing=0.004

# Refine mesh near silicon surface
LINE z location=0.0    spacing=0.002 remove
LINE z location=0.0    spacing=0.001
LINE z location=0.02    spacing=0.002

### ...... ###
### ...... LDD Loop ...... ###
### ...... ###

# Local Parameters: diffusion (may adjust for calibration purpose)

## offset spacer formation
DEPOSIT conformal material=oxide thickness=0.008
ETCH dry material=oxide thickness=0.006

if cond=($type="NMOS")
### NLDD Implant
### Note for tilt implant: to use "dose=" for beam dose, to use "dose.wafer=" for wafer dose.
IMPLANT bf2   energy=30 dose=2.0e13 tilt=30 rotation=45 n.rot=4 \
reflective bca n.ion=30000 traj.split plus.n
IMPLANT indium  energy=50 dose=2.0e13 tilt=30 rotation=45 n.rot=4 \
reflective bca n.ion=30000 traj.split plus.n
IMPLANT arsenic energy=4  dose=5.0e14 tilt=0  rotation=0 \
reflective bca n.ion=30000 traj.split plus.n
if.end

if cond=($type="PMOS")
### PLDD Implant would go here
if.end

if cond=($type=="PMOS")
## PLDD Implant
## Note for tilt implant: to use "dose=" for beam dose, to use "dose.wafer=" for wafer dose.
IMPLANT phosphorus energy=25 dose=2.0e13 tilt=30 rotation=45 n.rot=4 \
    reflective bca n.ion=30000 traj.split plus.n
IMPLANT arsenic   energy=30 dose=2.0e13 tilt=30 rotation=45 n.rot=4 \
    reflective bca n.ion=30000 traj.split plus.n
IMPLANT bf2       energy=2  dose=2.0e14 tilt=0 rotation=0 \
    reflective bca n.ion=30000 traj.split plus.n 
if.end

## LDD Spike Anneal
DIFFUSE time=2.0 sec temperature=600 t.final=1000
DIFFUSE time=1.0 sec temperature=1000
DIFFUSE time=2.0 sec temperature=1000 t.final=600

SAVE name=$'name'_$'type'_VP_LDD conformalstr

### ...... ###
### ...... Spacer Loop ...... ###
### ...... ###

# Spacer formation
DEPOSIT conformal material=nitride thickness=0.01
DEPOSIT conformal material=oxide thickness=0.02

# Continue spacer formation
DEPOSIT conformal material=nitride thickness=0.01
DEPOSIT conformal material=oxide thickness=0.02

# Spacer anneal
DIFFUSE time=30 temperature=650
DIFFUSE time=30 temperature=700

# Spacer etch
ETCH dry materials="oxide,nitride" thickness=0.03

### ...... ###
### ...... SD Loop ...... ###
### ...... ###

# Mesh Adjustment for source/drain region
LINE z location=0.1    spacing=0.01 remove
LINE z location=0.1    spacing=0.005

# Local Parameters: diffusion (may adjust for calibration purpose)

if cond=($type=="NMOS")
### NSD Implant
IMPLANT germanium  energy=20 dose=5.0e14 tilt=0 rotation=0 \
    reflective bca n.ion=30000 traj.split plus.n
IMPLANT phosphorus energy=25 dose=1.0e14 tilt=0 rotation=0 \
    reflective bca n.ion=30000 traj.split plus.n
if.end

if cond=($type=="PMOS")
## PSD Implant
IMPLANT germanium energy=20 dose=5.0e14 tilt=0 rotation=0 \
    reflective bca n.ion=30000 traj.split plus.n
IMPLANT boron    energy=10 dose=5.0e13 tilt=0 rotation=0 \
    reflective bca n.ion=30000 traj.split plus.n
IMPLANT bf2      energy=8  dose=1.0e15 tilt=0 rotation=0 \
    reflective bca n.ion=30000 traj.split plus.n
if.end

## SD Spike Anneal
DIFFUSE time=2.0 sec temperature=600 t.final=1000
DIFFUSE time=1.5 sec temperature=1000
DIFFUSE time=2.0 sec temperature=1000 t.final=600

SAVE name=$'name'_$'type'_VP_SD conformalstr

### ...... ###
### ...... Contact Loop ...... ###
### ...... ###

# Contact formation
ETCH dry materials="oxide,nitride" thickness=0.005
DEPOSIT min material=Aluminum thickness=0.01

# Mirror structure to complete full device
MIRROR mirror="-x"

# Electrode definitions
ELECTRODE name=gate x=0 z=-0.05
ELECTRODE name=source x=-$Lsd/2.0-$Lgate/2.0 z=0
ELECTRODE name=drain x=$Lsd/2.0+$Lgate/2.0 z=0
ELECTRODE name=substrate substrate

# Save final process simulation structure
SAVE name=$'name'_$'type'_VP_final conformalstr

### ...... ###
### ...... Re-Meshing ...... ###
### ...... ###

# Generate optimized mesh for device simulation
GO victorymesh simflags="-P 4"
LOAD in=$'name'_$'type'_VP_final

# Crop and remesh structure
CROP axis="z" offset=1.0
REMESH conformal

# Save meshed structure
SAVE out=$'name'_$'type'_VM_con.str

### ...... ###
### ...... DEVICE SIMULATION ...... ###
### ...... ###
### Transfer Characterisation of CMOS 55nm Core Device
### - IdVglin and IdVgsat Simulation
### - Vtgm/Vtlin/Idlin/Visat/Idsat/Idoff/OIBL Extraction

### ...... ###
### ...... Device: IdVg Characterization ...... ###
### ...... ###
### STRUCTURE SPECIFICATION ###
G0 victorydevice simflags="-P 4"

# Set device type parameters
if cond=($type=="NMOS")
    SET sign=1 
    SET WF=4.2  # Work function for NMOS [eV]
if.end

if cond=($type=="PMOS")
    SET sign=-1
    SET WF=5.1  # Work function for PMOS [eV]
if.end

# Voltage parameters
SET Vdd=1.2  # Supply voltage [V]

### Calibration Parameters ###

# Load meshed structure
MESH infile=$'name'_$'type'_VM_con.str width=1

# Contact definitions
CONTACT name=gate workfunction=$WF 
INTERFACE Qf=2.0e10  # Interface trap density [cm^-2]

### MATERIAL/PHYSICAL MODELS ###
MATERIAL material=Silicon taun0=1.0e-7*1e-2 taup0=1.0e-7*1e-2
MODELS fermi srh cvt fldmob print

### NUMERICAL METHODS ###
METHOD newton maxtrap=10
OUTPUT con.band val.band band.param u.srh e.mobility

### SOLUTION SOLVING ###
SOLVE init
SOLVE previous

# Drain voltage ramp for linear region
SOLVE vdrain=0.001*$sign
SOLVE vdrain=0.01*$sign
SOLVE vstep=0.01*$sign vfinal=0.05*$sign name=drain
SAVE outfile=temp_lowD.str

# Drain voltage ramp for saturation region
SOLVE vstep=$Vdd/10*$sign vfinal=$Vdd*$sign name=drain
SAVE outfile=temp_highD.str

### Transfer Characteristics: IdVg_lin ###
LOAD infile=temp_lowD.str
LOG outfile=$'name'_$'type'_VD_IdVg_lin.log
SOLVE vgate=0.0
SOLVE vgate=0.001*$sign
SOLVE vgate=0.01*$sign
SOLVE vstep=$Vdd/50*$sign vfinal=$Vdd*$sign name=gate
LOG off
SAVE outfile=$'name'_$'type'_VD_IdVg_lin.str

### Transfer Characteristics: IdVg_sat ###
LOAD infile=temp_highD.str
LOG outfile=$'name'_$'type'_VD_IdVg_sat.log

# Saturation region gate voltage sweep
SOLVE vgate=0.0
SOLVE vgate=0.001*$sign
SOLVE vgate=0.01*$sign
SOLVE vstep=$Vdd/50*$sign vfinal=$Vdd*$sign name=gate
LOG off
SAVE outfile=$'name'_$'type'_VD_IdVg_sat.str

### ...... ###
### ...... Device: Parameter Extraction ...... ###
### ...... ###

GO internal

# Linear region parameter extraction
EXTRACT init infile=$'name'_$'type'_VD_IdVg_lin.log
EXTRACT name="vtgm" (xintercept(maxslope(curve(abs(v."gate"),abs(i."drain"))) - abs(ave(v."drain"))/2.0
EXTRACT name="vtlin" x.val from curve(abs(v."gate"),abs(i."drain")) where y.val=1.0e-8/$Lgate
EXTRACT name="Idlin" max(abs(i."drain"))*(1e6)

# Saturation region parameter extraction
EXTRACT init infile=$'name'_$'type'_VD_IdVg_sat.log
EXTRACT name="Vtsat" x.val from curve(abs(v."gate"),abs(i."drain")) where y.val=1.0e-8/$Lgate
EXTRACT name="Idsat" max(abs(i."drain"))*(1e6)
# Additional parameter extraction
EXTRACT name="DIBL" ($vtlin-$Vtsat)*1000  # Drain-Induced Barrier Lowering [mV/V]
EXTRACT name="Idoff" y.val from curve(abs(v."gate"),abs(i."drain")) where x.val=0.0  # Off-current [A/μm]

# Visualization of results
victoryvisual \
    $'name'_$'type'_VM_con.str \
    $'name'_$'type'_VD_IdVg_lin.log:$'name'_IdVg.set \
    $'name'_$'type'_VD_IdVg_sat.log:$'name'_IdVg.set

# End simulation
QUIT