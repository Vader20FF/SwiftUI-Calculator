//
//  ContentView.swift
//  Calculator
//
//  Created by Łukasz Janiszewski on 09/07/2021.
//

import SwiftUI


let additionSign = "+"
let subtractionSign = "-"
let multiplicationSign = "×"
let divisionSign = "÷"
let clearSign = "AC"
let oppositeSign = "+/-"
let percentSign = "%"


struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    CalculationView()
                    
                    VStack {
                        let specialButtonsColor = Color("SpecialButtonsColor")
                        let arithmeticButtonsColor = Color("ArithmeticButtonsColor")
                        let numericButtonsColor = Color("NumericButtonsColor")
                        let specialButtonsTextColor = Color(.black)
                        let arithmeticButtonsTextColor = Color(.white)
                        let numericButtonsTextColor = Color(.white)
                        
                        HStack (spacing: -screenHeight * 0.03) {
                            ButtonView(buttonText: clearSign, foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                                    
                            ButtonView(buttonText: oppositeSign, foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                            
                            ButtonView(buttonText: percentSign, foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                            
                            ButtonView(buttonText: divisionSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        
                        HStack (spacing: -screenHeight * 0.03) {
                            ButtonView(buttonText: "7", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: "8", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: "9", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: multiplicationSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        
                        HStack (spacing: -screenHeight * 0.03) {
                            ButtonView(buttonText: "4", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: "5", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: "6", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: subtractionSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        
                        HStack (spacing: -screenHeight * 0.03) {
                            ButtonView(buttonText: "1", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: "2", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: "3", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: additionSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        
                        HStack (spacing: -screenHeight * 0.03) {
                            Spacer(minLength: screenWidth * 0.295)
                            ButtonView(buttonText: "0", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: ".", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)

                            ButtonView(buttonText: "=", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                    }
                }
                .padding(.bottom, screenHeight * 0.001)
            }
            
            
        
        }
        
    }
    
}


struct CalculationView: View {
    @State var a = ""
    @State var customOperator = ""
    @State var b = ""
    @State var equalitySign = "="
    @State var result = "0"
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
                
            VStack (spacing: screenHeight * 0.15) {
                ScrollView(.horizontal) {
                    Text(a)
                }
                .frame(width: screenWidth * 0.85, height: screenHeight * 0.05)
                .padding(.top, screenHeight * 0.04)
                    
                Text(customOperator)
                .frame(width: screenWidth * 0.7, height: screenHeight * 0.05, alignment: .leading)
                .foregroundColor(.red)
                .font(.system(size: 40))
                    
                ScrollView(.horizontal) {
                    Text(b)
                }
                .frame(width: screenWidth * 0.85, height: screenHeight * 0.05)
                    
                Text(equalitySign)
                    .frame(width: screenWidth * 0.7, height: screenHeight * 0.05, alignment: .leading)
                    .foregroundColor(.red)
                    .font(.system(size: 40))
                    
                ScrollView(.horizontal) {
                    Text(result)
                }
                .frame(width: screenWidth * 0.85, height: screenHeight * 0.05)
                .padding(.bottom, screenHeight * 0.05)
            }
            .font(.system(size: screenWidth * 0.15))
            .foregroundColor(.white)
            .lineLimit(1)
        }
    }
    
    
    public func assignFunctionToSimpleNumericButton(number: String) -> Void {
        if number == "0" {
            if !a.isEmpty && customOperator.isEmpty {
                a += "\(number)"
            } else if !b.isEmpty && !customOperator.isEmpty {
                b += "\(number)"
            }
        } else {
            if customOperator.isEmpty {
                    a += "\(number)"
            } else if !customOperator.isEmpty {
                    b += "\(number)"
            }
        }
    }
    
     public func assignFunctionToCustomOperator(operatorSign: String) -> Void {
        switch operatorSign {
        case divisionSign:
            if !a.isEmpty {
                customOperator = divisionSign
            }
        case multiplicationSign:
            if !a.isEmpty {
                customOperator = multiplicationSign
            }
        case additionSign:
            if a == subtractionSign || a.isEmpty {
                a = ""
            } else if !a.isEmpty {
                customOperator = additionSign
            }
            
            if !customOperator.isEmpty {
                if b == subtractionSign || b.isEmpty {
                    b = ""
                }
            }
        case subtractionSign:
            if a.isEmpty && !a.contains(subtractionSign) {
                a = subtractionSign
            } else if !customOperator.isEmpty {
                if b.isEmpty && !b.contains(subtractionSign) {
                    b = subtractionSign
                } else {
                    customOperator = subtractionSign
                }
            } else if !a.isEmpty {
                customOperator = subtractionSign
            }
        case oppositeSign:
            if !a.isEmpty {
                customOperator = oppositeSign
                b = ""
            }
        case percentSign:
            if !a.isEmpty {
                customOperator = percentSign
                b = ""
            }
        case clearSign:
            a = ""
            customOperator = ""
            b = ""
            equalitySign = "="
            result = "0"
        case ".":
            if customOperator.isEmpty && !a.contains(".") {
                a += "."
            } else if !customOperator.isEmpty && !b.contains(".") {
                b += "."
            }
        case "=":
            switch customOperator {
            case divisionSign:
                if !b.isEmpty {
                    if !(b == "0") && !(b == "-0") {
                        result = String(Double(a)! / Double(b)!)
                        if result.hasSuffix(".0") {
                            result = String(result.dropLast(2))
                        }
                    }
                }
            case multiplicationSign:
                if !b.isEmpty {
                    result = String(Double(a)! * Double(b)!)
                    if result.hasSuffix(".0") {
                        result = String(result.dropLast(2))
                    }
                }
            case subtractionSign:
                if !b.isEmpty {
                    result = String(Double(a)! - Double(b)!)
                    if result.hasSuffix(".0") {
                        result = String(result.dropLast(2))
                    }
                }
            case additionSign:
                if !b.isEmpty {
                    result = String(Double(a)! + Double(b)!)
                    if result.hasSuffix(".0") {
                        result = String(result.dropLast(2))
                    }
                }
            case percentSign:
                if !result.isEmpty {
                    result = String(Double(a)! / 100)
                    b = ""
                    equalitySign = "="
                    if result.hasSuffix(".0") {
                        result = String(result.dropLast(2))
                    }
                }
            case oppositeSign:
                if !result.isEmpty {
                    result = String(-Double(a)!)
                    b = ""
                    equalitySign = "="
                    if result.hasSuffix(".0") {
                        result = String(result.dropLast(2))
                    }
                }
            default:
                result = "0"
            }
        default:
            result = "0"
        }
    }
}


struct ButtonView: View {
    private var text: String
    private var foregroundButtonColor: Color
    private var textButtonColor: Color
    
    @State private var isActive = false
    
    init(buttonText: String, foregroundButtonColor: Color, textButtonColor: Color) {
        self.text = buttonText
        self.foregroundButtonColor = foregroundButtonColor
        self.textButtonColor = textButtonColor
    }
        
    var body: some View {
        ZStack {
            let shape = Circle()
            shape.fill().foregroundColor(foregroundButtonColor)
            Text(text)
                .font(.largeTitle)
                .foregroundColor(textButtonColor)
        }
        .onTapGesture {
            if Int(text) != nil {
                CalculationView().assignFunctionToSimpleNumericButton(number: self.text)
            } else {
                CalculationView().assignFunctionToCustomOperator(operatorSign: self.text)
            }
            
        }
//        .offset(x: 0, y: isActive ? 10 : 0)
//        .animation(.easeOut(duration: 0.2))
//        .gesture(DragGesture(minimumDistance: 0)
//                    .onChanged({ _ in
//                        self.isActive = true
//                    })
//                    .onEnded({ _ in
//                        self.isActive = false
//                    })
//        )
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
