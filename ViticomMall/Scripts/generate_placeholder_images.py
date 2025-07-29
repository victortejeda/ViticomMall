#!/usr/bin/env python3
"""
Script para generar imágenes de placeholder para productos de ViticomMall
Este script crea imágenes de ejemplo para usar en desarrollo
"""

import os
from PIL import Image, ImageDraw, ImageFont
import requests
from io import BytesIO

# Configuración
IMAGE_SIZE = (400, 400)
FONT_SIZE = 40
BACKGROUND_COLORS = {
    'Cumpleaños': '#FF6B9D',
    'Bodas': '#FFD700',
    'Graduaciones': '#4A90E2',
    'Baby Shower': '#FFB6C1',
    'Fiestas': '#9370DB'
}

def create_placeholder_image(product_name, category, filename):
    """Crea una imagen de placeholder para un producto"""
    
    # Crear imagen base
    img = Image.new('RGB', IMAGE_SIZE, BACKGROUND_COLORS.get(category, '#CCCCCC'))
    draw = ImageDraw.Draw(img)
    
    # Intentar cargar una fuente
    try:
        font = ImageFont.truetype("Arial.ttf", FONT_SIZE)
    except:
        font = ImageFont.load_default()
    
    # Dividir el nombre del producto en líneas
    words = product_name.split()
    lines = []
    current_line = ""
    
    for word in words:
        test_line = current_line + " " + word if current_line else word
        bbox = draw.textbbox((0, 0), test_line, font=font)
        text_width = bbox[2] - bbox[0]
        
        if text_width < IMAGE_SIZE[0] - 40:
            current_line = test_line
        else:
            if current_line:
                lines.append(current_line)
            current_line = word
    
    if current_line:
        lines.append(current_line)
    
    # Dibujar el texto centrado
    total_height = len(lines) * (FONT_SIZE + 10)
    y_start = (IMAGE_SIZE[1] - total_height) // 2
    
    for i, line in enumerate(lines):
        bbox = draw.textbbox((0, 0), line, font=font)
        text_width = bbox[2] - bbox[0]
        x = (IMAGE_SIZE[0] - text_width) // 2
        y = y_start + i * (FONT_SIZE + 10)
        
        # Sombra del texto
        draw.text((x+2, y+2), line, font=font, fill='#000000')
        # Texto principal
        draw.text((x, y), line, font=font, fill='#FFFFFF')
    
    # Agregar categoría en la parte inferior
    category_font = ImageFont.truetype("Arial.ttf", 20) if os.path.exists("Arial.ttf") else ImageFont.load_default()
    bbox = draw.textbbox((0, 0), category, font=category_font)
    text_width = bbox[2] - bbox[0]
    x = (IMAGE_SIZE[0] - text_width) // 2
    y = IMAGE_SIZE[1] - 40
    
    draw.text((x, y), category, font=category_font, fill='#FFFFFF')
    
    # Guardar imagen
    img.save(filename)
    print(f"Imagen creada: {filename}")

def download_unsplash_image(query, filename):
    """Descarga una imagen de Unsplash (requiere API key)"""
    # Nota: Para usar esto necesitarías una API key de Unsplash
    # Por ahora solo creamos placeholders
    create_placeholder_image(query, "Producto", filename)

def main():
    """Función principal"""
    
    # Crear directorio para imágenes si no existe
    output_dir = "ViticomMall/Assets.xcassets/ProductImages"
    os.makedirs(output_dir, exist_ok=True)
    
    # Lista de productos para generar imágenes
    products = [
        ("Kit Decoración Cumpleaños Premium", "Cumpleaños", "birthday_kit"),
        ("Centro de Mesa Boda Elegante", "Bodas", "wedding_centerpiece"),
        ("Set Baby Shower Completo", "Baby Shower", "baby_shower_set"),
        ("Arco de Globos Profesional", "Fiestas", "balloon_arch"),
        ("Gorra Graduación", "Graduaciones", "graduation_cap"),
        ("Luces LED Fiesta", "Fiestas", "led_lights"),
        ("Globos Metálicos", "Cumpleaños", "metallic_balloons"),
        ("Velo de Novia", "Bodas", "wedding_veil"),
        ("Toga Graduación", "Graduaciones", "graduation_gown"),
        ("Kit Fiesta Temática", "Fiestas", "party_kit"),
        ("Decoración Baby Shower Rosa", "Baby Shower", "baby_shower_pink"),
        ("Mesa de Dulces", "Cumpleaños", "candy_table"),
        ("Cojines Decorativos", "Bodas", "decorative_pillows"),
        ("Diploma Personalizado", "Graduaciones", "custom_diploma"),
        ("Ramo de Globos", "Baby Shower", "balloon_bouquet"),
        ("Candeleros Elegantes", "Bodas", "elegant_candles"),
        ("Kit Graduación Completo", "Graduaciones", "graduation_kit"),
        ("Decoración Fiesta Neon", "Fiestas", "neon_decor")
    ]
    
    print("Generando imágenes de placeholder para productos...")
    
    for product_name, category, filename in products:
        output_path = os.path.join(output_dir, f"{filename}.png")
        create_placeholder_image(product_name, category, output_path)
    
    print(f"\nSe generaron {len(products)} imágenes en {output_dir}")
    print("\nPara usar estas imágenes:")
    print("1. Arrastra las imágenes a Assets.xcassets en Xcode")
    print("2. Crea Image Sets con los nombres correspondientes")
    print("3. Las imágenes se cargarán automáticamente en la app")

if __name__ == "__main__":
    main() 