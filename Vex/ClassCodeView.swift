//
//  ClassCodeView.swift
//  Vex
//
//  Created by Digvijay Ghildiyal on 10/12/22.
//

import SwiftUI

struct ClassCodeView: View {
    var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			VStack{
				VStack{
					Text("Connect Wearable")
						.font(.title3)
						.fontWeight(.semibold)
						.padding(.top, 32)
						.foregroundColor(.black)
					HStack(spacing: 10){
						Text("180")
							.font(.system(size: 130)
								.weight(.bold)
							)
							.foregroundColor(.black)
						Image("cardiogram (1)").resizable()
							.frame(width: 70, height: 70)
							.padding(.top, 5)
					}
					.frame(width: UIScreen.main.bounds.width, height: 150, alignment: .top)
					.padding(.leading, 10)
					.padding(.trailing, 10)
					.padding(.top, 20)
					Spacer()
					
				}
				.frame(width: UIScreen.main.bounds.width - 40, height: 330, alignment: .top)
				.background(.gray)
				.cornerRadius(20)
				.padding(.top, 5)
				Spacer()
			}
		}
    }
}

struct ClassCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ClassCodeView()
    }
}
