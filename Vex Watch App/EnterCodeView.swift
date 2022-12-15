//
//  EnterCodeView.swift
//  VexWatch Watch App
//
//  Created by Jamtech 01 on 06/12/22.
//

import SwiftUI

struct EnterCodeView: View {
	
	@State private var isTitleHidden : Bool = false
	
	@State private var showEnteredText : [String] = [String]()
	@State private var enteredCodeData : [String] = [String]()
	@State private var isPushedToAnotherScreen : Bool = false
	
	var body: some View {
		
		
		VStack {
			
			if isTitleHidden {
				
				PinCode(showEnteredText: $showEnteredText)
				
				NumberPad(showClassCode: $isTitleHidden, showEnteredText: $showEnteredText, enteredCodeData: $enteredCodeData, movedToAnotherScreen: $isPushedToAnotherScreen)
					.padding(.horizontal, 10)
					.overlay(
						NavigationLink(destination: VerificationView(codeValue: self.enteredCodeData).navigationBarBackButtonHidden(true), isActive: $isPushedToAnotherScreen, label: {
							
						}).opacity(0)
					)
				
			} else {
				
				Text("Enter Class Code")
					.font(.system(size: 12, weight: .medium))
					.padding(.bottom, 3)
				
				
				
				NumberPad(showClassCode: $isTitleHidden, showEnteredText: $showEnteredText, enteredCodeData: $enteredCodeData, movedToAnotherScreen: $isPushedToAnotherScreen)
					.padding(.horizontal, 10)
					.overlay(
						
						NavigationLink(destination: VerificationView(codeValue: self.enteredCodeData).navigationBarBackButtonHidden(true) , isActive: $isPushedToAnotherScreen, label: {
							
						}).opacity(0)
					)
				
			}
			
			
			
			
			
			
		}
		.onDisappear(perform: {
			self.showEnteredText = [String]()
			self.enteredCodeData = [String]()
			self.isTitleHidden = false
		})
		
		
		
		
		
	}
}



struct EnterCodeView_Previews: PreviewProvider {
	static var previews: some View {
		EnterCodeView()
	}
}



