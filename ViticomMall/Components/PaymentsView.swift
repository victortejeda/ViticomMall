import SwiftUI

struct PaymentsView: View {
    @State private var selectedPaymentMethod: PaymentMethod = .visa
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Payment Method")
                .font(.headline)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                ForEach(PaymentMethod.allCases, id: \.self) { method in
                    PaymentMethodCard(
                        method: method,
                        isSelected: selectedPaymentMethod == method
                    ) {
                        selectedPaymentMethod = method
                    }
                }
            }
        }
        .padding(16)
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

enum PaymentMethod: CaseIterable {
    case visa
    case mastercard
    case paypal
    case applePay
    
    var name: String {
        switch self {
        case .visa: return "Visa"
        case .mastercard: return "Mastercard"
        case .paypal: return "PayPal"
        case .applePay: return "Apple Pay"
        }
    }
    
    var icon: String {
        switch self {
        case .visa: return "creditcard.fill"
        case .mastercard: return "creditcard.fill"
        case .paypal: return "p.circle.fill"
        case .applePay: return "applelogo"
        }
    }
    
    var color: Color {
        switch self {
        case .visa: return .blue
        case .mastercard: return .orange
        case .paypal: return .blue
        case .applePay: return .black
        }
    }
}

struct PaymentMethodCard: View {
    let method: PaymentMethod
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: method.icon)
                    .foregroundColor(method.color)
                    .font(.title2)
                
                Text(method.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title3)
                }
            }
            .padding(12)
            .background(isSelected ? Color.blue.opacity(0.1) : Color(.systemGray5))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
    }
} 