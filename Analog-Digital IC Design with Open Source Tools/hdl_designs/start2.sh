#!/bin/bash

#--------------------- Variables predeterminadas--------------------
cd hdl_designs
#--------------------- Simular diseño (manualmente):----------------
iverilog -o count_tb.vvp count_tb.v
vvp count_tb.vvp
gtkwave count_tb.vcd

#--------------------- Simular diseño con script (automático):------
./simu_linux.sh count_tb -v &

#--------------------- Síntesis------------------------------
#--------------------- Solo en caso de no contar con el archivo de restricciones (constraints) realizar:
#
#gedit counter.json
#
#--------------------- Copiar y pegar lo siguiente: ----------------
#
#{
#    "DESIGN_NAME": "counter",
#    "VERILOG_FILES": "contador.v",
#    "CLOCK_PORT": "clk",
#    "CLOCK_PERIOD": 10.0,
#    "CLOCK_NET": "clk",
#    "PL_RANDOM_INITIAL_PLACEMENT":1,
#    "DIE_AREA": "0 0 160 100",
#    "FP_CORE_UTIL": 75,
#     "MAX_FANOUT_CONSTRAINT": 5,
#    "FP_SIZING" : "absolute",
#    "BASE_SDC_FILE": "contador.sdc",
#    "FP_PDN_MULTILAYER": true
#
#}

#--------------------- Ejecutar comando de sintetizado --------------
openlane --flow Classic counter.json

#----------------- Analizar resultados ------------------------------
#--------------------- Ir a los resultados con ----------------------
cd runs/RUN_2505_xxxxx

#--------------------- Ver diseño sintetizado -----------------------
gedit 06-yosys-synthesis/counter.nl.v&
gedit 06-yosys-synthesis/yosys-synthesis.log&

#--------------------- Ver timings ----------------------------------
cat 12-openroad-staprepnr/summary.rpt

#--------------------- Ver el diseño final: -------------------------
cd final

klayout

#--------------------- File/Open, Ir el folder /final/klayout_gds y abrir el archivo counter.klayout.gds

#--------------------- Análisis del diseño --------------------------
# ver capas 69/5, 69/20 y 68-20 para la revision del diseño

