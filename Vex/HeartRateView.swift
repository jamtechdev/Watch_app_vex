//
//  HeartRateView.swift
//  Vex
//
//  Created by Digvijay Ghildiyal on 10/12/22.
//

import SwiftUI
import ActivityIndicatorView
import HealthKit

struct HeartRateView: View {
	private var healthStore = HKHealthStore()
    @StateObject var viewModel = IphoneConnectivityViewModel()
    @StateObject var terraViewMode = TerraViewModel()
	let heartRateQuantity = HKUnit(from: "count/min")
	@State private var showLoadingIndicator: Bool = true
	@State private var value = 0
    var body: some View {
		ZStack{
			Color.white.ignoresSafeArea()
			VStack{
				VStack{
					Text("Label")
						.font(.title3)
						.fontWeight(.semibold)
						.padding(.top, 32)
						.foregroundColor(.black)
					HStack(spacing: 10){
                        Text("\(viewModel.heartRate)")
							.font(.system(size: 130)
								.weight(.bold)
							)
							.foregroundColor(.black)
                            .onChange(of: viewModel.heartRate) { newValue in
//                                let teraToken = UserDefaults.standard.string(forKey: "TerraToken")
                                print("the terra token", viewModel.token)
//                                self.terraViewMode.settingUpTerra(byToken: viewModel.token)
                            }
                        
						Image("cardiogram (1)").resizable()
							.frame(width: 70, height: 70)
							.padding(.top, 5)
					}
					.frame(width: UIScreen.main.bounds.width, height: 150, alignment: .top)
					.padding(.leading, 10)
					.padding(.trailing, 10)
					.padding(.top, 20)
					Spacer()
					HStack{
						Text("70%")
							.font(.system(size: 18)
								.weight(.bold)
							)
							.padding(.bottom, 16)
							.frame(width: (UIScreen.main.bounds.width - 70) / 2,alignment: .leading)
							.foregroundColor(.black)
						Text("140 kcal")
							.font(.system(size: 18)
								.weight(.bold)
							)
							.padding(.bottom, 16)
							.frame(width: (UIScreen.main.bounds.width - 70) / 2,alignment: .trailing)
							.foregroundColor(.black)
//							.padding(.leading, 16)
					}
					.frame(width: UIScreen.main.bounds.width - 40)
					
				}
				.frame(width: UIScreen.main.bounds.width - 40, height: 330, alignment: .top)
				.background(.green)
				.cornerRadius(20)
				.padding(.top, 5)
				Spacer()
				
				VStack{
					Image("cardiogram (1)").resizable()
						.frame(width: 120, height: 120)
						.padding(.top, 24)
					Text("Welcome to\nGym Fitness")
						.font(.system(size: 24)
							.weight(.semibold)
						)
						.fixedSize(horizontal: false, vertical: true)
						.frame(alignment: .center)
						.padding(.top, 16)
						.foregroundColor(.black)
					HStack{
						Button {
							print("Hello")
						} label: {
							Text("Stop HR Stream")
								.foregroundColor(.black)
								.font(.system(size: 20)
									.weight(.semibold)
								)
								.frame(width: UIScreen.main.bounds.width*0.7, height: 50, alignment: .center)
						}
					}
					.background(Color.gray.opacity(0.5))
//					.background(Color("Color")
//						.clipShape(RoundedRectangle(cornerRadius:12)))
					.cornerRadius(12)
					.padding(.top, 16)
					
				}
				.frame(width: UIScreen.main.bounds.width - 40, height: 330, alignment: .top)
				.background(.white)
				.padding(.top, 5)
				.overlay(
					RoundedRectangle(cornerRadius: 20)
						.stroke(Color.black, lineWidth: 1.0)
				)
				.clipped(antialiased: true)
				Spacer()
			}
		}
		.accentColor(.white)
        .onAppear {
            self.start()
            
            
            self.terraViewMode.generateWidgetSession { url in
//                if let url = url {
                
                DispatchQueue.main.async {
                    UIApplication.shared.open(URL(string: url)!)
                    
                }
                self.terraViewMode.settingUpTerra(byToken: self.viewModel.token) {
                    
                }
                
                
                
//                } else {
//                    
//                }
            }
        }
//		.background(.white)
//		.onAppear(perform:
//                    start)
    }
	
	func start() {
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
            
            self.viewModel.session.sendMessage(["currentHeartRate": self.value], replyHandler: nil)
            
            
            
		}
	}
}

struct HeartRateView_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateView()
    }
}
