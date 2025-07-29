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

struct CartView: View {
    @ObservedObject var cartManager: CartManager
    @State private var showCheckout = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if cartManager.cartItems.isEmpty {
                    EmptyCartView()
                } else {
                    VStack(spacing: 0) {
                        // Cart items
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(cartManager.cartItems) { item in
                                    CartItemRow(
                                        item: item,
                                        cartManager: cartManager
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                        }
                        
                        // Checkout section
                        VStack(spacing: 16) {
                            // Summary
                            VStack(spacing: 12) {
                                HStack {
                                    Text("Subtotal")
                                    Spacer()
                                    Text("$\(String(format: "%.2f", cartManager.totalPrice))")
                                }
                                
                                HStack {
                                    Text("Shipping")
                                    Spacer()
                                    Text("Free")
                                        .foregroundColor(.green)
                                }
                                
                                Divider()
                                
                                HStack {
                                    Text("Total")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text("$\(String(format: "%.2f", cartManager.totalPrice))")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            // Checkout button
                            Button(action: { showCheckout = true }) {
                                HStack {
                                    Text("Proceed to Checkout")
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Text("$\(String(format: "%.2f", cartManager.totalPrice))")
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.white)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 20)
                                .background(Color.blue)
                                .cornerRadius(12)
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        }
                        .background(Color(.systemGray6))
                    }
                }
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Button("Clear") {
                cartManager.clearCart()
            })
            .sheet(isPresented: $showCheckout) {
                CheckoutView(cartManager: cartManager)
            }
        }
    }
}

struct CartItemRow: View {
    let item: CartItem
    @ObservedObject var cartManager: CartManager
    
    var body: some View {
        HStack(spacing: 12) {
            // Product image
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray6))
                    .frame(width: 80, height: 80)
                
                ProductImageView(
                    imageName: item.product.imageName,
                    systemIcon: item.product.systemIcon,
                    size: 40
                )
            }
            
            // Product details
            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(2)
                
                Text("$\(String(format: "%.2f", item.product.price))")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            // Quantity controls
            VStack(spacing: 8) {
                Button(action: {
                    cartManager.updateQuantity(for: item.product, quantity: item.quantity + 1)
                }) {
                    Image(systemName: "plus")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .frame(width: 24, height: 24)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Circle())
                }
                
                Text("\(item.quantity)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(minWidth: 20)
                
                Button(action: {
                    cartManager.updateQuantity(for: item.product, quantity: item.quantity - 1)
                }) {
                    Image(systemName: "minus")
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(width: 24, height: 24)
                        .background(Color.red.opacity(0.1))
                        .clipShape(Circle())
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct EmptyCartView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Your cart is empty")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Add some products to get started!")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CheckoutView: View {
    @ObservedObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode
    @State private var showingPaymentMethods = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Order summary
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Order Summary")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        ForEach(cartManager.cartItems) { item in
                            HStack {
                                Text(item.product.name)
                                    .lineLimit(1)
                                Spacer()
                                Text("\(item.quantity)x")
                                    .foregroundColor(.gray)
                                Text("$\(String(format: "%.2f", item.product.price * Double(item.quantity)))")
                                    .fontWeight(.medium)
                            }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Total")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("$\(String(format: "%.2f", cartManager.totalPrice))")
                                .fontWeight(.semibold)
                                .font(.title3)
                        }
                    }
                    .padding(20)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Payment methods
                    PaymentsView()
                    
                    // Place order button
                    Button(action: {
                        // Place order logic
                        cartManager.clearCart()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Place Order")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
} 