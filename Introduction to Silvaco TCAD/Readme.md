
## Introducing to Silvaco  
<img width="958" height="342" alt="image" src="https://github.com/user-attachments/assets/330fb489-c2df-4d91-be97-8b7847e6cd92" />
Este repositorio contiene un ejemplo desarrollado durante mi capacitación en **introducción al software Silvaco TCAD**.

Silvaco es una herramienta profesional para la **simulación de procesos y dispositivos semiconductores**, ampliamente utilizada en la industria electrónica, investigación académica y diseño de tecnología avanzada. Permite modelar y predecir fenómenos como oxidación, difusión, implantación iónica, comportamiento de dispositivos MOSFET, diodos y más.

---
## 📑 Índice

- [Introducing to Silvaco](https://github.com/Additrejo/IEEE-Summer-School-on-Semiconductor-Devices-Integrated-Circuits-2025/tree/main/Introduction%20to%20Silvaco%20TCAD)  
- [Requisitos](#requisitos)
- [Simulación de Oxidación Dependiente del Dopado](#-simulacion-de-oxidacion-dependiente-del-dopado)  
- [Caracterización de un dispositivo CMOS de 55nm](#-caracterización-de-un-dispositivo-cmos-de-55nm)
- [Rie Trench Modeling](#-rie-trench-modeling)

---

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

# [Simulación de Oxidación Dependiente del Dopado](https://github.com/Additrejo/IEEE-Summer-School-on-Semiconductor-Devices-Integrated-Circuits-2025/blob/main/Introduction%20to%20Silvaco%20TCAD/Silvaco_Doping_dependent_oxidation.tcl)  

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


# [Caracterización de un dispositivo CMOS de 55nm](https://github.com/Additrejo/IEEE-Summer-School-on-Semiconductor-Devices-Integrated-Circuits-2025/blob/main/Introduction%20to%20Silvaco%20TCAD/Caracterizacion_CMOS_5nm.tcl)  
<img width="714" height="253" alt="image" src="https://github.com/user-attachments/assets/e73fe9ea-d53d-48d5-85a4-549b1d4fe3e3" />

Este [código](https://github.com/Additrejo/IEEE-Summer-School-on-Semiconductor-Devices-Integrated-Circuits-2025/blob/main/Introduction%20to%20Silvaco%20TCAD/Caracterizacion_CMOS_5nm.tcl)  
es un script completo de simulación TCAD (Technology Computer-Aided Design) utilizando el software Silvaco para caracterizar un dispositivo CMOS de 55nm. Su propósito principal es:

**1.Simulación del Proceso de Fabricación:**  
-Modela todas las etapas de fabricación del transistor (pozos, óxido de puerta, LDD, espaciadores, etc.).  
-Incluye implantes iónicos, deposiciones y procesos térmicos.  
-Simula sólo la mitad del dispositivo (por simetría) para ahorrar tiempo.  

**2.Simulación Eléctrica:**  
-Caracteriza las propiedades eléctricas del transistor.  
-Realiza barridos de voltaje Vg (compuerta) y Vd (drenaje).  
-Evalúa tanto la región lineal como de saturación.  

**3.Extracción de Parámetros Clave:**  
-Voltajes de umbral (Vtlin, Vtsat, Vtgm).
-Corrientes (Idlin, Idsat, Idoff).
-Efectos de cortocanal (DIBL - Drain Induced Barrier Lowering).  
-Movilidad de portadores.  

**4.Análisis y Visualización:**  
-Genera archivos de resultados para visualización.  
-Proporciona datos para calibrar el proceso de fabricación.  
   
<img width="594" height="532" alt="image" src="https://github.com/user-attachments/assets/efe57cc4-3afa-4494-8b6b-ad1680f20512" />   

El flujo completo incluye:  
-Inicialización de la estructura.  
-Formación de pozos (Well).  
-Crecimiento de óxido (GOX1 y GOX2).  
-Formación de la puerta polisilicio (Poly).  
-Implantes LDD (Lightly Doped Drain).  
-Formación de espaciadores (Spacer).  
-Implantes de fuente/drenaje (SD).  
-Contactos metálicos.  
-Simulación eléctrica con varios modelos físicos.  
-Extracción automática de parámetros.  

---

# [Rie Trench Modeling](https://github.com/Additrejo/IEEE-Summer-School-on-Semiconductor-Devices-Integrated-Circuits-2025/blob/main/Introduction%20to%20Silvaco%20TCAD/RIE_Trench.tcl)  
<img width="701" height="391" alt="image" src="https://github.com/user-attachments/assets/1614a5ee-e8b4-4d96-b840-4090115ea796" />


Este [código](https://github.com/Additrejo/IEEE-Summer-School-on-Semiconductor-Devices-Integrated-Circuits-2025/blob/main/Introduction%20to%20Silvaco%20TCAD/RIE_Trench.tcl)   utiliza el software SILVACO (específicamente los módulos Victory Mesh y Victory Visual) para crear un modelo 3D de una estructura de zanja creada mediante grabado iónico reactivo (RIE - Reactive Ion Etching), que es una técnica común en fabricación de semiconductores.

El código utiliza los módulos **Victory Mesh** y **Victory Visual** de SILVACO para:

1. Crear una estructura base de silicio
2. Generar perfiles elipsoidales concéntricos (polymer y sio2)
3. Modelar el característico perfil "scalloped" de grabados RIE
4. Replicar el patrón para formar una zanja completa
5. Refinar la malla y añadir dopaje

## 🛠️ Características técnicas

- **Geometría**: 
  - Sustrato de silicio inicial (cubo 2x2x2 μm)
  - Elipsoides concéntricos (outer: 0.5×0.5×0.25 μm, inner: 0.4×0.4×0.15 μm)
  - Patrón replicado 82 veces con offset de 0.1 μm

- **Materiales**:
  - Silicio (sustrato)
  - Polymer (estructura intermedia)
  - SiO₂ (estructura interna)

- **Parámetros de malla**:
  - Refinamiento Delaunay
  - Tamaño máximo: 6.05 nm
  - Tamaño máximo en interfaces: 0.05 nm
  - Gradación cuadrática

- **Dopaje**:
  - Fósforo constante: 1×10¹⁵ cm⁻³ en silicio

## 📋 Estructura del código

```plaintext
1. Configuración inicial
2. Creación de geometrías base
   - Sustrato de silicio
   - Elipsoides concéntricos
3. Operaciones booleanas
   - Combinación de geometrías
   - Extracción de perfiles
4. Replicación del patrón
5. Refinamiento de malla
6. Asignación de dopaje
7. Visualización
```

## 🔧 1. Configuración inicial

- Se especifica el uso del módulo `Victory Mesh`.
- Se establece el nombre del ejemplo:
  
```tcl
SET name="Wt_Solid_Model_ex09"
```

---

## 🧱 2. Creación del sustrato

- Se define una caja de silicio como base (sustrato):

```tcl
UBODI from="-1,-1,-1" to="1,1,1" material="silicon" out="substrate"
SKELETON
```

---

## 🎯 3. Geometría escalonada (Scallop)

### 3.1. Elipsoide exterior

- Polímero con forma de elipsoide:

```tcl
ELLIPSODI center="0,0,0" radius.x=0.5 radius.y=0.5 radius.z=0.25 num.edges=32 material="polymer" out="outer_ellipsoid"
SKELETON
SPLICE regions="polymer" material="silicon"
```

### 3.2. Elipsoide interior

- Más pequeña y de SiO₂:

```tcl
ELLIPSODI center="0,0,0" radius.x=0.4 radius.y=0.4 radius.z=0.15 num.edges=32 material="sio2" out="inner_ellipsoid"
SKELETON
SPLICE regions="sio2" material="polymer"
```

### 3.3. Combinación de formas

```tcl
COMBINE in a="outer_ellipsoid" in b="inner_ellipsoid" out="base"
```

---

## 🧩 4. Creación de patrón tipo trinchera

### 4.1. Recorte de celda base

```tcl
CRDP from="1,-1,-0.1" to="1,1,0.5"
```

### 4.2. Replicación de patrón

```tcl
WIREOR axes="-822" offset="0.1" out="trench"
```

### 4.3. Limpieza y reducción de dominio

```tcl
MERGE
CRDP from="0" to="1" out="rie"
```

---

## 🕸️ 5. Generación y refinamiento de la malla

```tcl
RERESH delaunay out="rie_delaunay"
REFINE max_size=6.05
REFINE max_interface_size=0.05 regions="silicon, size" interface.regions="polymer" grading="quadratic"
```

- Se utiliza la triangulación de Delaunay.
- Refinamiento global y en interfaces con gradiente cuadrático.

---

## 🧪 6. Dopaje

```tcl
FIELD constant regions="silicon" name="phosphorus" value=1e15
```

- Se aplica dopaje constante con fósforo tipo n a la región de silicio.

---

## 💾 7. Guardado y visualización

```tcl
SAVE out="$'name'_VM_0"
victoryvisual $'name'_VM_0.str:$'name'_VM_0.set
OUTT
```

- Se guarda la estructura mallada y se abre en Victory Visual.

---

## 📌 Resumen

Este script:

- Crea un sustrato de silicio.
- Superpone estructuras elipsoidales escalonadas (scallop) de distintos materiales.
- Repite el patrón para generar una trinchera RIE escalonada.
- Aplica mallado adaptativo refinado y dopaje.
- Exporta la estructura para simulaciones posteriores.

> **Aplicaciones típicas**: Diseño de MEMS, cavidades resonantes, DRIE, sensores o estructuras de grabado anisotrópico.

---

## 📷 Vista previa 
<img width="591" height="471" alt="image" src="https://github.com/user-attachments/assets/2bfe7004-dc7e-40a1-8d29-4f620d1b1009" />
