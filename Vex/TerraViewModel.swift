//
//  TerraViewModel.swift
//  Vex
//
//  Created by Jamtech 01 on 13/12/22.
//

import Foundation
import TerraRTiOS

class TerraViewModel : NSObject, ObservableObject {
    
    
    let terra : TerraRT? = nil
    @Published var token : String = ""
    
   
    let terraRt = TerraRT(devId: "vex-fitness-H64nqCttbC", referenceId: "f5491477daf64f44ce53489234d77cacaac5f24ed80411d00ad353234144d700") { _isSuccess in
        print("the sucees", _isSuccess)
        if _isSuccess {
            
        }
    }
    
    func settingUpTerra(byToken token : String, complitionHandler : @escaping() -> Void) {
        self.token = token
        print("the params token \(token) and the published var token \(self.token)")
//        terra?.initConnection(token: token)
        terraRt.initConnection(token: token) { isAuth in
            
            print("the token auth", isAuth)
            complitionHandler()
            
        }
        
//        self.streamData()
        
    }
    
    func generateWidgetSession(complitionHandler : @escaping(String) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://api.tryterra.co/v2/auth/generateWidgetSession")!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.allHTTPHeaderFields = ["dev-id": "vex-fitness-dev-9fESfy2QgQ" ,"X-API-Key":"f5491477daf64f44ce53489234d77cacaac5f24ed80411d00ad353234144d700"]
        
        do {
            
            let param : [String : String] = [
                "reference_id": "",
                "providers": "APPLE",
                "auth_success_redirect_url": "http://localhost:4200/dashboard/event-attendies",
                "auth_failure_redirect_url": "https://sad-developer.com",
                "language": "EN"
            ]
            
            let request = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
            
            urlRequest.httpBody = request
            
            URLSession.shared.dataTask(with: urlRequest) { httpData, httpResponse, httpError in
                
                if httpData?.count ?? 0 > 0 && httpError == nil {
                    
                    let strData = String(data: httpData!, encoding: .utf8)
                    
                    do {
                        
                        let jsonData = try JSONSerialization.jsonObject(with: httpData!, options: .mutableContainers)
                        print("the json data", jsonData)
                        
                        if let success = jsonData as? [String : Any] {
                            
                            if let status = success["status"] as? String {
                                
                                complitionHandler(success["url"] as? String ?? "")
                                
                            }
                            
                        }
                        
                    } catch {
                        debugPrint("Error occured while decoding response", error)
                    }
                    
                } else {
                    
                    print("Error in response", httpError?.localizedDescription)
                    
                }
                
            }.resume()
            
        } catch {
            debugPrint("error occured while decoding body", error)
        }
    }
    
    
    func settingUpTheBLE() {
        
       terra?.startBluetoothScan(type: .APPLE, callback: { isSuccess in
            
            print("the success", isSuccess)
            
        })
        
    }
    
    func streamData() {
        terra?.startRealtime(type: .WATCH_OS, dataType: Set(arrayLiteral: .HEART_RATE), token: self.token)
    }
    
    func stopStreaming() {
        terra?.stopRealtime(type: .WATCH_OS)
    }
    
}
