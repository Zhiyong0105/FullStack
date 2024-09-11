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

struct CreateUserResponse:Codable{
    let message: String
    let user: UserSignUpInfo
}
struct ErrorResponse: Codable {
    let detail: String  // 后端返回的错误消息
}
class UserSignUp : ObservableObject{
    @Published var email: String = ""
    @Published var displayed_name: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var message: String?
    
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
            if let error = error{
                DispatchQueue.main.sync{
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do{
                            let decoded = try JSONDecoder().decode(CreateUserResponse.self, from: data)
                            DispatchQueue.main.sync{
                                self.message = decoded.message
                                self.errorMessage = nil
                            }
                        }catch{
                            DispatchQueue.main.async {
                                self.errorMessage = "Failed to decode success response"
                            }
                        }
                    }
                }
                if httpResponse.statusCode == 400{
                    if let data = data {
                        do{
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            DispatchQueue.main.sync{
                                self.message = errorResponse.detail
                                self.errorMessage = nil
                            }
                        }catch{
                            DispatchQueue.main.async {
                                self.errorMessage = "Failed to decode success response"
                            }
                        }
                    }
                }
            }

            
        }.resume()
    }
}
