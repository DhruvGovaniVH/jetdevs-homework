//
//  LoginRepo.swift
//  JetDevsHomeWork
//
//  Created by Admin on 07/12/22.
//

import Foundation

class LoginRepo {
    
    private var apiClient = APIClient()
    
    func loginUser(email: String, password: String, onSuccess: @escaping ((User?) -> Void), onFailure: @escaping ((String?) -> Void)) {
        
        let params: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        apiClient.POSTData(withParams: params, onService: "login") { result in
            
            switch result {
                
            case .success(let response):
                
                guard let response = response else {
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(Response<UserData>.self, from: response)
                    if decodedResponse.result == 1 {
                        onSuccess(decodedResponse.data?.user)
                    } else {
                        onFailure(decodedResponse.errorMessage)
                    }
                    
                } catch {
                    print(error)
                    onFailure("Your email or password is incorrect.")
                }
            case .failure(let error):
                onFailure(error.errorMessage)
            }
        }
    }
}
