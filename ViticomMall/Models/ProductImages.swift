import Foundation
import SwiftUI

// Configuración de imágenes de productos con URLs directas que funcionan
struct ProductImages {
    // URLs directas de Pexels (funcionan sin API key)
    static let imageURLs: [String: String] = [
        // Productos de Cumpleaños
        "birthday_kit": "https://images.pexels.com/photos/1464208/pexels-photo-1464208.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "metallic_balloons": "https://images.pexels.com/photos/157866/pexels-photo-157866.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "candy_table": "https://images.pexels.com/photos/1556909/pexels-photo-1556909.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        
        // Productos de Bodas
        "wedding_centerpiece": "https://images.pexels.com/photos/1519225/pexels-photo-1519225.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "wedding_veil": "https://images.pexels.com/photos/1519741/pexels-photo-1519741.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "decorative_pillows": "https://images.pexels.com/photos/1586023/pexels-photo-1586023.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "elegant_candles": "https://images.pexels.com/photos/1518709/pexels-photo-1518709.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        
        // Productos de Graduaciones
        "graduation_cap": "https://images.pexels.com/photos/1523050/pexels-photo-1523050.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "graduation_gown": "https://images.pexels.com/photos/1523050/pexels-photo-1523050.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "custom_diploma": "https://images.pexels.com/photos/1554224/pexels-photo-1554224.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "graduation_kit": "https://images.pexels.com/photos/1523050/pexels-photo-1523050.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        
        // Productos de Baby Shower
        "baby_shower_set": "https://images.pexels.com/photos/1556909/pexels-photo-1556909.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "baby_shower_pink": "https://images.pexels.com/photos/1556909/pexels-photo-1556909.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "balloon_bouquet": "https://images.pexels.com/photos/157866/pexels-photo-157866.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        
        // Productos de Fiestas
        "balloon_arch": "https://images.pexels.com/photos/157866/pexels-photo-157866.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "led_lights": "https://images.pexels.com/photos/1518709/pexels-photo-1518709.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "party_kit": "https://images.pexels.com/photos/1464208/pexels-photo-1464208.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop",
        "neon_decor": "https://images.pexels.com/photos/1518709/pexels-photo-1518709.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop"
    ]
    
    // Cache para imágenes descargadas
    static var imageCache: [String: UIImage] = [:]
    
    // Función para obtener URL de imagen
    static func getImageURL(for imageName: String) -> String? {
        return imageURLs[imageName]
    }
    
    // Función para descargar imagen desde URL
    static func downloadImage(from urlString: String) async -> UIImage? {
        // Verificar cache primero
        if let cachedImage = imageCache[urlString] {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                // Guardar en cache
                imageCache[urlString] = image
                return image
            }
        } catch {
            print("Error descargando imagen: \(error)")
        }
        
        return nil
    }
}

// Extensión para UIImage que permite cargar imágenes desde URLs
extension UIImage {
    static func loadFromURL(_ urlString: String) async -> UIImage? {
        return await ProductImages.downloadImage(from: urlString)
    }
} 