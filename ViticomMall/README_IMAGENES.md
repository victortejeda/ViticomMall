# Guía para Agregar Imágenes a los Productos

## Sistema de Imágenes Implementado

El sistema de imágenes de ViticomMall soporta tres tipos de imágenes:

1. **Imágenes locales** (en Assets.xcassets)
2. **Imágenes desde URLs** (descargadas automáticamente)
3. **Iconos del sistema** (como fallback)

## Cómo Funciona

### 1. Estructura del Modelo de Producto

```swift
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String        // Nombre de la imagen en Assets o clave para URL
    let systemIcon: String       // Icono del sistema como fallback
    let price: Double
    let category: String
    let isFeatured: Bool
    let description: String
    let rating: Double
}
```

### 2. Componente ProductImageView

El componente `ProductImageView` maneja automáticamente:
- Carga de imágenes locales desde Assets
- Descarga de imágenes desde URLs
- Fallback a iconos del sistema
- Indicador de carga
- Manejo de errores

## Cómo Agregar Imágenes

### Opción 1: Imágenes Locales (Recomendado)

1. **Agregar imagen a Assets.xcassets:**
   - Abre `ViticomMall/Assets.xcassets`
   - Crea un nuevo Image Set
   - Nombra la imagen (ej: `birthday_kit`)
   - Arrastra tu imagen al Image Set

2. **Usar en el producto:**
```swift
Product(
    name: "Kit Decoración Cumpleaños",
    imageName: "birthday_kit",           // Nombre exacto del Image Set
    systemIcon: "balloon.2.fill",        // Fallback
    price: 45.00,
    category: "Cumpleaños",
    isFeatured: true,
    description: "Kit completo...",
    rating: 4.8
)
```

### Opción 2: Imágenes desde URLs

1. **Agregar URL en ProductImages.swift:**
```swift
static let imageURLs: [String: String] = [
    "birthday_kit": "https://ejemplo.com/imagen.jpg",
    // ... más URLs
]
```

2. **Usar en el producto:**
```swift
Product(
    name: "Kit Decoración Cumpleaños",
    imageName: "birthday_kit",           // Clave que coincide con la URL
    systemIcon: "balloon.2.fill",        // Fallback si la URL falla
    // ... resto de propiedades
)
```

### Opción 3: Solo Iconos del Sistema

```swift
Product(
    name: "Producto Simple",
    imageName: "",                       // Vacío para usar solo icono
    systemIcon: "star.fill",             // Icono del sistema
    // ... resto de propiedades
)
```

## Estilos de Imágenes Disponibles

### ProductImageView Básico
```swift
ProductImageView(
    imageName: "mi_imagen",
    systemIcon: "star.fill",
    size: 100
)
```

### ProductImageView Circular
```swift
ProductImageView.circular(
    imageName: "mi_imagen",
    systemIcon: "star.fill",
    size: 80
)
```

### ProductImageView Redondeado
```swift
ProductImageView.rounded(
    imageName: "mi_imagen",
    systemIcon: "star.fill",
    size: 120,
    cornerRadius: 16
)
```

## Mejores Prácticas

### 1. Nombres de Imágenes
- Usa nombres descriptivos: `birthday_kit`, `wedding_centerpiece`
- Evita espacios y caracteres especiales
- Usa snake_case para consistencia

### 2. Tamaños de Imagen
- **Tarjetas pequeñas:** 60-80px
- **Tarjetas destacadas:** 70-100px
- **Vista detallada:** 120-200px
- **Carrito:** 40-60px

### 3. Formatos Soportados
- **Local:** PNG, JPEG, SVG
- **URL:** PNG, JPEG, WebP
- **Tamaño recomendado:** 400x400px mínimo

### 4. Optimización
- Comprime imágenes antes de agregarlas
- Usa formatos modernos (WebP cuando sea posible)
- Considera diferentes densidades de pantalla

## Ejemplo Completo

```swift
// En MainAppView.swift o donde definas productos
let allProducts: [Product] = [
    Product(
        name: "Kit Decoración Cumpleaños Premium",
        imageName: "birthday_kit",           // Imagen local o URL
        systemIcon: "balloon.2.fill",        // Fallback
        price: 45.00,
        category: "Cumpleaños",
        isFeatured: true,
        description: "Kit completo con globos, decoraciones y accesorios",
        rating: 4.8
    ),
    // ... más productos
]

// En la vista
ProductImageView(
    imageName: product.imageName,
    systemIcon: product.systemIcon,
    size: 70
)
```

## Solución de Problemas

### La imagen no se muestra
1. Verifica que el nombre coincida exactamente
2. Asegúrate de que la imagen esté en Assets.xcassets
3. Si usas URL, verifica que la URL sea válida
4. Revisa la consola para errores de red

### La imagen se ve pixelada
1. Usa imágenes de mayor resolución
2. Considera agregar imágenes @2x y @3x
3. Optimiza el formato de imagen

### Carga lenta
1. Comprime las imágenes
2. Usa CDN para URLs
3. Considera precargar imágenes importantes

## Archivos Relacionados

- `Components/ProductImageView.swift` - Componente principal
- `Models/ProductImages.swift` - Configuración de URLs
- `Main/MainAppView.swift` - Productos principales
- `Views/DiscoverView.swift` - Productos de descubrimiento
- `Views/CartView.swift` - Productos en carrito 