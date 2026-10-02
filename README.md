# 🌌 Caelestia Personal Dots (Hyprland + Lua)

> **Entorno Hyprland moderno, elegante y dinámico basado en Caelestia Shell, Quickshell y Lua.**

---

## ✨ Características Principales

- 🎨 **Tema Dinámico Material You**:
  - Extracción automática de paletas desde el fondo de pantalla en tiempo real con `caelestia wallpaper`.
  - Sincronización instantánea hacia los bordes de Hyprland (`current.lua`), terminal Kitty (`current-theme.conf`), Rofi (`caelestia-colors.rasi`) y Quickshell Overview.
- 🗂️ **Ciclo de Espacios Inteligente (MRU Workspace Cycler)**:
  - `SUPER + Tab` y `SUPER + SHIFT + Tab` gestionan un historial *Most Recently Used*.
  - Un toque rápido conmuta al escritorio anterior.
  - Mantener `SUPER` y pulsar `Tab` navega por todo el historial cronológico `[3, 7, 1, 10...]`, reorganizándolo automáticamente al soltar la tecla.
- 📋 **Portapapeles Glassmorphism (`SUPER + V`)**:
  - Gestor de portapapeles minimalista en Rofi con soporte de iconos, historial, copiado (`Enter`), borrado individual (`Ctrl + Del`) y vaciado completo (`Alt + Del`).
  - Estilo de cristal translúcido oscuro con desenfoque nativo (blur) y acentos dinámicos.
- 🖼️ **Vista General de Escritorios (`SUPER + A`)**:
  - Desktop Overview interactivo en Quickshell con soporte de arrastrar y soltar ventanas entre escritorios.
  - Diseño cohesivo con el portapapeles: esquinas de 16px, borde sutil de 1px, fondo translúcido y animación `popin 85%`.
- ⚙️ **Caelestia Nexus (`SUPER + W`)**:
  - Panel de control y ajustes del sistema de Caelestia accesible al instante.
- 🌄 **Gestión de Fondos de Pantalla**:
  - Selector con vista previa (`SUPER + ALT + W`).
  - Fondos aleatorios (`CTRL + ALT + W`).
  - Soporte para fondos estáticos y vídeos (`.mp4`), generando la paleta de colores a partir de miniaturas.

---

## ⌨️ Atajos de Teclado Principales

### 🚀 Sistema y Lanzadores
| Atajo | Acción | Descripción |
| :--- | :--- | :--- |
| `SUPER + D` (o `SUPER`) | Lanzador de aplicaciones | Abre el buscador de Caelestia |
| `SUPER + A` | Desktop Overview | Vista general interactiva de escritorios |
| `SUPER + V` | Portapapeles | Historial de copiado y pegado |
| `SUPER + W` | Caelestia Nexus | Centro de ajustes y configuración |
| `SUPER + H` | Cheat Sheet | Guía interactiva de atajos activos |
| `SUPER + N` | Barra lateral | Notificaciones y panel lateral |
| `SUPER + Period (.)` | Selector de Emojis | Menú rápido de emojis |
| `SUPER + Space` | Idioma de teclado | Alternar distribución global (US/ES) |

### 🪟 Control de Ventanas y Navegación
| Atajo | Acción | Descripción |
| :--- | :--- | :--- |
| `SUPER + Q` | Cerrar ventana | Cierra la ventana activa |
| `ALT + Space` | Flotante / Tiled | Alterna ventana entre flotante y en mosaico |
| `SUPER + F` | Pantalla completa | Modo pantalla completa (Fake Fullscreen) |
| `SUPER + SHIFT + F` | Fullscreen real | Pantalla completa exclusiva |
| `SUPER + Tab` | Historial de escritorios | Cicla escritorios recientes (MRU) |
| `SUPER + 1..10` | Cambiar escritorio | Ir al espacio de trabajo correspondiente |
| `SUPER + ALT + 1..10` | Mover ventana | Mover ventana al espacio correspondiente |
| `ALT + Tab` | Ciclar ventanas | Pasa a la siguiente ventana activa |

