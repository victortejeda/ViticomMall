# 👨‍💻 Guía de Desarrollo - ViticomMall

## 🚀 Configuración del Entorno de Desarrollo

### **Requisitos Previos**
- **macOS** 13.0 o superior
- **Xcode** 15.0 o superior
- **Git** para control de versiones
- **CocoaPods** (opcional, para dependencias)

### **Configuración Inicial**
```bash
# 1. Clonar el repositorio
git clone https://github.com/victortejeda/ViticomMall.git
cd ViticomMall

# 2. Abrir en Xcode
open ViticomMall.xcodeproj

# 3. Configurar equipo de desarrollo
# En Xcode: Preferences → Accounts → Add Apple ID
```

## 📁 Estructura del Código

### **Convenciones de Nomenclatura**
```swift
// Archivos
MainAppView.swift          // PascalCase
cartManager.swift          // camelCase

// Clases y Structs
struct ProductView         // PascalCase
class CartManager          // PascalCase

// Variables y Funciones
var productName: String    // camelCase
func loadImage()           // camelCase

// Constantes
let MAX_ITEMS = 100        // UPPER_SNAKE_CASE
```

### **Organización de Archivos**
```
ViticomMall/
├── 📱 App/                    # Archivos principales
├── 🔐 Auth/                   # Autenticación
├── 🎯 Onboarding/             # Onboarding
├── 🏠 Main/                   # Vista principal
├── 🖼️ Views/                  # Vistas de la app
├── 🧩 Components/             # Componentes reutilizables
├── 📊 Models/                 # Modelos de datos
└── 📚 Documentation/          # Documentación
```

## 🔧 Patrones de Desarrollo

### **1. MVVM con SwiftUI**
```swift
// Model
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

// View
struct ProductView: View {
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        // UI aquí
    }
}

// ViewModel
class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    func loadProducts() {
        // Lógica de negocio
    }
}
```

### **2. Gestión de Estado**
```swift
// Estado Local
@State private var isLoading = false

// Estado Compartido
@StateObject private var cartManager = CartManager()

// Estado Persistente
@AppStorage("isLoggedIn") var isLoggedIn = false

// Binding
@Binding var selectedProduct: Product?
```

### **3. Async/Await**
```swift
func loadImage() async {
    do {
        let image = try await downloadImage(from: url)
        await MainActor.run {
            self.image = image
        }
    } catch {
        print("Error: \(error)")
    }
}
```

## 🎨 Componentes Reutilizables

### **Crear un Nuevo Componente**
```swift
// 1. Crear archivo en Components/
struct CustomButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}

// 2. Usar en otras vistas
CustomButton(title: "Comprar") {
    // Acción
}
```

### **Componentes Existentes**
- **ProductImageView**: Imágenes de productos
- **CategoryChip**: Filtros de categoría
- **SearchBarView**: Búsqueda
- **TabBarView**: Navegación

## 📊 Modelos de Datos

### **Agregar un Nuevo Modelo**
```swift
// 1. Crear struct
struct NewProduct: Identifiable, Codable {
    let id = UUID()
    let name: String
    let price: Double
    let category: String
}

// 2. Agregar a Core Data (si es necesario)
// - Abrir .xcdatamodeld
// - Agregar nueva entidad
// - Generar clases NSManagedObject
```

### **Persistencia de Datos**
```swift
// Core Data
@Environment(\.managedObjectContext) private var viewContext
let newItem = Item(context: viewContext)
newItem.timestamp = Date()
try viewContext.save()

// UserDefaults
UserDefaults.standard.set(value, forKey: "key")
let value = UserDefaults.standard.string(forKey: "key")

// @AppStorage
@AppStorage("username") var username: String = ""
```

## 🖼️ Sistema de Imágenes

### **Agregar Nueva Imagen**
```swift
// 1. En ProductImages.swift
static let imageURLs: [String: String] = [
    "new_product": "https://images.pexels.com/photos/...",
    // ... más productos
]

// 2. En el modelo Product
Product(
    name: "Nuevo Producto",
    imageName: "new_product",        // Clave de la imagen
    systemIcon: "star.fill",         // Fallback
    // ... otros campos
)
```

### **Optimización de Imágenes**
```swift
// Tamaños recomendados
let sizes = [
    "small": 60,      // Listas
    "medium": 100,    // Tarjetas
    "large": 200,     // Detalles
    "xlarge": 400     // Full screen
]

// Formatos soportados
let formats = ["JPEG", "PNG", "WebP"]
```

