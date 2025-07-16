
## Introducing to Silvaco  
<img width="958" height="342" alt="image" src="https://github.com/user-attachments/assets/330fb489-c2df-4d91-be97-8b7847e6cd92" />
Este repositorio contiene un ejemplo desarrollado durante mi capacitación en **introducción al software Silvaco TCAD**.

Silvaco es una herramienta profesional para la **simulación de procesos y dispositivos semiconductores**, ampliamente utilizada en la industria electrónica, investigación académica y diseño de tecnología avanzada. Permite modelar y predecir fenómenos como oxidación, difusión, implantación iónica, comportamiento de dispositivos MOSFET, diodos y más.

## Requisitos

Hacer una cuenta en nanohub.com
[Nanohub](https://nanohub.org/tools/silvacotcad/session?sess=2673896)   

### Silvaco TCAD ejecución
Una vez registrado e iniciada la sesión dirigirse a  
   - Explore > Tools
   - En la barra de busqueda escribir: **Silvaco TCAD** o dirigirse a la siguiente dirección: [Silvaco TCAD Tool](https://nanohub.org/resources/silvacotcad)
   -  Dar click en Launch Tool  
  <img width="773" height="243" alt="image" src="https://github.com/user-attachments/assets/f3fafc2f-891e-4ce0-a4ee-896cc4b69ce0" />

**Silvaco TCAD Ventana**  
   - Una vez abierto elegir el Deckbuild.
   <img width="963" height="571" alt="image" src="https://github.com/user-attachments/assets/f62d8ed6-af13-4eae-9cf8-dbe20dd7be65" />

Todo está listo para empezar a trabajar.

---

# [Simulación de Oxidación Dependiente del Dopado - Silvaco TCAD](https://github.com/Additrejo/IEEE-Summer-School-on-Semiconductor-Devices-Integrated-Circuits-2025/blob/main/Introduction%20to%20Silvaco%20TCAD/Silvaco_Doping_dependent_oxidation.in)  

<img width="742" height="247" alt="image" src="https://github.com/user-attachments/assets/7742498d-89b6-4d35-b751-015b5831b530" />

## 🧪 Descripción de la Simulación

Esta simulación modela el proceso de **oxidación térmica del silicio dependiente del dopado** utilizando la herramienta **Silvaco Victory Process**.

El objetivo principal es observar cómo la presencia de dopantes (fósforo) afecta el crecimiento del óxido de silicio (SiO₂) durante un proceso de oxidación en ambiente húmedo. Se compara el espesor del óxido en regiones con **baja** y **alta concentración de dopado** para validar el fenómeno conocido como **oxidación acelerada por dopado**.

---

## 🧩 Pasos Clave del Proceso Simulado

### 1. Inicialización del simulador
```tcl
GO victoryprocess simflags="-P 4" 
```
### 2. Definición de la malla y del sustrato
```
INIT ... material=silicon dopants="phosphorus" dopingvalues="1e14"
```
Se define un sustrato de silicio con dopado inicial bajo (1e14 cm⁻³).  
### 3. Implantación de fósforo
```
IMPLANT phosphorus dose=5e15 energy=65 right.to=0
```
Se implanta una alta dosis de fósforo (5e15 cm⁻²) en la región derecha del sustrato.  
### 4. Oxidación térmica
```
DIFFUSE time=15 temperature=1000 weto2
```
Oxidación húmeda a 1000 °C durante 15 minutos. La velocidad de crecimiento del óxido depende del dopado.  
### 5. Extracción del espesor de óxido  
```
EXTRACT3D name="Low_Dop_Ox_Thick" ...
EXTRACT3D name="High_Dop_Ox_Thick" ...
```  
Se mide el espesor del óxido en dos regiones:

Baja dopación (x = -0.9)

Alta dopación (x = 0.9)  
### 56. Exportación de resultados para visualización
```
EXPORT name='$name'.str
victoryvisual '$name'.str:'$name'.set
```
Se exportan los resultados para ser visualizados en Victory Visual.  

Resultados Esperados
Se espera un espesor de óxido mayor en la región con alta concentración de dopado debido a la aceleración del crecimiento por la presencia de fósforo.

Esta simulación demuestra cómo el dopado puede afectar directamente la evolución de procesos en la fabricación de dispositivos semiconductores, como transistores MOSFET.  

```bash
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
```

<img width="952" height="688" alt="image" src="https://github.com/user-attachments/assets/aa0c43a9-6bad-4698-936e-97cdeba1b107" />

Parámetros de cambiao para afectar la gráfica:

1. dose y energy en el IMPLANT
```
IMPLANT phosphorus dose=5e15 energy=65 right.to=0
```
dose: Aumenta o reduce la cantidad de fósforo implantado.
Más dosis → oxidación más rápida → óxido más grueso en la región dopada.
Menos dosis → oxidación menos acelerada → óxido más fino.

energy: Controla la profundidad de implantación.
Mayor energía → dopado más profundo.
fecto visual: Podrías ver cómo el pico del perfil de dopado se desplaza hacia el interior del silicio.  
<img width="712" height="607" alt="image" src="https://github.com/user-attachments/assets/771a774d-fae3-4ec3-8d72-55aeb43889bf" />  
En este ejemplo la energía fue aumentada a **energy=95**  

2. time y temperature en el DIFFUSE (oxidación)
```
DIFFUSE time=15 temperature=1000 weto2
```
time: Tiempo de oxidación (en minutos).
Más tiempo = óxido más grueso.
Efecto lineal o cuadrático, dependiendo del régimen.  
<img width="714" height="604" alt="image" src="https://github.com/user-attachments/assets/27b85118-7fae-461e-ba59-8d7781320bd9" />  
En esta ejemplo el tiempo de oxidación fue aumenada a **time=30**  

temperature: Temperatura del horno en °C.
Aumenta el crecimiento del óxido exponencialmente.
También afecta la redistribución del dopante.  
<img width="709" height="605" alt="image" src="https://github.com/user-attachments/assets/6c6b8a13-67f3-477e-8e77-bea76620675c" />  
En esta ejemplo la temperatura de oxidación fue aumenada a **temperature=1200** 

---
