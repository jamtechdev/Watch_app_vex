//
//  ContentView.swift
//  Vex
//
//  Created by Digvijay Ghildiyal on 10/12/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
	private var healthStore = HKHealthStore() 
	@State private var name: String = ""
	@State private var password: String = ""
	@State var navigationFlag = false
	let verticalPaddingForForm = 20
	var body: some View {
		NavigationView{
			ZStack{
				Image("backgroundNoLogo")
					.resizable()
					.scaledToFill()
					.edgesIgnoringSafeArea(.all)
				VStack {
					HStack(){
						VStack(spacing: CGFloat(verticalPaddingForForm)) {
							Text("LOGIN")
								.font(.title2
									.weight(.semibold))
								.frame(width: UIScreen.main.bounds.width, alignment: .leading)
								.padding(.leading, 24)
								.foregroundColor(.black)
							HStack(){
								Text("")
									.frame(width: 40, height: 2)
							}
							.background(.black)
							.frame(width: UIScreen.main.bounds.width, alignment: .leading)
							.padding(.leading, 24)
							HStack {
								Image(systemName: "person")
									.foregroundColor(.secondary)
								TextField("Email", text: $name)
									.foregroundColor(Color.black)
							}
							.padding()
							.overlay(
								RoundedRectangle(cornerRadius: 20)
									.stroke(Color.gray, lineWidth: 1.0)
							)
							//						.clipped(antialiased: false)
							
							HStack {
								Image(systemName: "lock")
									.foregroundColor(.secondary)
								SecureField("Password", text: $password)
									.foregroundColor(Color.black)
							}
							.padding()
							.overlay(
								RoundedRectangle(cornerRadius: 20)
									.stroke(Color.gray, lineWidth: 1.0)
							)
							
							
							
							Button(action: {
								if name != "" && password != ""{
									LoginApi().authenticateUser(email: name, password: password, userRole: "user", deviceType: "ios"){
										self.navigationFlag = true
									}
								}
							}) {
								Text("Login")
									.padding()
									.foregroundColor(.white)
									.font(.system(size: 20)
										.weight(.semibold)
									)
								
							}
							.frame(width: UIScreen.main.bounds.width * 0.91, height: 60)
							.background(Color.black)
							.foregroundColor(Color.white)
							.cornerRadius(20)
							.frame(width: 200)
							
						}.padding(.horizontal, CGFloat(verticalPaddingForForm))
						
					}
				}
				.frame(width: UIScreen.main.bounds.width, height: 350)
				.background(.white)
				.cornerRadius(20)
				.padding(.bottom, 0)
				.padding(.top, 500)
				NavigationLink(destination:
								HeartRateView()
					.navigationBarHidden(true)
					.navigationBarBackButtonHidden(true),
							   isActive: self.$navigationFlag,
							   label: {
					EmptyView()
				}).opacity(0)
			}
			.padding()
		}
		.onAppear(perform: start)
	}
	func start() {
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
