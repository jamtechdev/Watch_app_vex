//
//  PinCodeView.swift
//  VexWatch Watch App
//
//  Created by Jamtech 01 on 07/12/22.
//

import SwiftUI


struct PinCode : View {
	
	@Binding var showEnteredText : [String]
	@State private var showFilledCircle : Bool = false
	
	var body: some View {
		
		VStack {
			
			HStack(spacing: 5) {
				
				if self.showEnteredText.count  == 1 {
					
					Text("\(showEnteredText[0])")
						.font(.system(size: 15, weight: .bold))
						.padding(.bottom, 0)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now()) {
								self.showEnteredText[0] = "⚪️"
								print("the show entered arr", self.showEnteredText)
								
							}
						}
					
					Image(systemName: "circle")
						.resizable()
						.frame(width: 10, height: 10)
						.foregroundColor(.white)
					
					Image(systemName: "circle")
						.resizable()
						.frame(width: 10, height: 10)
						.foregroundColor(.white)
					
					Image(systemName: "circle")
						.resizable()
						.frame(width: 10, height: 10)
						.foregroundColor(.white)
					
					
					
				} else if self.showEnteredText.count == 2 {
					
					Text("\(showEnteredText[0])")
						.font(.system(size: 15, weight: .bold))
						.padding(.bottom, 0)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now()) {
								self.showEnteredText[1] = "⚪️"
								
							}
						}
					
					Text("\(showEnteredText[1] )")
						.font(.system(size: 15, weight: .bold))
						.padding(.bottom, 0)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now()) {
								self.showEnteredText[1] = "⚪️"
								
							}
						}
					
					Image(systemName: "circle")
						.resizable()
						.frame(width: 10, height: 10)
						.foregroundColor(.white)
					
					Image(systemName: "circle")
						.resizable()
						.frame(width: 10, height: 10)
						.foregroundColor(.white)
					
				} else if self.showEnteredText.count == 3 {
					
					Text("\(showEnteredText[0])")
						.font(.system(size: 15, weight: .bold))
						.padding(.bottom, 0)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now()) {
								self.showEnteredText[0] = "⚪️"
								
							}
						}
					
					Text("\(showEnteredText[1] )")
						.font(.system(size: 15, weight: .bold))
						.padding(.bottom, 0)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now()) {
								self.showEnteredText[1] = "⚪️"
								
							}
						}
					
					Text("\(showEnteredText[2])")
						.font(.system(size: 15, weight: .bold))
						.padding(.bottom, 0)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now()) {
								self.showEnteredText[2] = "⚪️"
								
							}
						}
					
					Image(systemName: "circle")
						.resizable()
						.frame(width: 10, height: 10)
						.foregroundColor(.white)
					
				} else if self.showEnteredText.count == 4 {
					
					Text("\(showEnteredText[0])")
						.font(.system(size: 15, weight: .bold))
						.padding(.bottom, 0)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now()) {
								self.showEnteredText[0] = "⚪️"
								
							}
						}
					
					Text("\(showEnteredText[1] )")
						.font(.system(size: 15, weight: .bold))
						.padding(.bottom, 0)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now()) {
								self.showEnteredText[1] = "⚪️"
								
							}
						}
					
					Text("\(showEnteredText[2])")
						.font(.system(size: 15, weight: .bold))
						.padding(.bottom, 0)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now()) {
								self.showEnteredText[2] = "⚪️"
								
							}
						}
					
					Text("\(showEnteredText[3])")
						.font(.system(size: 15, weight: .bold))
						.padding(.bottom, 0)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now()) {
								self.showEnteredText[3] = "⚪️"
								
							}
						}
					
				}
				
			}
			
			//            Text("hellow")
			//                .font(.system(size: 13, weight: .medium))
			//                .padding(.bottom, 3)
			
		}
		
	}
	
}

struct PinCode_Previews: PreviewProvider {
	static var previews: some View {
		PinCode(showEnteredText: .constant([""]))
	}
}
