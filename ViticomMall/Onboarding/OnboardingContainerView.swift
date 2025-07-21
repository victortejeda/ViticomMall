import SwiftUI

/// Vista que contiene el flujo de Onboarding con varias pantallas
struct OnboardingContainerView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var selectedTab = 0
    private let onboardingItems: [OnboardingItem] = [
        .init(imageName: "sparkles", title: "¡Bienvenido a VitiMall!", description: "Tu destino para encontrar todo lo que necesitas, con un toque de magia.", color: .purple),
        .init(imageName: "tag.fill", title: "Ofertas que te Encantarán", description: "Activa las notificaciones para ser el primero en conocer descuentos exclusivos.", color: .orange),
        .init(imageName: "creditcard.fill", title: "Compra con Confianza", description: "Disfruta de un proceso de pago rápido, fácil y 100% seguro.", color: .blue),
        .init(imageName: "shippingbox.fill", title: "Recíbelo en tu Puerta", description: "Seguimiento en tiempo real para que sepas exactamente cuándo llegará tu pedido.", color: .green)
    ]
    var body: some View {
        ZStack {
            onboardingItems[selectedTab].color.ignoresSafeArea()
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(0..<onboardingItems.count, id: \.self) { index in
                        OnboardingScreenView(item: onboardingItems[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .animation(.easeInOut(duration: 0.5), value: selectedTab)
                if selectedTab == onboardingItems.count - 1 {
                    Button(action: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) {
                            hasCompletedOnboarding = true
                        }
                    }) {
                        Text("¡Empezar!")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .transition(.slide)
    }
} 