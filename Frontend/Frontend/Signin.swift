//
//  Signin.swift
//  Frontend
//
//  Created by ZhiYong Peng on 2024/09/02.
//

import SwiftUI

struct Signin: View {
    @State var isActive = false
    @State var email = ""
    @State var password = ""
    @State var showButton = false

    var body: some View {
        VStack(spacing:30){
            InfoView(title:"Email",text:$email)
            PassowordView(title: "Password", text: $password)
            SiginButton(isSiginButton: $showButton)
//            OrView(title: "or")
            
            HStack(spacing:65){
                SignAccount(image: "applelogo", width: 32, height: 32, action: {})
                SignAccount(image: "envelope", width: 32, height: 32, action: {})
                SignAccount(image: "globe", width: 32, height: 32, action: {})
                
            }
        
            
        }
       
    }
}

struct InfoView:View {
    var title :String
    @Binding var text :String
    @State var email = ""
    @FocusState var isActive
    var body: some View {
        ZStack(alignment:.leading){
            TextField("", text: $text)
                .padding(.leading)
                .frame(maxWidth:.infinity)
                .frame(height: 55).focused($isActive)
                .background(.gray.opacity(0.3),in:.rect(cornerRadius: 16))
            Text(title)
                .padding(.leading)
                .offset(y:isActive || !text.isEmpty ? -50 : 0)
                .foregroundColor(isActive ? .black : .secondary)
                .animation(.spring, value: isActive)
                .onTapGesture {
                    isActive = true
                }
            
                
            
        }
    }
}

struct PassowordView :View {
    var title :String
    @Binding var text:String
    @FocusState var isActive
    @State var showPassword = false
    var body: some View {
        ZStack(alignment:.leading){
            SecureField("",text: $text)
                .padding(.leading)
                .frame(maxWidth:.infinity)
                .frame(height: 55).focused($isActive)
                .background(.gray.opacity(0.3),in:.rect(cornerRadius: 16))
                .opacity(showPassword ? 0 : 1)
            
            TextField("", text: $text)
                .padding(.leading)
                .frame(maxWidth:.infinity)
                .frame(height: 55).focused($isActive)
                .background(.gray.opacity(0.3),in:.rect(cornerRadius: 16))
                .opacity(showPassword ? 1 : 0)
            Text(title)
                .padding(.leading)
                .offset(y:isActive || !text.isEmpty ? -50 : 0)
                .foregroundColor(isActive ? .black : .secondary)
                .animation(.spring, value: isActive)
                .onTapGesture {
                    isActive = true
                }

                }
        .overlay(alignment:.trailing){
            Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                .padding(16)
                .contentShape(Rectangle())
                .foregroundColor(showPassword ? .primary : .secondary)
                .onTapGesture {
                    showPassword.toggle()
                }
            
                
            
        }
    }
}
struct SiginButton:View {
    @Binding var isSiginButton :Bool
    var body: some View {
        Button {
            isSiginButton.toggle()
        } label: {
            Text("Sign In")
                .foregroundStyle(.blue)
                .font(.title.bold())
                .frame(maxWidth:.infinity)
                .frame(height: 55)
                .background(.primary,in: .rect(cornerRadius: 50))
                .padding([.leading,.trailing],20)
        }
        .tint(.primary)

    }
}

//struct OrView:View {
//    var title :String
//    var body: some View {
//        HStack{
//            Rectangle()
//                .frame(height:1.5)
//                .foregroundStyle(.gray.opacity(0.3))
//            Text(title)
//            Rectangle()
//                .frame(height: 1.5)
//                .foregroundStyle(.gray.opacity(0.3))
//            
//            
//        }
//    }
//}

struct SignAccount: View {
    var image:String
    var width:CGFloat
    var height:CGFloat
    var action:()->Void
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .renderingMode(.template)
                .resizable().scaledToFit()
                .frame(width: width,height: height)
                .overlay{
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1.5)
                        .frame(width: 50,height: 50)
                        .foregroundStyle(.black.opacity(0.3))
                }
        }
        .tint(.primary)
    }
}

#Preview {
    Signin()
}
