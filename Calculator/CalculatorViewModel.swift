//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Łukasz Janiszewski on 12/07/2021.
//

import SwiftUI



class CalculatorViewModel: ObservableObject {
    @Published private var model: CalculatorModel = createCalculator()
    
    var a: String {
        model.a
    }
    
    var customOperator: String {
        model.customOperator
    }
    
    var b: String {
        model.b
    }
     
    var equalitySign: String {
        model.equalitySign
    }
    
    var result: String {
        model.result
    }
    
    static func createCalculator() -> CalculatorModel {
        CalculatorModel()
    }
    
    func chooseButton(buttonText: String) {
        model.chooseButton(buttonText: buttonText)
    }
    
    func copyToClipboard(number: String) {
        UIPasteboard.general.string = number
    }
}
