# 🤝 Guía de Contribución - ViticomMall

¡Gracias por tu interés en contribuir a ViticomMall! Este documento te guiará a través del proceso de contribución.

## 📋 Tabla de Contenidos

- [¿Cómo Contribuir?](#cómo-contribuir)
- [Configuración del Entorno](#configuración-del-entorno)
- [Flujo de Trabajo](#flujo-de-trabajo)
- [Estándares de Código](#estándares-de-código)
- [Reportar Bugs](#reportar-bugs)
- [Solicitar Features](#solicitar-features)
- [Preguntas Frecuentes](#preguntas-frecuentes)

## 🚀 ¿Cómo Contribuir?

### **Tipos de Contribuciones**
- 🐛 **Reportar bugs**
- 💡 **Solicitar nuevas características**
- 🔧 **Corregir bugs**
- ✨ **Implementar nuevas características**
- 📚 **Mejorar documentación**
- 🧪 **Agregar tests**
- 🎨 **Mejorar la UI/UX**

## 🛠️ Configuración del Entorno

### **Requisitos**
- macOS 13.0 o superior
- Xcode 15.0 o superior
- Git
- Conocimientos básicos de SwiftUI

### **Configuración Inicial**
```bash
# 1. Fork el repositorio
# Ve a https://github.com/victortejeda/ViticomMall y haz fork

# 2. Clona tu fork
git clone https://github.com/TU_USUARIO/ViticomMall.git
cd ViticomMall

# 3. Agrega el repositorio original como upstream
git remote add upstream https://github.com/victortejeda/ViticomMall.git

# 4. Crea una rama para tu feature
git checkout -b feature/tu-nueva-caracteristica
```

## 🔄 Flujo de Trabajo

### **1. Preparación**
```bash
# Asegúrate de estar en la rama main y actualizada
git checkout main
git pull upstream main

# Crea una nueva rama para tu trabajo
git checkout -b feature/nombre-de-tu-feature
```

### **2. Desarrollo**
- Implementa tus cambios
- Sigue los estándares de código
- Escribe tests si es necesario
- Actualiza la documentación

### **3. Testing**
```bash
# Ejecuta los tests
Cmd + U  # En Xcode

# Verifica que la app compile
Cmd + B  # En Xcode
```

### **4. Commit**
```bash
# Agrega tus cambios
git add .

# Haz commit con un mensaje descriptivo
git commit -m "feat: add new product category filter

- Add CategoryFilterView component
- Implement filter logic in MainAppView
- Add tests for filter functionality
- Update documentation"
```

### **5. Push y Pull Request**
```bash
# Push a tu fork
git push origin feature/nombre-de-tu-feature

# Crea un Pull Request en GitHub
# Ve a https://github.com/TU_USUARIO/ViticomMall/pulls
```

## 📝 Estándares de Código

### **Convenciones de Nomenclatura**
```swift
// Archivos: PascalCase
MainAppView.swift
CartManager.swift

// Clases y Structs: PascalCase
struct ProductView: View
class CartManager: ObservableObject

// Variables y Funciones: camelCase
var productName: String
func loadProducts() async

// Constantes: UPPER_SNAKE_CASE
let MAX_PRODUCTS = 100
let DEFAULT_TIMEOUT = 30.0
```

### **Estructura de Archivos**
```swift
// 1. Imports
import SwiftUI
import Foundation

// 2. Comentarios de documentación
/// Vista principal que muestra la lista de productos
struct ProductListView: View {
    
    // 3. Properties
    @StateObject private var viewModel = ProductViewModel()
    @State private var isLoading = false
    
    // 4. Body
    var body: some View {
        // UI aquí
    }
    
    // 5. Funciones privadas
    private func loadData() {
        // Lógica aquí
    }
}
```

### **Comentarios**
```swift
// Comentario de una línea
let maxItems = 100 // Máximo de productos por página

/*
 Comentario de múltiples líneas
 para explicar lógica compleja
 */

/// Documentación de función
/// - Parameter product: El producto a agregar
/// - Returns: true si se agregó exitosamente
func addToCart(_ product: Product) -> Bool {
    // Implementación
}
```

### **Formato de Commits**
```bash
# Convención: tipo(alcance): descripción

feat: add new product category
fix: resolve image loading issue
docs: update README with new features
refactor: improve cart manager performance
test: add unit tests for authentication
style: fix code formatting
perf: optimize image loading
ci: update GitHub Actions workflow
```

## 🐛 Reportar Bugs

### **Antes de Reportar**
1. Verifica que el bug no haya sido reportado ya
2. Asegúrate de que estés usando la última versión
3. Intenta reproducir el bug en un entorno limpio

### **Template de Bug Report**
```markdown
## 🐛 Bug Report

### Descripción
Descripción clara y concisa del bug.

### Pasos para Reproducir
1. Ve a '...'
2. Haz clic en '...'
3. Desplázate hacia abajo hasta '...'
4. Ve el error

### Comportamiento Esperado
Descripción de lo que debería pasar.

### Comportamiento Actual
Descripción de lo que realmente pasa.

### Capturas de Pantalla
Si aplica, agrega capturas de pantalla.

### Información del Sistema
- iOS: [ej. 17.0]
- Dispositivo: [ej. iPhone 15]
- Versión de la app: [ej. 1.0.0]

### Información Adicional
Cualquier otra información relevante.
```

## 💡 Solicitar Features

### **Template de Feature Request**
```markdown
## 💡 Feature Request

### Descripción
Descripción clara de la característica que te gustaría ver.

### Problema que Resuelve
Explica qué problema resuelve esta característica.

### Solución Propuesta
Describe la solución que propones.

### Alternativas Consideradas
Describe cualquier alternativa que hayas considerado.

### Información Adicional
Cualquier otra información relevante.
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
    
    override func tearDown() {
        cartManager = nil
        super.tearDown()
    }
    
    func testAddToCart() {
        // Given
        let product = Product(name: "Test Product", price: 10.0)
        
        // When
        cartManager.addToCart(product)
        
        // Then
        XCTAssertEqual(cartManager.cartItems.count, 1)
        XCTAssertEqual(cartManager.totalPrice, 10.0)
    }
}
```

### **Tests de UI**
```swift
class ViticomMallUITests: XCTestCase {
    func testLoginFlow() {
        let app = XCUIApplication()
        app.launch()
        
        // Test login flow
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText("test@example.com")
        
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("password")
        
        app.buttons["Login"].tap()
        
        // Verify successful login
        XCTAssertTrue(app.tabBars["Tab Bar"].exists)
    }
}
```

## 📚 Documentación

### **Actualizar Documentación**
- Mantén la documentación actualizada con tus cambios
- Agrega ejemplos de código cuando sea necesario
- Actualiza el README si agregas nuevas características
- Documenta APIs públicas

### **Comentarios de Código**
```swift
/// Componente reutilizable para mostrar imágenes de productos
/// 
/// Este componente maneja la carga asíncrona de imágenes desde URLs,
/// cache local, y fallback a iconos del sistema.
/// 
/// - Parameters:
///   - imageName: Nombre de la imagen en Assets o clave para URL
///   - systemIcon: Icono del sistema como fallback
///   - size: Tamaño de la imagen
///   - cornerRadius: Radio de las esquinas (opcional)
struct ProductImageView: View {
    // Implementación
}
```

## 🔍 Code Review

### **Antes de Solicitar Review**
- [ ] El código compila sin errores
- [ ] Los tests pasan
- [ ] La documentación está actualizada
- [ ] El código sigue los estándares
- [ ] No hay código comentado o sin usar

### **Durante el Review**
- Responde a los comentarios de manera constructiva
- Haz los cambios solicitados
- Mantén la conversación profesional
- Aprende de los feedbacks

## 🎉 Reconocimiento

### **Contribuidores**
- Tu nombre aparecerá en la lista de contribuidores
- Se te dará crédito en el changelog
- Podrás agregar tu contribución a tu portfolio

### **Código de Conducta**
- Sé respetuoso con otros contribuidores
- Mantén las discusiones constructivas
- Ayuda a otros cuando puedas
- Celebra las contribuciones de otros

## ❓ Preguntas Frecuentes

### **¿Puedo contribuir si soy principiante?**
¡Absolutamente! Todas las contribuciones son bienvenidas, sin importar tu nivel de experiencia.

### **¿Qué pasa si mi PR es rechazado?**
No te desanimes. Los rechazos son oportunidades de aprendizaje. Revisa los comentarios y mejora tu código.

### **¿Cómo puedo empezar?**
- Revisa los issues marcados como "good first issue"
- Lee la documentación del proyecto
- Únete a las discusiones en GitHub
- Haz preguntas en los issues

### **¿Necesito experiencia en SwiftUI?**
Es útil pero no es obligatorio. Puedes contribuir con documentación, tests, o reportar bugs.

## 📞 Contacto

Si tienes preguntas sobre cómo contribuir:

- **Issues**: Crea un issue en GitHub
- **Discussions**: Usa la pestaña Discussions
- **Email**: victortejeda@example.com

---

**¡Gracias por contribuir a ViticomMall! 🎉**

*Juntos hacemos que esta app sea mejor para todos.* 