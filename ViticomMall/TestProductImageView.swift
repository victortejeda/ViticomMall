import SwiftUI

// Archivo de prueba para verificar ProductImageView
struct TestProductImageView: View {
    var body: some View {
        VStack {
            ProductImageView(
                imageName: "test_image",
                systemIcon: "star.fill",
                size: 100
            )
            
            Text("Test ProductImageView")
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    TestProductImageView()
} 