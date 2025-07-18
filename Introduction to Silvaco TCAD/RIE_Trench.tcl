# RIE Trench

# Required Modules
# Victory Mesh
# -30 Meshing

# Example Name
SET name="Wt_Solid_Model_ex09"

################ STRUCTURE MESHING #############################
60 victorymesh startflags="-P 2"

# create substrate surface mesh
UBODI from="-1,-1,-1" to="1,1,1" material="silicon" out="substrate"
SKELETON

# create outer scallop-shaped surface mesh and prepare for combine with substrate
ELLIPSODI center="0,0,0" radius.x=0.5 radius.y=0.5 radius.z=0.25 num.edges=32 material="polymer" out="outer_ellipsoid"
SKELETON
SPLICE regions="polymer" material="silicon"

# create inner scallop-shaped surface mesh and prepare for combine with outer scallop
ELLIPSODI center="0,0,0" radius.x=0.4 radius.y=0.4 radius.z=0.15 num.edges=32 material="sio2" out="inner_ellipsoid"
SKELETON
SPLICE regions="sio2" material="polymer"

# combine inner and outer scallops with substrate
COMBINE in a="outer_ellipsoid" in b="inner_ellipsoid" out="base"

# extract scallop-shaped feature
CRDP from="1,-1,-0.1" to="1,1,0.5"

# mirror subset of scallop-shaped feature 82 times
WIREOR axes="-822" offset="0.1" out="trench"

# merge adjacent regions of same material
MERGE

# extract half of device
CRDP from="0" to="1" out="rie"

# create device mesh
RERESH delaunay out="rie_delaunay"
REFINE max_size=6.05
REFINE max_interface_size=0.05 regions="silicon, size" interface.regions="polymer" grading="quadratic"

# add constant background doping
FIELD constant regions="silicon" name="phosphorus" value=1e15

SAVE out="$'name'_VM_0"

victoryvisual $'name'_VM_0.str:$'name'_VM_0.set

OUTT