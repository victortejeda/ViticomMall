# Configuración de API Key para Imágenes

## 🎯 API de Pixabay

Para que las imágenes funcionen correctamente, necesitas obtener una API key gratuita de Pixabay.

### 📋 Pasos para obtener tu API Key:

1. **Ve a Pixabay**: https://pixabay.com/api/docs/
2. **Regístrate** (es gratis)
3. **Obtén tu API Key** en tu perfil
4. **Reemplaza la API Key** en el código

### 🔧 Cómo actualizar la API Key:

1. **Abre el archivo**: `ViticomMall/Models/ProductImages.swift`
2. **Busca esta línea**:
   ```swift
   static let apiKey = "36817522-8c4b8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c"
   ```
3. **Reemplázala** con tu API key real:
   ```swift
   static let apiKey = "TU_API_KEY_AQUI"
   ```

### 🚀 URLs de Respaldo

Si no quieres usar la API, el sistema también incluye URLs de respaldo desde **Pexels** que funcionan sin API key:

- ✅ **Funcionan inmediatamente**
- ✅ **No requieren registro**
- ✅ **Imágenes de alta calidad**
- ✅ **Optimizadas para móviles**

### 📱 Resultado

Con cualquiera de las dos opciones, verás:
- 🖼️ **Imágenes reales** de productos de eventos
- ⚡ **Carga rápida** con cache automático
- 🔄 **Fallback inteligente** si algo falla
- 📊 **Indicadores de carga** y error

### 🧪 Probar el Sistema

Para verificar que funciona:

1. **Compila la app** en Xcode
2. **Navega a los productos** en la app
3. **Deberías ver imágenes reales** en lugar de iconos
4. **Si ves iconos**, revisa la consola para errores

### 🔍 Solución de Problemas

**Si solo ves iconos:**

1. **Verifica la conexión a internet**
2. **Revisa la consola de Xcode** para errores
3. **Asegúrate de que las URLs de respaldo funcionen**
4. **Prueba en el simulador y dispositivo real**

**Si las imágenes no cargan:**

1. **Limpia el proyecto** (Cmd+Shift+K)
2. **Reconstruye** (Cmd+B)
3. **Reinicia el simulador**
4. **Verifica los permisos de red**

### 📞 Soporte

Si tienes problemas:
1. Revisa la consola de Xcode
2. Verifica que las URLs de respaldo funcionen
3. Asegúrate de tener conexión a internet
4. Prueba en diferentes dispositivos

¡Con esto deberías ver imágenes reales en tu app! 🎉 