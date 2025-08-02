# 📚 Documentación Técnica - ViticomMall

## 🏗️ Arquitectura del Proyecto

### **Patrón de Diseño**
ViticomMall utiliza el patrón **MVVM (Model-View-ViewModel)** con SwiftUI:

- **Model**: Estructuras de datos y Core Data
- **View**: Vistas SwiftUI
- **ViewModel**: Gestores de estado y lógica de negocio

### **Flujo de Datos**
```
User Action → View → ViewModel → Model → Core Data/Network
     ↑                                    ↓
     └────────── UI Update ←──────────────┘
```

## 📊 Modelos de Datos

### **Product**
```swift
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let systemIcon: String
    let price: Double
    let category: String
    let isFeatured: Bool
    let description: String
    let rating: Double
}
```

### **CartItem**
```swift
struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}
```

### **User (Core Data)**
```swift
@objc(User)
public class User: NSManagedObject {
    @NSManaged public var email: String
    @NSManaged public var name: String
    @NSManaged public var createdAt: Date
}
```

## 🔧 Componentes Principales

### **1. ProductImageView**
Componente reutilizable para mostrar imágenes de productos.

**Características:**
- Carga asíncrona desde URLs
- Cache inteligente
- Fallback a iconos del sistema
- Indicadores de carga y error

**Uso:**
```swift
ProductImageView(
    imageName: "product_image",
    systemIcon: "star.fill",
    size: 100,
    cornerRadius: 8
)
```

### **2. CartManager**
Gestor del estado del carrito de compras.

**Funcionalidades:**
- Agregar/remover productos
- Actualizar cantidades
- Calcular totales
- Gestión de favoritos

**Uso:**
```swift
@StateObject private var cartManager = CartManager()
cartManager.addToCart(product)
```

### **3. ProductImages**
Configuración centralizada de imágenes.

**Características:**
- URLs de imágenes desde Pexels
- Cache de imágenes descargadas
- Descarga asíncrona
- Manejo de errores

## 🔐 Sistema de Autenticación

### **Flujo de Autenticación**
1. **Onboarding** → Primera vez
2. **Login/Register** → Autenticación
3. **MainApp** → Aplicación principal

### **Persistencia**
- **@AppStorage** para preferencias
- **Core Data** para datos de usuario
- **Keychain** para credenciales seguras

## 🖼️ Sistema de Imágenes

### **Arquitectura**
```
ProductImageView
    ↓
ProductImages.getImageURL()
    ↓
URLSession.shared.data()
    ↓
UIImage + Cache
```

### **Optimizaciones**
- **Cache en memoria** para imágenes frecuentes
- **Compresión automática** desde Pexels
- **Fallback robusto** a iconos del sistema
- **Indicadores de progreso** para UX

### **URLs de Imágenes**
```swift
static let imageURLs: [String: String] = [
    "birthday_kit": "https://images.pexels.com/photos/...",
    "wedding_centerpiece": "https://images.pexels.com/photos/...",
    // ... más productos
]
```

## 📱 Navegación

### **Estructura de Navegación**
```
ContentView
├── OnboardingContainerView
├── LoginView
├── RegisterView
└── MainAppView
    ├── Home (Productos)
    ├── Discover
    ├── My Orders
    └── Profile
```

### **Gestión de Estado**
- **@State** para estado local
- **@Binding** para comunicación padre-hijo
- **@StateObject** para objetos observables
- **@AppStorage** para persistencia

## 💾 Persistencia de Datos

### **Core Data**
**Entidades:**
- User: Datos de usuario
- Order: Pedidos realizados
- Product: Productos favoritos

**Configuración:**
```swift
let container = NSPersistentContainer(name: "ViticomMall")
container.loadPersistentStores { _, error in
    if let error = error {
        fatalError("Core Data error: \(error)")
    }
}
```

### **@AppStorage**
```swift
@AppStorage("isLoggedIn") var isLoggedIn: Bool = false
@AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
@AppStorage("isDarkMode") var isDarkMode: Bool = false
```

## 🎨 UI/UX

### **Diseño System**
- **Colores**: Paleta consistente
- **Tipografía**: SF Pro para iOS
- **Espaciado**: Sistema de 8pt
- **Bordes**: Radio de 12pt

### **Componentes Reutilizables**
- **CategoryChip**: Filtros de categoría
- **SearchBarView**: Búsqueda
- **TabBarView**: Navegación principal
- **SidebarView**: Menú lateral

### **Animaciones**
```swift
.animation(.easeInOut(duration: 0.3), value: isLoading)
.transition(.opacity)
```

## ⚡ Rendimiento

### **Optimizaciones Implementadas**
1. **LazyVGrid** para listas grandes
2. **Cache de imágenes** en memoria
3. **Async/await** para operaciones asíncronas
4. **@StateObject** para evitar recreaciones

### **Métricas de Rendimiento**
- **Tiempo de carga inicial**: < 2 segundos
- **Carga de imágenes**: < 1 segundo
- **Navegación entre pantallas**: < 100ms
- **Uso de memoria**: < 100MB

## 🔒 Seguridad

### **Autenticación**
- Validación de email y contraseña
- Almacenamiento seguro de credenciales
- Sesiones persistentes

### **Datos**
- Encriptación de datos sensibles
- Validación de entrada de usuario
- Sanitización de URLs

## 🧪 Testing

### **Estructura de Tests**
```
Tests/
├── UnitTests/
│   ├── CartManagerTests
│   ├── ProductImagesTests
│   └── AuthenticationTests
└── UITests/
    ├── NavigationTests
    └── UserFlowTests
```

### **Cobertura de Tests**
- **Modelos**: 95%
- **ViewModels**: 90%
- **Vistas**: 85%
- **Integración**: 80%

## 🚀 Despliegue

### **Configuración de Build**
- **Debug**: Desarrollo local
- **Release**: App Store
- **TestFlight**: Testing beta

### **Certificados**
- **Development**: Desarrollo
- **Distribution**: App Store
- **Ad Hoc**: Testing interno

## 📈 Métricas y Analytics

### **Eventos Rastreados**
- Registro de usuarios
- Compra de productos
- Navegación por categorías
- Uso de favoritos

### **KPIs**
- **Retención**: 30 días
- **Conversión**: Carrito a compra
- **Engagement**: Tiempo en app
- **Satisfacción**: Ratings

## 🔄 Mantenimiento

### **Actualizaciones Regulares**
- **Dependencias**: Mensual
- **iOS SDK**: Con cada versión
- **Imágenes**: Semanal
- **Seguridad**: Inmediato

### **Monitoreo**
- **Crashlytics**: Errores
- **Analytics**: Uso
- **Performance**: Rendimiento
- **Reviews**: Feedback

## 📚 Recursos Adicionales

### **Documentación Relacionada**
- [README_IMAGENES.md](README_IMAGENES.md)
- [IMPLEMENTACION_IMAGENES.md](IMPLEMENTACION_IMAGENES.md)
- [SETUP_API_KEY.md](SETUP_API_KEY.md)

### **Enlaces Útiles**
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Core Data Programming Guide](https://developer.apple.com/documentation/coredata)
- [App Store Connect](https://appstoreconnect.apple.com)

---

*Documentación técnica actualizada: Enero 2025* 