# 🎉 ViticomMall - App de Eventos y Fiestas

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://developer.apple.com/ios/)
[![Xcode](https://img.shields.io/badge/Xcode-15.0+-green.svg)](https://developer.apple.com/xcode/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> **ViticomMall** es una aplicación iOS moderna para la compra de productos y decoraciones para eventos, fiestas, bodas, cumpleaños y celebraciones especiales.

## 📱 Características Principales

### 🛍️ **Sistema de Compras**
- **Catálogo de productos** organizado por categorías
- **Carrito de compras** con gestión de cantidades
- **Sistema de favoritos** para guardar productos
- **Proceso de checkout** completo
- **Historial de pedidos**

### 🎨 **Categorías de Productos**
- 🎂 **Cumpleaños**: Globos, decoraciones, mesas de dulces
- 💒 **Bodas**: Centros de mesa, velos, candeleros elegantes
- 🎓 **Graduaciones**: Gorras, togas, diplomas personalizados
- 👶 **Baby Shower**: Decoraciones, ramos de globos
- 🎉 **Fiestas**: Luces LED, decoraciones neon, kits temáticos

### 🔐 **Sistema de Autenticación**
- **Registro de usuarios** con validación
- **Inicio de sesión** seguro
- **Onboarding** para nuevos usuarios
- **Persistencia de sesión**

### 🖼️ **Sistema de Imágenes Avanzado**
- **Imágenes reales** de productos desde Pexels
- **Carga asíncrona** con indicadores de progreso
- **Cache inteligente** para mejor rendimiento
- **Fallback a iconos** del sistema
- **Optimización automática** para diferentes pantallas

## 🚀 Tecnologías Utilizadas

- **SwiftUI** - Framework de UI moderno
- **Core Data** - Persistencia de datos local
- **URLSession** - Descarga de imágenes asíncrona
- **@AppStorage** - Almacenamiento de preferencias
- **Combine** - Programación reactiva
- **Async/Await** - Programación asíncrona moderna

## 📋 Requisitos del Sistema

- **iOS 15.0** o superior
- **Xcode 15.0** o superior
- **Swift 5.9** o superior
- **Conexión a internet** (para descargar imágenes)

## 🛠️ Instalación y Configuración

### **Paso 1: Clonar el Repositorio**
```bash
git clone https://github.com/victortejeda/ViticomMall.git
cd ViticomMall
```

### **Paso 2: Abrir en Xcode**
```bash
open ViticomMall.xcodeproj
```

### **Paso 3: Configurar el Dispositivo**
1. Selecciona tu dispositivo o simulador
2. Presiona `Cmd + R` para ejecutar
3. ¡Disfruta de la app!

### **Paso 4: Limpiar y Reconstruir (si es necesario)**
```bash
# En Xcode
Cmd + Shift + K  # Clean Build Folder
Cmd + B          # Build
```

## 📁 Estructura del Proyecto

```
ViticomMall/
├── 📱 App/
│   ├── ViticomMallApp.swift          # Punto de entrada de la app
│   └── ContentView.swift             # Vista principal
├── 🔐 Auth/
│   ├── LoginView.swift               # Vista de inicio de sesión
│   └── RegisterView.swift            # Vista de registro
├── 🎯 Onboarding/
│   ├── OnboardingContainerView.swift # Contenedor de onboarding
│   ├── OnboardingItem.swift          # Modelo de item
│   └── OnboardingScreenView.swift    # Vista de pantalla
├── 🏠 Main/
│   ├── MainAppView.swift             # Vista principal de la app
│   └── ViticomMall.xcdatamodeld/     # Modelo de datos Core Data
├── 🖼️ Views/
│   ├── CartView.swift                # Vista del carrito
│   ├── DiscoverView.swift            # Vista de descubrimiento
│   ├── MyOrderView.swift             # Vista de pedidos
│   ├── MyProfileView.swift           # Vista de perfil
│   ├── NotificationsView.swift       # Vista de notificaciones
│   ├── SettingsView.swift            # Vista de configuración
│   └── SupportView.swift             # Vista de soporte
├── 🧩 Components/
│   ├── ProductImageView.swift        # Componente de imágenes
│   ├── CategoryFilterView.swift      # Filtro de categorías
│   ├── OrderStatusCardView.swift     # Tarjeta de estado
│   ├── PaymentsView.swift            # Vista de pagos
│   ├── ProfileFormView.swift         # Formulario de perfil
│   ├── SearchBarView.swift           # Barra de búsqueda
│   ├── SidebarView.swift             # Menú lateral
│   └── TabBarView.swift              # Barra de pestañas
├── 📊 Models/
│   ├── CartManager.swift             # Gestor del carrito
│   └── ProductImages.swift           # Configuración de imágenes
└── 📚 Documentation/
    ├── README_IMAGENES.md            # Guía de imágenes
    ├── IMPLEMENTACION_IMAGENES.md    # Documentación técnica
    └── SETUP_API_KEY.md              # Configuración de API
```

## 🎨 Características de Diseño

### **🎯 Experiencia de Usuario**
- **Interfaz intuitiva** y fácil de navegar
- **Animaciones suaves** y transiciones fluidas
- **Modo oscuro** y claro automático
- **Accesibilidad** completa
- **Responsive design** para todos los dispositivos

### **🖼️ Sistema de Imágenes**
- **Carga asíncrona** con indicadores de progreso
- **Cache inteligente** para mejor rendimiento
- **Optimización automática** para diferentes densidades
- **Fallback robusto** a iconos del sistema
- **Imágenes de alta calidad** desde Pexels

### **⚡ Rendimiento**
- **Carga rápida** de productos
- **Navegación fluida** entre pantallas
- **Gestión eficiente** de memoria
- **Optimización** para dispositivos móviles

## 🔧 Configuración Avanzada

### **Personalización de Imágenes**
Consulta [README_IMAGENES.md](ViticomMall/README_IMAGENES.md) para:
- Agregar nuevas imágenes de productos
- Configurar URLs personalizadas
- Optimizar el rendimiento de carga

### **Configuración de API**
Consulta [SETUP_API_KEY.md](ViticomMall/SETUP_API_KEY.md) para:
- Configurar APIs de imágenes
- Personalizar fuentes de datos
- Optimizar la descarga de contenido

## 🧪 Testing

### **Pruebas Manuales**
1. **Registro e inicio de sesión**
2. **Navegación por categorías**
3. **Agregar productos al carrito**
4. **Proceso de checkout**
5. **Sistema de favoritos**

### **Pruebas de Imágenes**
1. **Carga de imágenes desde URLs**
2. **Fallback a iconos del sistema**
3. **Cache de imágenes**
4. **Rendimiento en diferentes conexiones**

## 🚀 Despliegue

### **App Store**
1. Configurar certificados de distribución
2. Generar archivo de distribución
3. Subir a App Store Connect
4. Configurar metadatos y capturas

### **TestFlight**
1. Configurar certificados de desarrollo
2. Generar build de distribución
3. Subir a TestFlight
4. Invitar testers

## 🤝 Contribución

### **Cómo Contribuir**
1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### **Estándares de Código**
- Usar **SwiftLint** para consistencia
- Seguir **Swift API Design Guidelines**
- Documentar funciones públicas
- Escribir tests unitarios

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

## 👨‍💻 Autor

**Victor Tejeda**
- GitHub: [@victortejeda](https://github.com/victortejeda)
- LinkedIn: [Victor Tejeda](https://linkedin.com/in/victortejeda)

## 🙏 Agradecimientos

- **Pexels** por las imágenes de alta calidad
- **Apple** por SwiftUI y las herramientas de desarrollo
- **Comunidad Swift** por el soporte y recursos

## 📞 Soporte

Si tienes preguntas o problemas:
1. Revisa la [documentación](ViticomMall/Documentation/)
2. Busca en los [issues](https://github.com/victortejeda/ViticomMall/issues)
3. Crea un nuevo issue si no encuentras la solución

---

⭐ **Si te gusta este proyecto, ¡dale una estrella en GitHub!**

---

*Desarrollado con ❤️ usando SwiftUI* 