//
//  Globals.swift
//  Vex Watch App
//
//  Created by Digvijay Ghildiyal on 10/12/22.
//

import Foundation

struct KType : Identifiable {
	
	var id : Int
	var row : [KRow]
	
}

struct KRow : Identifiable {
	
	var id : Int
	var value : String
	
}


var datas = [
	
	KType(id: 0, row: [KRow(id: 0, value: "1"), KRow(id: 1, value: "2"), KRow(id: 2, value: "3")]),
	KType(id: 1, row: [KRow(id: 0, value: "4"), KRow(id: 1, value: "5"), KRow(id: 2, value: "6")]),
	KType(id: 2, row: [KRow(id: 0, value: "7"), KRow(id: 1, value: "8"), KRow(id: 2, value: "9")]),
	KType(id: 3, row: [KRow(id: 0, value: "00"), KRow(id: 1, value: "0"), KRow(id: 2, value: "delete.left.fill")]),
	
	
]
