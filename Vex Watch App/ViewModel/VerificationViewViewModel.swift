//
//  VerificationViewViewModel.swift
//  VexWatch Watch App
//
//  Created by Jamtech 01 on 08/12/22.
//

import Foundation

//enum ApiAndCodeStatus : String {
//    case serverError = "ServerError"
//    case
//}

class VerificationViewModel : ObservableObject {
    
    @Published var isStatusSuccess : Bool = false
    @Published var status : String = ""
    @Published var otpErrorMessage : String = ""
    @Published var isOtpMatched : Bool = false
    
    func checkingVerificationCode(otp : Int, complitionHandler : @escaping(_ status : String, _ otpMsg : String, _ token : String?) -> Void) {
        
        let params = ["pin": otp]
        
        print("The parameters", params)
        
        var urlRequest = URLRequest(url: URL(string: "https://o5dgnltzhf.execute-api.us-west-1.amazonaws.com/staging/v1/authorizeClassCode")!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        urlRequest.allHTTPHeaderFields = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjM2Y2E4MzVlZTQyZjkwMDA4ODczY2E0IiwiZW1haWwiOiJ0ZXN0KzExQHlvcG1haWwuY29tIiwidXNlclJvbGUiOiJ1c2VyIiwiaWF0IjoxNjcwMzA4MTU5fQ.0XHH1F82UqiuJOIAGaE7zvX28kcpAT83-PKlFMOULJ8"]
        
        URLSession.shared.dataTask(with: urlRequest) { httpData, httpResponse, httpError in
            
            if httpData?.count ?? 0 > 0 && httpError == nil {
                // not error
                
                let strData = String(data: httpData!, encoding: .utf8)
                print("the confirmation code response", strData)
                
                self.status = "Success"
                
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: httpData!, options: .mutableContainers)
                    print("The OTP Json data", jsonData)
                    
                    if let data = jsonData as? [String : Any] {
                        
                        if let statusCode = data["statusCode"] as? Int {
                            
                            if statusCode == 200 {
                                self.otpErrorMessage = "pin confirmed"
                                
                                if let jData = data["data"] as? [String:Any] {
                                    
                                    if let tokenObject = jData["token_obj"] as? [String:Any] {
                                        
                                        let token = tokenObject["token"] as? String
                                        print("the token", token)
                                        
                                        complitionHandler(self.status, self.otpErrorMessage, token)
                                    }
                                    
                                }
                                
                            } else if statusCode == 400 {
                                self.otpErrorMessage = "No class found for today with this pin!"
                                complitionHandler(self.status, self.otpErrorMessage, nil)
                            }
                            
                            
                        } else {
                            print("Status code else")
                        }
                        
                    } else {
                        print("json else")
                    }
                    
                 
                    
                    
                } catch {
                    print("the catch error occured", error.localizedDescription)
                }
                
                
                
                
            } else {
                // error occured
                print("Error occured",httpError)
                self.status = "Failed"
                complitionHandler(self.status, self.otpErrorMessage, nil)
            }
            
        }.resume()
        
    }
    
}
