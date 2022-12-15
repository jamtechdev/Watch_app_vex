//
//  WatchConnectivityClass.swift
//  VexWatch Watch App
//
//  Created by Jamtech 01 on 08/12/22.
//

import Foundation
import WatchConnectivity

class WatchConnectivityViewModel : NSObject, WCSessionDelegate {
    
    var session: WCSession
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
//    func sessionDidBecomeInactive(_ session: WCSession) {
//        print("Watch session is inactive")
//    }
//
//    func sessionDidDeactivate(_ session: WCSession) {
//        print("Watch session is de activate")
//    }
    
}
