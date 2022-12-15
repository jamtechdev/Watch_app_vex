//
//  ConnectivityViewModel.swift
//  Vex
//
//  Created by Jamtech 01 on 13/12/22.
//

import Foundation
import WatchConnectivity

class IphoneConnectivityViewModel : NSObject, WCSessionDelegate, ObservableObject {
    
    var session: WCSession
    @Published var heartRate = 0
    @Published var token = ""
    
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        DispatchQueue.main.async {
            
            self.heartRate = message["currentHeartRate"] as? Int ?? 0
            print("the heart reate", self.heartRate)
            if let token = message["token"] as? String {
                self.token = token
                print("the token from watch", self.token)
            }
            
        }
       
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Iphone session is inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Iphone session is deactivate")
    }
    
    
}


