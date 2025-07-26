import SwiftUI

struct ProfileFormView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var address = ""
    @State private var city = ""
    @State private var zipCode = ""
    @State private var country = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Personal Information
                VStack(alignment: .leading, spacing: 16) {
                    Text("Personal Information")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    FormField(title: "Full Name", text: $fullName, placeholder: "Enter your full name")
                    FormField(title: "Email", text: $email, placeholder: "Enter your email", keyboardType: .emailAddress)
                    FormField(title: "Phone", text: $phone, placeholder: "Enter your phone number", keyboardType: .phonePad)
                }
                
                // Address Information
                VStack(alignment: .leading, spacing: 16) {
                    Text("Address Information")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    FormField(title: "Address", text: $address, placeholder: "Enter your address")
                    FormField(title: "City", text: $city, placeholder: "Enter your city")
                    FormField(title: "ZIP Code", text: $zipCode, placeholder: "Enter ZIP code", keyboardType: .numberPad)
                    FormField(title: "Country", text: $country, placeholder: "Enter your country")
                }
                
                // Save Button
                Button(action: {
                    // Save profile information
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.top, 16)
            }
            .padding(20)
        }
    }
}

struct FormField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }
} 