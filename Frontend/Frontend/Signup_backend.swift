//
//  Signup_backend.swift
//  Frontend
//
//  Created by ZhiYong Peng on 2024/09/08.
//

import SwiftUI
import Foundation

struct UserSignUpInfo:Codable {
    let email: String
    let displayed_name: String
    let password: String
    
}

class UserSignUp : ObservableObject{
    @Published var email: String = ""
    @Published var displayed_name: String = ""
    @Published var password: String = ""
    
    func UserSignup(){
        guard let url =  URL(string: "http://localhost:8000/register/") else{
            print("Invalid URL")
            return
        }
        let user = UserSignUpInfo(email: email,displayed_name:displayed_name,password:password)
        guard let encoded = try? JSONEncoder().encode(user) else{
            print("Failed to encode user data")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encoded
        URLSession.shared.dataTask(with: request){data,response,error in
            if let error = error {
                           print("Error: \(error.localizedDescription)")
                           return
        }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("User registered successfully")
            } else {
                print("Failed to register user")
            }
        }.resume()
    }
}

