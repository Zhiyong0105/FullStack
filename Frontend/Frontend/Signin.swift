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
    @State var Viewclose = false
    @Binding var showSignin : Bool
    @StateObject private var viewModel = UserView()


    var body: some View {
        VStack(spacing:60){
            ZStack {
                // Background Color and Rounded Corners
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
    //                .shadow(color: .green.opacity(0.2), radius: 10, x: 0, y: 5)

                VStack(spacing: 20) {
                    // Title
                    Text("Sign in")
                        .font(.largeTitle.bold())
                        .padding(.top, 20)

                    // Subtitle
                    Text("")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 30)

                    // Email Field
                    InfoView(title: "Email", text: $viewModel.email)
                    
                    // Password Field
                    PassowordView(title: "Password", text: $password)
                    
                    // Sign In Button
                    SiginButton(action: {
                        viewModel.createUser()
                    })
                    
                    // Social Login Options
                    OrView(title: "or")
                    HStack(spacing: 30) {
                        SignAccount(image: "envelope", width: 32, height: 32, action: {})
                        SignAccount(image: "applelogo", width: 32, height: 32, action: {})
                        SignAccount(image: "globe", width: 32, height: 32, action: {})
                    }
                    .padding(.bottom, 20)
                    Text("Register")
                    
                   
                }
                .padding(30)


            }
            .frame(width: 300,height: 500)
            .padding(20)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(30)
            .shadow(radius: 10)
            Button(action: {
                showSignin.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundStyle(.black.opacity(0.5))
                    .frame(width: 60,height: 60)
                    .background(Circle().fill(.white))
                    .shadow(radius: 5)
            })
        }
        


    }
}

struct InfoView: View {
    var title: String
    @Binding var text: String
    @FocusState private var isActive: Bool
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .padding(.leading, 40)
                .frame(maxWidth: .infinity, maxHeight: 55)
                .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 15))
                .focused($isActive)
                .overlay(
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.pink)
                            .padding(.leading, 10)
                        Spacer()
                    }
                )
            
            Text(title)
                .padding(.leading, 40)
                .offset(y: isActive || !text.isEmpty ? -35 : 0)
                .foregroundColor(isActive ? .black : .secondary)
                .animation(.spring(), value: isActive)
                .onTapGesture {
                    isActive = true
                }
        }
    }
}

struct PassowordView: View {
    var title: String
    @Binding var text: String
    @FocusState private var isActive: Bool
    @State private var showPassword = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            if showPassword {
                TextField("", text: $text)
                    .padding(.leading, 40)
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 15))
                    .focused($isActive)
            } else {
                SecureField("", text: $text)
                    .padding(.leading, 40)
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 15))
                    .focused($isActive)
            }
            
            Text(title)
                .padding(.leading, 40)
                .offset(y: isActive || !text.isEmpty ? -35 : 0)
                .foregroundColor(isActive ? .black : .secondary)
                .animation(.spring(), value: isActive)
                .onTapGesture {
                    isActive = true
                }
            
            // Password toggle button
            HStack {
                Spacer()
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                        .padding(.trailing, 10)
                        .foregroundColor(.secondary)
                }

            }

        }
    }
}
struct OrView:View {
    var title :String
    var body: some View {
        HStack{
            Rectangle()
                .frame(height:1.5)
                .foregroundStyle(.gray.opacity(0.3))
            Text(title)
            Rectangle()
                .frame(height: 1.5)
                .foregroundStyle(.gray.opacity(0.3))
            
            
        }
    }
}
struct SiginButton: View {
//    @Binding var isSiginButton: Bool
    let action: () -> Void
    
    var body: some View {
//        Button {
//            isSiginButton.toggle()
//        } label: {
//            
//        }
        Button(action: action, label: {
            Text("Sign In")
                .foregroundColor(.white)
                .font(.title2.bold())
                .frame(width: 150,height: 55)
                .background(Color.red.opacity(0.7))
                .cornerRadius(15)
                .padding(.horizontal)
        })
    }
}

struct SignAccount: View {
    var image: String
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .padding()
                .background(
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                )
                .foregroundColor(.primary)
        }
    }
}



#Preview {
   HomeView()
}
