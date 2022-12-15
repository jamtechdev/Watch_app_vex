import SwiftUI


struct NumberPad : View {
	
	@Binding var showClassCode : Bool
	
	@Binding var showEnteredText : [String]
	@Binding var enteredCodeData : [String]
	@Binding var movedToAnotherScreen : Bool
	
	var body: some View {
		
		VStack(spacing : 3) {
			
			ForEach(datas) { i in
				
				HStack(spacing : 2) {
					
					ForEach(i.row) { j in
						
						if j.value == "00" {
							
							Spacer()
							Spacer()
							Spacer()
							Spacer()
							Spacer()
							Spacer()
							Spacer()
							Spacer()
							//                            Spacer()
							
						} else {
							Button {
								
								
								self.showEnteredText.append(j.value)
								print("the Entered value", self.showEnteredText)
								self.enteredCodeData.append(j.value)
								print("the tapped value", j.value)
								
								if self.showEnteredText.count == 4 {
									
									self.movedToAnotherScreen = true
									print("Moving to the another screen")
									
								} else if j.value == "delete.left.fill" {
									
									print("Tapped on cross btn")
									
								} else {
									
									
									
									if self.showEnteredText.count == 0 {
										
										self.movedToAnotherScreen = false
										self.showClassCode = false
										
									} else {
										self.movedToAnotherScreen = false
										self.showClassCode = true
										
									}
								}
								
								
								
								
								
							} label: {
								
								if j.value == "delete.left.fill" {
									
									Image(systemName: j.value)
										.font(.body)
										.padding(.vertical)
										.foregroundColor(.white)
										.onTapGesture {
											
											if self.showEnteredText.count == 0 {
												print("Empty Array")
												self.showClassCode = false
												
											} else {
												self.showEnteredText.removeLast()
												self.enteredCodeData.removeLast()
												
												if self.showEnteredText.count == 0 {
													self.showClassCode = false
												}
												
											}
											
										}
									
								} else {
									Text(j.value)
										.font(.body)
										.fontWeight(.semibold)
										.padding(.vertical)
								}
								
								
							}
						}
						
					}
					
					
				}
				
			}
			
		}
		
	}
	
}

struct NumberPad_Previews: PreviewProvider {
	static var previews: some View {
		NumberPad(showClassCode: .constant(true), showEnteredText: .constant([""]), enteredCodeData: .constant([""]), movedToAnotherScreen: .constant(false))
	}
}
