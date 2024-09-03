//
//  HomeView.swift
//  Frontend
//
//  Created by ZhiYong Peng on 2024/09/03.
//

import SwiftUI

struct HomeView: View {
    @State var showSignin = false
    var body: some View {
        ZStack{
            VStack{
                Text("HomeScreen")
                Button {
                    showSignin.toggle()
                } label: {
                    Text("Sign in")
                        .font(.title)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

            }
            .blur(radius: showSignin ? 100 : 0)
            if showSignin{
                Signin(showSignin: $showSignin)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                   
            }

        }
        .animation(.spring, value:  showSignin)
        

        
    }
}

#Preview {
    HomeView()
}
