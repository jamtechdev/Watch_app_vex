//
//  StreamView.swift
//  VexWatch Watch App
//
//  Created by Digvijay Ghildiyal on 05/12/22.
//

import SwiftUI
import HealthKit
import ActivityIndicatorView
import WatchConnectivity

struct StreamView: View {
    
	private var healthStore = HKHealthStore()
	let heartRateQuantity = HKUnit(from: "count/min")
    let connectivityViewModel = WatchConnectivityViewModel()
    @State private var showLoadingIndicator: Bool = true
	@State private var value = 0
	@Environment(\.dismiss) var dismiss
    
	var body: some View {
		VStack{
			HStack(spacing: 10){
				Text("\(value)")
					.font(.system(size: 70)
						.weight(.semibold)
					)
					.foregroundColor(.black)
				Image("cardiogram").resizable()
					.frame(width: 40, height: 40)
					.padding(.top, 5)
			}
			.frame(width: 180, height: 100, alignment: .top)
			.background(.green)
			.cornerRadius(20)
			.padding(.leading, 10)
			.padding(.trailing, 10)
			.padding(.top, 5)
			Spacer()
			VStack{
				HStack{
					Button {
						print("Hello")
//						send(heartRate: value)
					} label: {
						Text("Start Stream")
							.foregroundColor(.black)
							.font(.system(size: 16)
								.weight(.semibold)
							)
					}
				}
				.cornerRadius(22)
				.background(Color("Color")
					.clipShape(RoundedRectangle(cornerRadius:12)))
				.padding(.top, 16)
				.padding(.leading, 10)
				.padding(.trailing, 10)
				Spacer()
				
			}
		}
		.background(.black)
		.onAppear(perform: start)
	}
    
	
//	func activateSession(){
//		if WCSession.isSupported(){
////			WCSession.default.delegate = self
//			WCSession.default.activate()
//		}
//	}
	
	func send(heartRate: Int) {
		let session = WatchConnectivityViewModel()
		guard WCSession.default.isReachable else {
			print("Phone is not reachable")
			return
		}
		WCSession.default.sendMessage(["Heart Rate" : heartRate], replyHandler: nil) { error in
			print("Error sending message to phone: \(error.localizedDescription)")
		}
	}
	
	func start() {
//		activateSession()
//		autorizeHealthKit()
		startHeartRateQuery(quantityTypeIdentifier: .heartRate)
	}
	
	func autorizeHealthKit() {
		let healthKitTypes: Set = [
			HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
		
		healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
	}
	
	private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
		
		// 1
		let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
		// 2
		let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
			query, samples, deletedObjects, queryAnchor, error in
			
			// 3
			guard let samples = samples as? [HKQuantitySample] else {
				return
			}
			
			self.process(samples, type: quantityTypeIdentifier)
			
		}
		
		// 4
		let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
		
		query.updateHandler = updateHandler
		
		// 5
		healthStore.execute(query)
	}
	
	private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .arcs()).frame(width: 50, height: 50).foregroundColor(.red)
		var lastHeartRate = 0.0
		
		for sample in samples {
			if type == .heartRate {
				lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
			}
			
			self.value = Int(lastHeartRate)
            
            self.connectivityViewModel.session.sendMessage(["currentHeartRate": self.value], replyHandler: nil)
            
		}
	}
    
}

struct StreamView_Previews: PreviewProvider {
	static var previews: some View {
		StreamView()
	}
}
