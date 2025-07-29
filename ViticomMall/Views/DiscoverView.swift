import SwiftUI

struct ProductImageView: View {
    let imageName: String
    let systemIcon: String
    let size: CGFloat
    
    var body: some View {
        Group {
            // Intentar cargar imagen real primero
            if let _ = UIImage(named: imageName) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipped()
            } else {
                // Fallback a icono del sistema
                Image(systemName: systemIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.6, height: size * 0.6)
                    .foregroundColor(.purple)
            }
        }
    }
}

struct DiscoverView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    @State private var selectedSort = "Popular"
    @State private var showFilters = false
    
    let categories = ["All", "Cumpleaños", "Bodas", "Graduaciones", "Baby Shower", "Fiestas", "Decoración", "Iluminación"]
    let sortOptions = ["Popular", "Price: Low to High", "Price: High to Low", "Newest", "Rating"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                SearchBarView()
                
                // Filters
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(categories, id: \.self) { category in
                                CategoryChip(
                                    title: category,
                                    isSelected: selectedCategory == category
                                ) {
                                    selectedCategory = category
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Button(action: { showFilters.toggle() }) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.vertical, 8)
                
                // Sort options
                HStack {
                    Text("Sort by:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Picker("Sort", selection: $selectedSort) {
                        ForEach(sortOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                
                // Products grid
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                        ForEach(discoverProducts) { product in
                            DiscoverProductCard(product: product)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct DiscoverProductCard: View {
    let product: DiscoverProduct
    @State private var isFavorite = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .frame(height: 150)
                
                ProductImageView(
                    imageName: product.imageName,
                    systemIcon: product.systemIcon,
                    size: 60
                )
                
                Button(action: { isFavorite.toggle() }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .font(.title3)
                        .padding(8)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            Text(product.name)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(2)
            
            HStack {
                Text("$\(String(format: "%.2f", product.price))")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Spacer()
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    Text(String(format: "%.1f", product.rating))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct DiscoverProduct: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String // Nombre de la imagen en Assets
    let systemIcon: String // Icono del sistema como fallback
    let price: Double
    let rating: Double
    let category: String
}

let discoverProducts: [DiscoverProduct] = [
    DiscoverProduct(name: "Kit Decoración Cumpleaños Premium", imageName: "birthday_kit", systemIcon: "balloon.2.fill", price: 45.00, rating: 4.8, category: "Cumpleaños"),
    DiscoverProduct(name: "Centro de Mesa Boda Elegante", imageName: "wedding_centerpiece", systemIcon: "heart.circle.fill", price: 65.00, rating: 4.9, category: "Bodas"),
    DiscoverProduct(name: "Gorra Graduación Personalizada", imageName: "graduation_cap", systemIcon: "graduationcap.fill", price: 25.00, rating: 4.7, category: "Graduaciones"),
    DiscoverProduct(name: "Set Baby Shower Completo", imageName: "baby_shower_set", systemIcon: "gift.fill", price: 75.00, rating: 4.6, category: "Baby Shower"),
    DiscoverProduct(name: "Luces LED RGB Fiesta", imageName: "led_lights", systemIcon: "sparkles", price: 35.00, rating: 4.5, category: "Iluminación"),
    DiscoverProduct(name: "Globos Metálicos Premium", imageName: "metallic_balloons", systemIcon: "balloon.fill", price: 30.00, rating: 4.4, category: "Decoración"),
    DiscoverProduct(name: "Velo de Novia Lujoso", imageName: "wedding_veil", systemIcon: "heart.fill", price: 120.00, rating: 4.9, category: "Bodas"),
    DiscoverProduct(name: "Toga Graduación Profesional", imageName: "graduation_gown", systemIcon: "graduationcap", price: 45.00, rating: 4.8, category: "Graduaciones"),
    DiscoverProduct(name: "Kit Fiesta Temática", imageName: "party_kit", systemIcon: "party.popper", price: 55.00, rating: 4.7, category: "Fiestas"),
    DiscoverProduct(name: "Decoración Baby Shower Rosa", imageName: "baby_shower_pink", systemIcon: "gift.circle", price: 40.00, rating: 4.6, category: "Baby Shower")
] 