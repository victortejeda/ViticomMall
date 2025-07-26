import SwiftUI

class CartManager: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var favorites: [String] = []
    
    var totalItems: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Double {
        cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    func addToCart(_ product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func removeFromCart(_ product: Product) {
        cartItems.removeAll { $0.product.id == product.id }
    }
    
    func updateQuantity(for product: Product, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            if quantity <= 0 {
                cartItems.remove(at: index)
            } else {
                cartItems[index].quantity = quantity
            }
        }
    }
    
    func toggleFavorite(_ productId: String) {
        if favorites.contains(productId) {
            favorites.removeAll { $0 == productId }
        } else {
            favorites.append(productId)
        }
    }
    
    func isFavorite(_ productId: String) -> Bool {
        favorites.contains(productId)
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
} 