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
Para disfrutar de una experiencia fluida, necesitarás asegurarte de que tu computadora tenga suficientes recursos, como 
procesador, memoria RAMy espacio de almacenamiento.  
Esto es importante para que tanto el sistema operativo principal de tu computadora (el anfitrión) como los sistemas operativos virtuales (los invitados) puedan funcionar sin problemas.  
Por ejemplo, si deseas virtualizar Ubuntu (un sistema operativo de Linux) y tienes menos de 6 GB de RAM, es posible  
que no funcione muy bien, ya que Canonical (la empresa detrás de Ubuntu) recomienda almenos 4 GB de RAM para  la última versión de su sistema operativo.  
Lo mismo ocurre con el procesador, cuanto más nuevo y potente sea, mejor.  
Los requisitos mínimos para utilizar VirtualBox son: Un procesador X86 (32 bits) con soporte de virtualización, o si tienes un procesador X86-64 (64 bits), será aún mejor.  
Memoria RAM: La cantidad necesaria dependerá del sistema operativo que desees virtualizar, pero tener al  menos 8 GB sería un buen punto de partida.  
Espacio de almacenamiento: La instalación de VirtualBox ocupa aproximadamente 250 MB, pero cada sistema operativo virtualizado requerirá al menos 10 GB de espacio en disco.  
Puedes comenzar con un disco duro tradicional, aunque lo ideal sería tener uno de estado sólido (SSD) para obtener un mejor rendimiento.  
Asegurarte de cumplir con estos requisitos te permitirá disfrutar de una experienciamás fluida y satisfactoria al utilizar  
máquinas virtuales con VirtualBox.  

## ¿Qué es VirtualBox?  
VirtualBox es una aplicación que te permite crear máquinas virtuales, que son como computadoras simuladas dentro
de tu propia computadora.  Con estasmáquinas virtuales, puedes instalar diferentes sistemas operativos sin afectar tu
computadora principal.  Es como tener varias computadoras en una sola.  
El proceso es sencillo: instalas VirtualBox en tu computadora (que sería el anfitrión), y luego creas una o más máquinas
virtuales (los invitados) dentro de él.  Cada máquina virtual puede ejecutar un sistema operativo diferente, como
Linux, Solaris, macOS, BSD, IBM OS/2 o Windows.  Lo mejor es que los datos de tu computadora principal están protegidos,
ya que cada máquina virtual funciona de manera aislada.  
Con esto, puedes probar nuevos sistemas operativos, aplicaciones o configuraciones sin poner en riesgo los datos importantes
de tu computadora principal.  Es una forma segura y práctica de experimentar y aprender sobre diferentes
sistemas sin afectar tu entorno principal.


## DESCARGAR E INSTALAR VIRTUALBOX  
Cómo primer paso es necesario instalar una máquina virtual para poder ejecutar Electro Tlalli, en este caso usaremos VirtualBox.  
[Virtualbox](https://www.virtualbox.org/)   

### VirtualBox  
- Dirigirse a la página de descarga de [Virtualbox](https://www.virtualbox.org/)  y descargar.  
<img width="1351" height="345" alt="image" src="https://github.com/user-attachments/assets/e0c5f8d8-f1e5-4de4-bf72-923c0b675a7b" />

- Instalar en PC.  
 <img width="497" height="389" alt="image" src="https://github.com/user-attachments/assets/4758b9c7-435e-4730-8030-2a31d2d23f8e" />

## INSTALAR EL PAQUETE EXTENSION PACK

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

<img width="793" height="373" alt="image" src="https://github.com/user-attachments/assets/dcb7a1b0-9b00-4f99-88e9-962e9686d717" />

Verás un resumen de la configuración de la máquina virtual. Haz clic en Terminar.  
<img width="796" height="377" alt="image" src="https://github.com/user-attachments/assets/fb3d5a4f-a252-49d2-8670-610f28ef15e8" />  

Regresarás a la ventana principal de VirtualBox, donde verás la máquina virtual que creaste. Antes de iniciarla,
haz clic en el botón de Configuración.  
<img width="814" height="403" alt="image" src="https://github.com/user-attachments/assets/cc465caa-a377-4b8d-b840-aa0fa29139fb" />  

Se abrirá una nueva ventana. Ve a la pestaña Avanzado y en la sección Compartir portapapeles, selecciona Bidireccional.
También en la sección Arrastrar y soltar, selecciona Bidireccional.   
<img width="720" height="486" alt="image" src="https://github.com/user-attachments/assets/8c7ee427-345d-4a08-8447-0d64f35fa892" />

Luego, haz clic en el botón Carpetas compartidas. Aquí puedes agregar carpetas de tu sistema Windows. Esto
permitirá ingresar o extraer archivos hacia y desde la máquina virtual. Configura las carpetas que desees y haz
clic en Aceptar.  
<img width="728" height="490" alt="image" src="https://github.com/user-attachments/assets/83577dce-26b3-4d74-817d-e091d221c83d" />  

¡Listo! Con esto, has configurado tu máquina virtual. Ahora puedes iniciarla y acceder a las herramientas opensource
que contiene. Disfruta de tu experiencia virtual.

## ABRIR LA MAQUINA CON LAS HERRAMIENTAS OPENSOURCE VIRTUALBOX  
Para abrir la máquina virtual con las herramientas opensource en VirtualBox, sigue estos sencillos pasos:  
1. Abre VirtualBox y selecciona la máquina virtual que configuramos en los pasos anteriores. Luego, haz clic en el
icono Iniciar que está en la esquina superior derecha del menú.  
<img width="811" height="400" alt="image" src="https://github.com/user-attachments/assets/c0c5aae9-1077-4ebc-b901-436a2d809cee" />  

2. Una vez que inicies la máquina virtual, te pedirá una contraseña. Ingresa el password Tlalli.2025 y presiona
Enter.

<img width="796" height="670" alt="image" src="https://github.com/user-attachments/assets/b51da1e0-63b7-421e-9754-30da64426071" />  

¡Listo! Si ingresaste correctamente la contraseña, tendrás acceso a la máquina virtual y podrás utilizar las herramientas
opensource que contiene. Ahora puedes comenzar a trabajar en tu máquina virtual.

<img width="1361" height="724" alt="image" src="https://github.com/user-attachments/assets/7ed9e4bf-c390-4b8d-b967-6ad85bdebd2e" />


---

# [Electro Tlalli](https://github.com/Additrejo/IEEE-Summer-School-on-Semiconductor-Devices-Integrated-Circuits-2025/blob/main/Introduction%20to%20Silvaco%20TCAD/Silvaco_Doping_dependent_oxidation.tcl)  
[Imagen]

