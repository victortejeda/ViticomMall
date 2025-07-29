import SwiftUI

struct ProductImageView: View {
    let imageName: String
    let systemIcon: String
    let size: CGFloat
    let cornerRadius: CGFloat
    @State private var loadedImage: UIImage?
    @State private var isLoading = false
    @State private var hasError = false
    
    init(imageName: String, systemIcon: String, size: CGFloat, cornerRadius: CGFloat = 0) {
        self.imageName = imageName
        self.systemIcon = systemIcon
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        Group {
            if let loadedImage = loadedImage {
                // Imagen cargada desde URL
                Image(uiImage: loadedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipped()
                    .cornerRadius(cornerRadius)
                    .transition(.opacity)
            } else if let localImage = UIImage(named: imageName) {
                // Imagen local en Assets
                Image(uiImage: localImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipped()
                    .cornerRadius(cornerRadius)
            } else {
                // Fallback a icono del sistema
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color(.systemGray5))
                        .frame(width: size, height: size)
                    
                    if isLoading {
                        VStack(spacing: 8) {
                            ProgressView()
                                .scaleEffect(0.8)
                            Text("Cargando...")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    } else if hasError {
                        VStack(spacing: 4) {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.orange)
                                .font(.title2)
                            Text("Error")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    } else {
                        Image(systemName: systemIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: size * 0.5, height: size * 0.5)
                            .foregroundColor(.purple)
                    }
                }
            }
        }
        .onAppear {
            loadImageFromURL()
        }
        .animation(.easeInOut(duration: 0.3), value: loadedImage)
        .animation(.easeInOut(duration: 0.3), value: isLoading)
        .animation(.easeInOut(duration: 0.3), value: hasError)
    }
    
    private func loadImageFromURL() {
        // Solo cargar si no tenemos imagen local
        guard UIImage(named: imageName) == nil else { return }
        
        isLoading = true
        hasError = false
        
        Task {
            if let urlString = ProductImages.getImageURL(for: imageName) {
                if let image = await ProductImages.downloadImage(from: urlString) {
                    await MainActor.run {
                        self.loadedImage = image
                        self.isLoading = false
                        self.hasError = false
                    }
                } else {
                    await MainActor.run {
                        self.isLoading = false
                        self.hasError = true
                    }
                }
            } else {
                await MainActor.run {
                    self.isLoading = false
                    self.hasError = true
                }
            }
        }
    }
}

// Extensión para crear imágenes con diferentes estilos
extension ProductImageView {
    static func circular(imageName: String, systemIcon: String, size: CGFloat) -> ProductImageView {
        ProductImageView(imageName: imageName, systemIcon: systemIcon, size: size, cornerRadius: size / 2)
    }
    
    static func rounded(imageName: String, systemIcon: String, size: CGFloat, cornerRadius: CGFloat = 8) -> ProductImageView {
        ProductImageView(imageName: imageName, systemIcon: systemIcon, size: size, cornerRadius: cornerRadius)
    }
}

// Componente para mostrar imágenes con placeholder mientras cargan
struct AsyncProductImageView: View {
    let imageName: String
    let systemIcon: String
    let size: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        ProductImageView(
            imageName: imageName,
            systemIcon: systemIcon,
            size: size,
            cornerRadius: cornerRadius
        )
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.3), value: true)
    }
}

// Componente de prueba para verificar que las imágenes funcionan
struct ProductImageTestView: View {
    @State private var testResults: [String: String] = [:]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                ForEach(Array(ProductImages.imageURLs.keys), id: \.self) { imageName in
                    VStack {
                        ProductImageView(
                            imageName: imageName,
                            systemIcon: "star.fill",
                            size: 100,
                            cornerRadius: 12
                        )
                        Text(imageName)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                        if let result = testResults[imageName] {
                            Text(result)
                                .font(.caption2)
                                .foregroundColor(result == "✅" ? .green : .red)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Test de Imágenes")
        .onAppear {
            testImageLoading()
        }
    }
    
    private func testImageLoading() {
        for imageName in ProductImages.imageURLs.keys {
            Task {
                if let urlString = ProductImages.getImageURL(for: imageName) {
                    if let _ = await ProductImages.downloadImage(from: urlString) {
                        await MainActor.run {
                            testResults[imageName] = "✅"
                        }
                    } else {
                        await MainActor.run {
                            testResults[imageName] = "❌"
                        }
                    }
                } else {
                    await MainActor.run {
                        testResults[imageName] = "❌"
                    }
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ProductImageView(imageName: "birthday_kit", systemIcon: "balloon.2.fill", size: 100)
        ProductImageView.circular(imageName: "wedding_centerpiece", systemIcon: "heart.circle.fill", size: 80)
        ProductImageView.rounded(imageName: "baby_shower_set", systemIcon: "gift.fill", size: 120, cornerRadius: 16)
        AsyncProductImageView(imageName: "led_lights", systemIcon: "sparkles", size: 90, cornerRadius: 12)
    }
    .padding()
} 