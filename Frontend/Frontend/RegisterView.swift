//
//  RegisterView.swift
//  Frontend
//
//  Created by ZhiYong Peng on 2024/09/08.
//

import SwiftUI

struct RegisterView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isLoading = false
    @State private var showMessage = false
    @State private var message = ""
    @StateObject private var SignUpModel = UserSignUp()


    var body: some View {
        VStack(spacing: 30, content: {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom,40)
            
            InputField(icon: "person", placeholder: "Name", text: $SignUpModel.displayed_name)
            
            InputField(icon: "envelope", placeholder: "Email", text: $SignUpModel.email)
            
            PassowordView(title: "Password", text: $SignUpModel.password)
            
            PassowordView(title: "ConfirmPassword", text: $confirmPassword)
            
            SignUpButton(action: {
                SignUpModel.UserSignup()
            })

            
            
        })

    }
}
struct SignUpButton :View {
    var action :() ->Void
    var body: some View {
        Button(action: action) {
            Text("Sign Up")
                .fontWeight(.bold)
                .frame(width: 150)
                .padding()
                .foregroundStyle(.white)
                .background(Color.orange)
                .cornerRadius(15)
        }
    }
}
struct InputField:View {
    var icon : String
    var placeholder : String
    @Binding var text:String
    var isSecure=false
    var body: some View {
        HStack{
            Image(systemName: icon)
                .foregroundStyle(.gray)
            if isSecure{
                SecureField(placeholder,text: $text)
            }else{
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 15))

        .cornerRadius(10)
    }
}
#Preview {
    RegisterView()
}
