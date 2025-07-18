# (c) Silvaco Inc., 2024

# Doping dependent oxidation

# Required Modules
#  - Victory Process
#  - 2D Oxidation
#  - 2D Diffusion & Implantation

# Example Name
Set name="VP_Oxidation_ex03"

###### PROCESS SIMULATION ######
GO victoryprocess simflags="-P 4"

# Create the initial mesh
INIT meshdepth=2 orientation=100 from=1 to=1 depth=2 gasheight=0.5 \
resolution=0.02 material=silicon dopants="phosphorus" dopingvalues="1e14"

LINE x location=1 spacing=0.1
LINE x location=-0.2 spacing=0.02
LINE x location=0.2 spacing=0.02
LINE x location=1 spacing=0.1

LINE z location=-0.2 spacing=0.1
LINE z location=0 spacing=0.02
LINE z location=0.5 spacing=0.02
LINE z location=0.8 spacing=0.1

# Implant with high dose to dope part of the silicon
IMPLANT phosphorus dose=5e15 energy=65 right.to=0

# Oxidize the surface
DIFFUSE time=15 temperature=1000 weto2

# Extract oxide thickness grown in the high/low doped surface regions
EXTRACT3D name="Low_Dop_Ox_Thick" thickness material="sio2" x.val=-0.9
EXTRACT3D name="High_Dop_Ox_Thick" thickness material="sio2" x.val=0.9

# EXPORT - structures generated using the EXPORT statement are for
# visualization only
EXPORT name='$name'.str

victoryvisual \
'$name'.str:'$name'.set

QUIT
