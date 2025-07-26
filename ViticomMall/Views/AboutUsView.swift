import SwiftUI

struct AboutUsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 16) {
                        Image(systemName: "building.2.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.purple)
                        
                        Text("VitiMall Eventos")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Tu tienda de confianza para todos los eventos especiales")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Mission
                    VStack(spacing: 16) {
                        Text("Nuestra Misión")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("En VitiMall Eventos, nos dedicamos a hacer que cada celebración sea inolvidable. Ofrecemos productos de alta calidad para cumpleaños, bodas, graduaciones, baby showers y todo tipo de eventos especiales.")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    
                    // Stats
                    HStack(spacing: 40) {
                        StatItem(number: "10K+", label: "Clientes Satisfechos")
                        StatItem(number: "50K+", label: "Productos Vendidos")
                        StatItem(number: "5+", label: "Años de Experiencia")
                    }
                    .padding(.horizontal, 20)
                    
                    // Values
                    VStack(spacing: 20) {
                        Text("Nuestros Valores")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 16) {
                            ValueCard(
                                icon: "star.fill",
                                title: "Calidad Premium",
                                description: "Solo ofrecemos productos de la más alta calidad"
                            )
                            
                            ValueCard(
                                icon: "heart.fill",
                                title: "Atención Personalizada",
                                description: "Cada cliente es especial para nosotros"
                            )
                            
                            ValueCard(
                                icon: "truck.fill",
                                title: "Entrega Rápida",
                                description: "Garantizamos entregas puntuales y seguras"
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Team
                    VStack(spacing: 20) {
                        Text("Nuestro Equipo")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 16) {
                            TeamMemberCard(
                                name: "María González",
                                role: "CEO & Fundadora",
                                description: "Apasionada por crear experiencias inolvidables"
                            )
                            
                            TeamMemberCard(
                                name: "Carlos Rodríguez",
                                role: "Director de Operaciones",
                                description: "Experto en logística y atención al cliente"
                            )
                            
                            TeamMemberCard(
                                name: "Ana Martínez",
                                role: "Diseñadora de Productos",
                                description: "Creadora de decoraciones únicas y elegantes"
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Contact
                    VStack(spacing: 16) {
                        Text("Contáctanos")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 12) {
                            ContactItem(icon: "envelope", text: "info@vitimall.com")
                            ContactItem(icon: "phone", text: "+1 (555) 123-4567")
                            ContactItem(icon: "location", text: "123 Event Street, Party City")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("About Us")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct StatItem: View {
    let number: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(number)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.purple)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
    }
}

struct ValueCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.purple)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct TeamMemberCard: View {
    let name: String
    let role: String
    let description: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.purple)
            
            VStack(spacing: 4) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(role)
                    .font(.caption)
                    .foregroundColor(.purple)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(16)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct ContactItem: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.purple)
                .frame(width: 20)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
} 