### 🎨 Personalización & Pantalla
| Atajo | Acción | Descripción |
| :--- | :--- | :--- |
| `SUPER + ALT + W` | Selector de fondos | Menú visual para elegir fondo de pantalla |
| `CTRL + ALT + W` | Fondo aleatorio | Cambia a un fondo al azar de tu galería |
| `SUPER + SHIFT + W` | Efectos de imagen | Filtros y efectos en el fondo activo |
| `SUPER + SHIFT + S` | Captura de pantalla | Captura con congelamiento de imagen |
| `SUPER + SHIFT + C` | Selector de color | Gotero en pantalla (`hyprpicker`) |
| `SUPER + G` | Modo juego | Desactiva animaciones y efectos para rendimiento |

---

## 📦 Dependencias y Requisitos

Para que todas las funciones, widgets y barras se ejecuten correctamente:

### Paquetes Base (Arch Linux / AUR)
```bash
# Gestor de ventanas y utilidades Wayland
sudo pacman -S hyprland wayland wl-clipboard cliphist rofi-wayland jq bc imagemagick

# Terminal y fuentes
sudo pacman -S kitty noto-fonts-emoji ttf-font-awesome

# Caelestia Shell y Quickshell (desde AUR con paru o yay)
paru -S caelestia-shell quickshell-git hyprpicker mpvpaper
```

---

## 📥 Instalación

### 1. Respaldar configuración previa (opcional pero recomendado)
```bash
if [ -d "$HOME/.config/hypr" ]; then
  mv "$HOME/.config/hypr" "$HOME/.config/hypr.bak.$(date +%Y%m%d_%H%M%S)"
fi
```

### 2. Clonar el repositorio
```bash
git clone https://github.com/S-Gull/Caelestia-Personal-Dots.git "$HOME/.config/hypr"
```

### 3. Asignar permisos de ejecución a los scripts
```bash
chmod +x "$HOME/.config/hypr/scripts/"*.sh
chmod +x "$HOME/.config/hypr/UserScripts/"*.sh
```

### 4. Fondos de pantalla
Coloca tus imágenes o vídeos en:
```bash
mkdir -p "$HOME/Pictures/wallpapers"
```

### 5. Iniciar o Recargar Hyprland
Si ya estás dentro de Hyprland:
```bash
hyprctl reload
```
O simplemente presiona `SUPER + ALT + R` para refrescar los componentes.

---

## 📁 Estructura del Proyecto

```
~/.config/hypr/
├── hyprland.lua            # Punto de entrada principal en Lua
├── variables.lua           # Variables globales de atajos, colores y temas
├── hyprland/               # Módulos de configuración (keybinds, reglas, animaciones, etc.)
│   ├── keybinds.lua        # Definición de atajos y callbacks
│   ├── rules.lua           # Reglas de ventanas y capas (layershell)
│   ├── execs.lua           # Procesos y daemons al inicio
│   └── ...
├── utils/
│   └── functions.lua       # Lógica del ciclo de escritorios (MRU), resizer, etc.
├── scheme/
│   ├── current.lua         # Paleta de colores dinámica activa generada por Caelestia
│   └── default.lua         # Paleta de colores de respaldo
├── scripts/                # Scripts de automatización del sistema
│   ├── ClipManager.sh      # Gestor de portapapeles estilizado
│   ├── WallustSwww.sh      # Puente de fondos y temas con Caelestia
│   ├── OverviewToggle.sh   # Conmutador de la vista general
│   ├── sync_caelestia.py   # Daemon de sincronización en vivo (Hyprland -> Rofi/Kitty)
│   └── ...
├── UserConfigs/            # Configuraciones adicionales de usuario
└── UserScripts/            # Scripts interactivos (selectores, fondos aleatorios, etc.)
```

---

## 👤 Autor

- **Guillermo Alejandro (S-Gull)**
- GitHub: [@S-Gull](https://github.com/S-Gull)
