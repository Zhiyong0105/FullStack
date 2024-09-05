//
//  UserViewModel.swift
//  Frontend
//
//  Created by ZhiYong Peng on 2024/09/05.
//

import SwiftUI
import Foundation
struct UserCreate:Codable {
    let email: String
    
}
class UserView :ObservableObject{
    @Published var email: String = ""
    func createUser(){
        guard let url = URL(string: "http://localhost:8000/users/") else{
            print("Invalid URL")
            return
        }
        let user = UserCreate(email: email)
        guard let encoded = try? JSONEncoder().encode(user) else {
            print("Failed to encode user")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encoded
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending request: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                print("User created successfully")
            } else {
                print("Failed to create user")
            }
        }.resume()
    }
}
