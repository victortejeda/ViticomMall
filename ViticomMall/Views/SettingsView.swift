import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") var isDarkMode = false
    @AppStorage("notificationsEnabled") var notificationsEnabled = true
    @AppStorage("biometricEnabled") var biometricEnabled = false
    @State private var showLanguagePicker = false
    @State private var selectedLanguage = "English"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Appearance
                    SettingsSection(title: "Appearance") {
                        SettingsToggleRow(
                            icon: isDarkMode ? "moon.fill" : "sun.max.fill",
                            title: "Dark Mode",
                            isOn: $isDarkMode
                        )
                    }
                    
                    // Notifications
                    SettingsSection(title: "Notifications") {
                        SettingsToggleRow(
                            icon: "bell",
                            title: "Push Notifications",
                            isOn: $notificationsEnabled
                        )
                        
                        SettingsToggleRow(
                            icon: "bell.badge",
                            title: "Order Updates",
                            isOn: $notificationsEnabled
                        )
                        
                        SettingsToggleRow(
                            icon: "megaphone",
                            title: "Promotional Offers",
                            isOn: .constant(false)
                        )
                    }
                    
                    // Security
                    SettingsSection(title: "Security") {
                        SettingsToggleRow(
                            icon: "faceid",
                            title: "Face ID / Touch ID",
                            isOn: $biometricEnabled
                        )
                        
                        SettingsRow(
                            icon: "lock",
                            title: "Change Password",
                            action: {}
                        )
                        
                        SettingsRow(
                            icon: "shield",
                            title: "Two-Factor Authentication",
                            action: {}
                        )
                    }
                    
                    // Language & Region
                    SettingsSection(title: "Language & Region") {
                        SettingsRow(
                            icon: "globe",
                            title: "Language",
                            subtitle: selectedLanguage,
                            action: { showLanguagePicker = true }
                        )
                        
                        SettingsRow(
                            icon: "location",
                            title: "Region",
                            subtitle: "United States",
                            action: {}
                        )
                    }
                    
                    // About
                    SettingsSection(title: "About") {
                        SettingsRow(
                            icon: "info.circle",
                            title: "App Version",
                            subtitle: "1.0.0",
                            action: {}
                        )
                        
                        SettingsRow(
                            icon: "doc.text",
                            title: "Terms of Service",
                            action: {}
                        )
                        
                        SettingsRow(
                            icon: "hand.raised",
                            title: "Privacy Policy",
                            action: {}
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showLanguagePicker) {
                LanguagePickerView(selectedLanguage: $selectedLanguage)
            }
        }
    }
}

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

struct SettingsToggleRow: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.purple)
                .frame(width: 24)
            
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    var subtitle: String?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.purple)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .foregroundColor(.primary)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
    }
}

struct LanguagePickerView: View {
    @Binding var selectedLanguage: String
    @Environment(\.presentationMode) var presentationMode
    
    let languages = ["English", "Spanish", "French", "German", "Italian"]
    
    var body: some View {
        NavigationView {
            List(languages, id: \.self) { language in
                Button(action: {
                    selectedLanguage = language
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text(language)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if selectedLanguage == language {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Select Language")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
} 