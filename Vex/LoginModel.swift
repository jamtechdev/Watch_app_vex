//
//  LoginModel.swift
//  Vex
//
//  Created by Digvijay Ghildiyal on 12/12/22.
//

import Foundation
import SwiftUI

struct LoginModel:Codable{
	var firstName : String
	var lastName : String
	var gym : [GymDetails]
}

struct GymDetails:Codable{
	var name:String
}

class LoginApi{
	func authenticateUser (email:String,password:String,userRole:String,deviceType:String,completion: @escaping () -> ()) {
		guard let url = URL(string:
								"https://qd3buoh9zb.execute-api.us-west-1.amazonaws.com/staging/login") else { return }
		var request = URLRequest(url: url)
		let params = ["email":email, "password":password, "userRole":userRole, "deviceType":deviceType]
		request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
		request.httpMethod = "POST"
		request.addValue("application/json", forHTTPHeaderField: "content-type")
//		let session = URLSession.shared
		URLSession.shared.dataTask(with: request) { httpData, httpResponse, httpError in
			
			if httpData?.count ?? 0 > 0 && httpError == nil {
				// not error
				
				let strData = String(data: httpData!, encoding: .utf8)
				print("the confirmation code response", strData)
				
				do {
					let jsonData = try JSONSerialization.jsonObject(with: httpData!, options: .mutableContainers)
					print("the json DAta", jsonData)
                    
					if let data = jsonData as? [String : Any] {
						
						if let statusCode = data["statusCode"] as? Int {
							
							if statusCode == 200 {
                                
                                if let jData = data["data"] as? [String:Any] {
                                    UserDefaults.standard.set(jData["token"] as? String, forKey: "TerraToken")
                                    completion()
                                }
                                
//
							} else{
								completion()
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
				completion()
			}
			
		}.resume()
	}
}
