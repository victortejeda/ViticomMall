import SwiftUI

struct SidebarView: View {
    @AppStorage("loggedUser") var loggedUser: String = "Sunie Pham"
    @AppStorage("userEmail") var userEmail: String = "suniexx@gmail.com"
    @State private var selected: String = "Homepage"
    @State private var isLightMode: Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Perfil
            HStack(spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 56, height: 56)
                    .foregroundColor(.purple)
                VStack(alignment: .leading, spacing: 4) {
                    Text(loggedUser)
                        .font(.headline)
                    Text(userEmail)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 32)
            .padding(.bottom, 24)
            .padding(.horizontal)
            // Navegación principal
            Group {
                SidebarItem(icon: "house.fill", label: "Homepage", selected: $selected)
                SidebarItem(icon: "magnifyingglass", label: "Discover", selected: $selected)
                SidebarItem(icon: "bag", label: "My Order", selected: $selected)
                SidebarItem(icon: "person", label: "My profile", selected: $selected)
            }
            .padding(.horizontal)
            // Otros
            Text("OTHER")
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(.top, 24)
                .padding(.horizontal)
            Group {
                SidebarItem(icon: "gearshape", label: "Setting", selected: $selected)
                SidebarItem(icon: "envelope", label: "Support", selected: $selected)
                SidebarItem(icon: "info.circle", label: "About us", selected: $selected)
            }
            .padding(.horizontal)
            Spacer()
            // Selector de modo claro/oscuro
            HStack {
                Button(action: { isLightMode = true }) {
                    HStack {
                        Image(systemName: "sun.max.fill")
                        Text("Light")
                    }
                    .padding(8)
                    .background(isLightMode ? Color(.systemGray5) : Color.clear)
                    .cornerRadius(20)
                }
                .foregroundColor(isLightMode ? .black : .gray)
                Button(action: { isLightMode = false }) {
                    HStack {
                        Image(systemName: "moon.fill")
                        Text("Dark")
                    }
                    .padding(8)
                    .background(!isLightMode ? Color(.systemGray5) : Color.clear)
                    .cornerRadius(20)
                }
                .foregroundColor(!isLightMode ? .black : .gray)
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: 300)
        .background(Color(.systemGray6))
        .cornerRadius(28, corners: [.topRight, .bottomRight])
        .shadow(radius: 4)
    }
}

struct SidebarItem: View {
    let icon: String
    let label: String
    @Binding var selected: String
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(selected == label ? .blue : .gray)
            Text(label)
                .fontWeight(selected == label ? .bold : .regular)
                .foregroundColor(selected == label ? .blue : .gray)
            Spacer()
        }
        .padding(12)
        .background(selected == label ? Color(.systemGray5) : Color.clear)
        .cornerRadius(12)
        .onTapGesture {
            selected = label
        }
    }
}

// Para esquinas específicas
fileprivate extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

fileprivate struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
} 