## 🔐 Autenticación

### **Flujo de Autenticación**
```swift
// 1. Verificar estado
@AppStorage("isLoggedIn") var isLoggedIn = false
@AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false

// 2. Navegación condicional
if !hasCompletedOnboarding {
    OnboardingView()
} else if !isLoggedIn {
    LoginView()
} else {
    MainAppView()
}
```

### **Validación de Formularios**
```swift
func validateEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}
```

## 🧪 Testing

### **Tests Unitarios**
```swift
import XCTest
@testable import ViticomMall

class CartManagerTests: XCTestCase {
    var cartManager: CartManager!
    
    override func setUp() {
        super.setUp()
        cartManager = CartManager()
    }
    
    func testAddToCart() {
        let product = Product(name: "Test", price: 10.0)
        cartManager.addToCart(product)
        XCTAssertEqual(cartManager.cartItems.count, 1)
    }
}
```

### **Tests de UI**
```swift
class ViticomMallUITests: XCTestCase {
    func testLoginFlow() {
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText("test@example.com")
        
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("password")
        
        app.buttons["Login"].tap()
        
        XCTAssertTrue(app.tabBars["Tab Bar"].exists)
    }
}
```

## 🚀 Despliegue

### **Configuración de Build**
```swift
// Info.plist
<key>CFBundleDisplayName</key>
<string>ViticomMall</string>

<key>CFBundleVersion</key>
<string>1.0.0</string>

<key>CFBundleShortVersionString</key>
<string>1.0.0</string>
```

### **Certificados y Provisioning**
1. **Development**: Para desarrollo local
2. **Ad Hoc**: Para testing interno
3. **App Store**: Para distribución

### **App Store Connect**
1. Crear app en App Store Connect
2. Configurar metadatos
3. Subir build
4. Configurar pricing y availability

## 🔍 Debugging

### **Logs y Console**
```swift
// Logs estructurados
print("🔍 [DEBUG] Loading products...")
print("✅ [SUCCESS] Products loaded: \(count)")
print("❌ [ERROR] Failed to load: \(error)")

// Breakpoints condicionales
if product.price > 100 {
    // Breakpoint aquí
}
```

### **Instruments**
- **Time Profiler**: Rendimiento
- **Allocations**: Memoria
- **Network**: Conexiones
- **Core Animation**: UI

### **Simulator vs Device**
```swift
#if targetEnvironment(simulator)
    // Código solo para simulador
    print("Running in Simulator")
#else
    // Código solo para dispositivo
    print("Running on Device")
#endif
```

## 📈 Performance

### **Optimizaciones**
```swift
// 1. LazyVGrid para listas grandes
LazyVGrid(columns: columns, spacing: 16) {
    ForEach(products) { product in
        ProductCard(product: product)
    }
}

// 2. Cache de imágenes
static var imageCache: [String: UIImage] = [:]

// 3. Async/await para operaciones pesadas
Task {
    let result = await heavyOperation()
    await MainActor.run {
        self.result = result
    }
}
```

### **Métricas**
- **Tiempo de carga**: < 2 segundos
- **FPS**: 60 fps constante
- **Memoria**: < 100MB
- **Batería**: Optimizado

## 🔄 Git Workflow

### **Branches**
```bash
main                    # Producción
develop                 # Desarrollo
feature/new-feature     # Nuevas características
hotfix/critical-bug     # Correcciones urgentes
```

### **Commits**
```bash
# Convención de commits
feat: add new product category
fix: resolve image loading issue
docs: update README
refactor: improve cart manager
test: add unit tests for auth
```

### **Pull Requests**
1. Crear branch desde `develop`
2. Implementar cambios
3. Crear PR con descripción detallada
4. Code review
5. Merge a `develop`

## 📚 Recursos

### **Documentación**
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Core Data Programming Guide](https://developer.apple.com/documentation/coredata)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

### **Herramientas**
- **SwiftLint**: Linting de código
- **Instruments**: Profiling
- **Simulator**: Testing
- **TestFlight**: Beta testing

### **Comunidad**
- [Swift Forums](https://forums.swift.org)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/swiftui)
- [Reddit r/SwiftUI](https://reddit.com/r/SwiftUI)

---

*Guía de desarrollo actualizada: Enero 2025* 