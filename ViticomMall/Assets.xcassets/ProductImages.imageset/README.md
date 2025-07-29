# Cómo Agregar Imágenes a Assets.xcassets

## Pasos para Agregar Imágenes Locales

### 1. Abrir Assets.xcassets en Xcode
- En Xcode, navega a `ViticomMall/Assets.xcassets`
- Haz clic derecho en el área vacía
- Selecciona "New Image Set"

### 2. Nombrar el Image Set
- Usa el nombre exacto que aparece en el código
- Ejemplos:
  - `birthday_kit`
  - `wedding_centerpiece`
  - `baby_shower_set`
  - `graduation_cap`

### 3. Agregar las Imágenes
- Arrastra tu imagen al slot correspondiente:
  - **1x**: Para pantallas estándar (1x)
  - **2x**: Para pantallas Retina (2x)
  - **3x**: Para pantallas Super Retina (3x)

### 4. Configuración Recomendada
- **Tamaño mínimo**: 400x400px
- **Formato**: PNG o JPEG
- **Optimización**: Comprime las imágenes antes de agregarlas

## Estructura de Carpetas Recomendada

```
Assets.xcassets/
├── ProductImages.imageset/
│   ├── birthday_kit.imageset/
│   │   ├── birthday_kit@1x.png
│   │   ├── birthday_kit@2x.png
│   │   ├── birthday_kit@3x.png
│   │   └── Contents.json
│   ├── wedding_centerpiece.imageset/
│   │   ├── wedding_centerpiece@1x.png
│   │   ├── wedding_centerpiece@2x.png
│   │   ├── wedding_centerpiece@3x.png
│   │   └── Contents.json
│   └── ... (más productos)
```

## Nombres de Imágenes Requeridos

Basado en el código actual, necesitas estas imágenes:

### Productos Destacados
- `birthday_kit`
- `wedding_centerpiece`
- `baby_shower_set`
- `balloon_arch`

### Productos por Categoría
- `graduation_cap`
- `led_lights`
- `metallic_balloons`
- `wedding_veil`
- `graduation_gown`
- `party_kit`
- `baby_shower_pink`
- `candy_table`
- `decorative_pillows`
- `custom_diploma`
- `balloon_bouquet`
- `elegant_candles`
- `graduation_kit`
- `neon_decor`

## Script de Generación Automática

Puedes usar el script incluido para generar imágenes de placeholder:

```bash
cd ViticomMall/Scripts
python3 generate_placeholder_images.py
```

Este script generará imágenes de placeholder con:
- Colores por categoría
- Texto del producto
- Tamaño optimizado (400x400px)

## Verificación

Después de agregar las imágenes:

1. **Compila el proyecto** en Xcode
2. **Verifica en el simulador** que las imágenes se muestren
3. **Revisa la consola** para errores de carga
4. **Prueba en diferentes dispositivos** para verificar escalado

## Solución de Problemas

### La imagen no aparece
- Verifica que el nombre coincida exactamente
- Asegúrate de que la imagen esté en el slot correcto
- Limpia y reconstruye el proyecto (Cmd+Shift+K)

### La imagen se ve borrosa
- Agrega versiones @2x y @3x
- Usa imágenes de mayor resolución
- Verifica que el formato sea PNG o JPEG

### Error de compilación
- Verifica que no haya caracteres especiales en el nombre
- Asegúrate de que el archivo sea una imagen válida
- Revisa que el Image Set esté bien configurado 