//
//  ContentView.swift
//  VexWatch Watch App
//
//  Created by Digvijay Ghildiyal on 05/12/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
	private var healthStore = HKHealthStore()
    let viewModel = WatchConnectivityViewModel()
	@State var totalTime = 5
	@State var timerTime : Float = 0
	@State var minute: Float = 0.0
	@State var navigationFlag = false
	let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
	var body: some View {
		NavigationView{
			VStack {
				HStack{
					
					//                    .fullScreenCover(isPresented: $navigationFlag) {
					//                        EnterCodeView()
					//
					//                    }
					ZStack{
						
						Button {
							print("Hello")
							self.navigationFlag = true
						} label: {
							Text("Connection\n Successful")
								.foregroundColor(.white)
								.font(.system(size: 16)
									.weight(.semibold)
								)
						}
						
						//                        NavigationLink(destination:
						//                                        CodeView(),
						//                                       isActive: self.$navigationFlag,
						//                                       label: {
						//                            EmptyView()
						//                        })
						
						
						
						NavigationLink(destination:
										EnterCodeView()
							.navigationBarHidden(true)
							.navigationBarBackButtonHidden(true),
									   isActive: self.$navigationFlag,
									   label: {
							EmptyView()
						}).opacity(0)
						
						
						//                        .frame(width: 0)
						
						
					}
					
					
				}
				.cornerRadius(22)
				.background(Color("Color 3")
					.clipShape(RoundedRectangle(cornerRadius:12)))
				.padding(.top, 55)
				.padding(.leading, 2)
				.padding(.trailing, 2)
				Spacer()
				//                Text("Connection \nSuccessful.")
				//                    .onReceive(timer) { input in
				//                        if self.minute == self.timerTime {
				//                            self.navigationFlag = true
				//                            self.timer.upstream.connect().cancel()
				//                        }else{
				//                            self.minute += 1.0
				//                        }
				//                        //                        if totalTime > 0{
				//                        //                            totalTime -= 1
				//                        //                        }else{
				//                        //                            self.navigationFlag = true
				//                        //                        }
				//                    }
				//                    .font(
				//                        .title3
				//                            .weight(.semibold)
				//                    )
			}
			//            .overlay(
			//                ZStack {
			//                    NavigationLink(destination: CodeView(), label: {
			//                        EmptyView()
			//                        //                            .frame(height: 0)
			//                    })
			//                    .background(.clear)
			//                    //                    .frame(width: 0, height: 0)
			//                }
			//            )
			//            .padding()
			//        }
		}
		.onAppear(perform: start)
	}
	func start() {
		//		activateSession()
		autorizeHealthKit()
	}
	
	func autorizeHealthKit() {
		let healthKitTypes: Set = [
			HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
		
		healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
