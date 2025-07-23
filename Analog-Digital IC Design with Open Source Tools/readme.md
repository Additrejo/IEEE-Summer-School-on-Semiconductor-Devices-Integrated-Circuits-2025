## Analog/Digital IC Design with Open Source Tools  
[imagen software]  
Este repositorio contiene archivos y ejemplos desarrollados durante mi formación introductoria en el diseño de circuitos integrados (CI) analógicos y digitales utilizando Electro Tlalli, un entorno de diseño electrónico de código abierto enfocado en la educación e investigación. El flujo de diseño se basa en el PDK SKY130 (Process Design Kit), un proceso de 130 nm de código abierto desarrollado por SkyWater Technology. Electro Tlalli integra herramientas como Xschem para el diseño esquemático, Ngspice para simulaciones, Magic VLSI para el diseño físico (layout), Netgen para verificación LVS y OpenLane para la síntesis y diseño digital. A través de este entorno, exploré el ciclo completo de diseño de CI, desde el diseño analógico a nivel de transistores hasta el flujo digital RTL a GDSII, adquiriendo experiencia práctica en verificación de reglas de diseño (DRC), comparación esquema-vs-layout (LVS), extracción de parásitos y preparación para tape-out. Este repositorio documenta mi proceso de aprendizaje y sirve como referencia para futuros desarrollos de silicio abierto.  

## 📑 Índice

- [Analog/Digital IC Design with Open Source Tools  ](https://github.com/Additrejo/IEEE-Summer-School-on-Semiconductor-Devices-Integrated-Circuits-2025/tree/main/Analog-Digital%20IC%20Design%20with%20Open%20Source%20Tools)  
- [Requisitos](#requisitos)  
- [Instalación y configuración de máquina virtual](#-instalación-y-configuración-de-máquina-virtual.)  
- [Configurar la máquina virtual con el PDK SKY 130](#-configurar-la-máquina-virtual-con-el-pdk-sky-130.)  


---

## Requisitos

Cómo primer paso es necesario instalar una máquina virtual para poder ejecutar Electro Tlalli, en este caso usaremos VirtualBox.  
[Virtualbox](https://www.virtualbox.org/)   

## Instalación y configuración de máquina virtual

### VirtualBox  
- Dirigirse a la página de descarga de [Virtualbox](https://www.virtualbox.org/)  y descargar.  
<img width="1351" height="345" alt="image" src="https://github.com/user-attachments/assets/e0c5f8d8-f1e5-4de4-bf72-923c0b675a7b" />

- Instalar en PC.  
 <img width="497" height="389" alt="image" src="https://github.com/user-attachments/assets/4758b9c7-435e-4730-8030-2a31d2d23f8e" />

- **Instalar el paquete Extension Pack**  
<img width="627" height="114" alt="image" src="https://github.com/user-attachments/assets/2c8f975b-7f89-49c9-a19f-e31920656ec4" />  
<img width="451" height="257" alt="image" src="https://github.com/user-attachments/assets/52e39425-7184-4fe6-951f-d1be0e11e3d4" />  

El VirtualBox Extension Pack es un paquete especial que mejora las capacidades del programa VirtualBox que viene  
por defecto. Con este paquete, lasmáquinas virtuales pueden tener características adicionales, como:  
- Compatibilidad con puertos USB 2.0 y 3.0, lo que permite conectar dispositivos USB a las máquinas virtuales.  
- Soporte para el protocolo de escritorio remoto de VirtualBox (VRDP), que facilita el acceso remoto a las máquinas  
virtuales.  
- Uso de la cámara web del equipo principal en las máquinas virtuales, lo que permite usar la cámara dentro de  
un sistema operativo virtualizado.  
- Posibilidad de arrancar desde una ROMIntel PXE, útil en ciertos escenarios de configuración.  
- Cifrado de imágenes de disco con el algoritmo AES, lo que mejora la seguridad de los datos en las máquinas  
virtuales.  
- Integración con servicios en la nube para facilitar el intercambio de datos entre el sistema anfitrión y los sistemas  
virtuales.  
- Para instalar el VirtualBox Extension Pack enWindows, tienes que hacer doble clic en el archivo con extensión .vboxextpack  
y seguir las instrucciones del instalador.  
- Con estos pasos, tu instalación de VirtualBox estará lista para empezar a virtualizar otros sistemas operativos enWindows. 
- Esto te permitirá experimentar con diferentes sistemas de forma segura y sin afectar tu computadora principal.  

## CONFIGURAR LA MÁQUINA VIRTUAL CON EL PDK SKY 130
Ahora crearemos el entorno de desarrollo para poder usar las herramientas de ElectroTlalli.  

1. En VirtualBox añadimos una nueva máquina virtual.  
2. Poner un nombre por ejemplo: "ElectroTlalli".
3. En Tipo elegimos: **Linux**
4. la versión: **Red Hat 7.x(64-bit)**
Lo demás dejarlo todo como está.  

<img width="795" height="375" alt="image" src="https://github.com/user-attachments/assets/d330037d-09bf-4f1b-a3ec-2ed493e45ce7" />  

Ahora, establece la cantidad de memoria RAMy procesadores que usará la máquina virtual. Ten en cuenta que
estos recursos estarán limitados por los recursos disponibles en tu computadora. Más memoria RAM y CPU
permitirán que la máquina virtual funcione mejor, pero podría afectar el rendimiento de tu sistema principal
(Windows). Elige los valores según tus recursos y haz clic en Next.  

<img width="795" height="376" alt="image" src="https://github.com/user-attachments/assets/82a198d6-bd91-4c2c-bc3a-ed3317ed1ac2" />

A continuación, debes seleccionar el disco duro donde se instalará el sistema operativo y las herramientas. Si
tienes el archivo ElectroTlalli.zip, descomprímelo y obtendrás un archivo llamado ElectroTlalli.vdi, que es el
disco virtual con el sistema operativo y las herramientas instaladas. En la ventana de configuración, selecciona
Use an Existing Virtual Hard Disk File (Usar un Archivo de Disco Duro Virtual Existente) y elige la ubicación del
archivo ElectroTlalli.vdi. Haz clic en Next.




Todo está listo para empezar a trabajar.

---

# [Electro Tlalli](https://github.com/Additrejo/IEEE-Summer-School-on-Semiconductor-Devices-Integrated-Circuits-2025/blob/main/Introduction%20to%20Silvaco%20TCAD/Silvaco_Doping_dependent_oxidation.tcl)  
[Imagen]
