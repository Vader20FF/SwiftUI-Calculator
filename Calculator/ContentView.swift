//
//  ContentView.swift
//  Calculator
//
//  Created by Łukasz Janiszewski on 09/07/2021.
//

import SwiftUI


struct ContentView: View {
    @State var a = ""
    @State var customOperator = ""
    @State var b = ""
    @State var equalitySign = "="
    @State var result = "0"
    
    
    private enum RoundingPrecision {
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
    }
    
    
    private func preciseRound(
        _ value: Double,
        precision: RoundingPrecision = .one) -> Double
    {
        switch precision {
        case .one:
            return round(value)
        case .two:
            return round(value * 10) / 10.0
        case .three:
            return round(value * 100) / 100.0
        case .four:
            return round(value * 1000) / 1000.0
        case .five:
            return round(value * 10000) / 10000.0
        case .six:
            return round(value * 100000) / 100000.0
        case .seven:
            return round(value * 1000000) / 1000000.0
        case .eight:
            return round(value * 10000000) / 10000000.0
        case .nine:
            return round(value * 100000000) / 100000000.0
        }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    
                    VStack (spacing: screenHeight * 0.04) {
                        Text(a)
                            .frame(width: screenWidth * 0.85, height: screenHeight * 0.05, alignment: .trailing)
                        Text(customOperator)
                            .frame(width: screenWidth * 0.7, height: screenHeight * 0.05, alignment: .trailing)
                            .foregroundColor(.red)
                        Text(b)
                            .frame(width: screenWidth * 0.85, height: screenHeight * 0.05, alignment: .trailing)
                        Text(equalitySign)
                            .frame(width: screenWidth * 0.7, height: screenHeight * 0.05, alignment: .trailing)
                            .foregroundColor(.red)
                        Text(result)
                            .frame(width: screenWidth * 0.85, height: screenHeight * 0.05, alignment: .trailing)
                    }
                    .font(.system(size: screenWidth * 0.15))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    
                    VStack (spacing: screenHeight * 0.02) {
                        let specialButtonsColor = Color("SpecialButtonsColor")
                        let arithmeticButtonsColor = Color("ArithmeticButtonsColor")
                        let numericButtonsColor = Color("NumericButtonsColor")
                        let specialButtonsTextColor = Color(.black)
                        let arithmeticButtonsTextColor = Color(.white)
                        let numericButtonsTextColor = Color(.white)
                        
                        HStack (spacing: screenWidth * 0.02) {
                            ButtonView(buttonText: "AC", foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                                .onTapGesture {
                                    a = ""
                                    customOperator = ""
                                    b = ""
                                    equalitySign = "="
                                    result = "0"
                                }
                                    
                            ButtonView(buttonText: "+/-", foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                                .onTapGesture {
                                    if !a.isEmpty {
                                        customOperator = "+/-"
                                        b = ""
                                    }
                                }
                            ButtonView(buttonText: "%", foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                                .onTapGesture {
                                    if !a.isEmpty {
                                        customOperator = "%"
                                        b = ""
                                    }
                                }
                            ButtonView(buttonText: "/", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                                .onTapGesture {
                                    if !a.isEmpty {
                                        customOperator = "/"
                                    }
                                }
                        }
                        HStack (spacing: screenWidth * 0.02) {
                            ButtonView(buttonText: "7", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if customOperator.isEmpty {
                                        a += "7"
                                    } else if !customOperator.isEmpty {
                                        b += "7"
                                    }
                                }
                            ButtonView(buttonText: "8", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if customOperator.isEmpty {
                                        a += "8"
                                    } else if !customOperator.isEmpty {
                                        b += "8"
                                    }
                                }
                            ButtonView(buttonText: "9", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if customOperator.isEmpty {
                                        a += "9"
                                    } else if !customOperator.isEmpty {
                                        b += "9"
                                    }
                                }
                            ButtonView(buttonText: "x", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                                .onTapGesture {
                                    if !a.isEmpty {
                                        customOperator = "x"
                                    }
                                }
                        }
                        HStack (spacing: screenWidth * 0.02) {
                            ButtonView(buttonText: "4", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if customOperator.isEmpty {
                                        a += "4"
                                    } else if !customOperator.isEmpty {
                                        b += "4"
                                    }
                                }
                            ButtonView(buttonText: "5", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if customOperator.isEmpty {
                                        a += "5"
                                    } else if !customOperator.isEmpty {
                                        b += "5"
                                    }
                                }
                            ButtonView(buttonText: "6", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if customOperator.isEmpty {
                                        a += "6"
                                    } else if !customOperator.isEmpty {
                                        b += "6"
                                    }
                                }
                            ButtonView(buttonText: "-", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                                .onTapGesture {
                                    if !a.isEmpty {
                                        customOperator = "-"
                                    } else {
                                        a = String(-Double(a)!)
                                    }
                                }
                        }
                        HStack (spacing: screenWidth * 0.02) {
                            ButtonView(buttonText: "1", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if customOperator.isEmpty {
                                        a += "1"
                                    } else if !customOperator.isEmpty {
                                        b += "1"
                                    }
                                }
                            ButtonView(buttonText: "2", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if customOperator.isEmpty {
                                        a += "2"
                                    } else if !customOperator.isEmpty {
                                        b += "2"
                                    }
                                }
                            ButtonView(buttonText: "3", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if customOperator.isEmpty {
                                        a += "3"
                                    } else if !customOperator.isEmpty {
                                        b += "3"
                                    }
                                }
                            ButtonView(buttonText: "+", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                                .onTapGesture {
                                    if Double(a)! >= 0 {
                                        customOperator = "+"
                                    } else {
                                        a = String(-Double(a)!)
                                    }
                                }
                        }
                        HStack (spacing: screenWidth * 0.02) {
                            Spacer(minLength: screenWidth * 0.240)
                            ButtonView(buttonText: "0", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if a.isEmpty {
                                        a = "0"
                                    } else {
                                        b = "0"
                                    }
                                }
                            ButtonView(buttonText: ".", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                                .onTapGesture {
                                    if customOperator.isEmpty && !a.contains(".") {
                                        a += "."
                                    } else if !customOperator.isEmpty && !b.contains(".") {
                                        b += "."
                                    }
                                }
                            ButtonView(buttonText: "=", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                                .onTapGesture {
                                    switch customOperator {
                                    case "/":
                                        if !b.isEmpty {
                                            result = String(preciseRound(Double(a)! / Double(b)!, precision: .nine))
                                        }
                                    case "x":
                                        if !b.isEmpty {
                                            result = String(preciseRound(Double(a)! * Double(b)!, precision: .nine))
                                        }
                                    case "-":
                                        if !b.isEmpty {
                                            result = String(preciseRound(Double(a)! - Double(b)!, precision: .nine))
                                        }
                                    case "+":
                                        if !b.isEmpty {
                                            result = String(preciseRound(Double(a)! + Double(b)!, precision: .nine))
                                        }
                                    case "%":
                                        if !result.isEmpty {
                                            result = String(preciseRound(Double(a)! / 100, precision: .nine))
                                            b = ""
                                            equalitySign = "="
                                        }
                                    case "+/-":
                                        if !result.isEmpty {
                                            result = String(-Double(a)!)
                                            b = ""
                                            equalitySign = "="
                                        }
                                        
                                    default:
                                        result = "0"
                                    }
                                }
                        }
                    }
                    
                            
                }
                .padding(.bottom, screenHeight * 0.001)
        }
            
            
        
        }
        
    }
}


struct ButtonView: View {
    private var text: String
    private var foregroundButtonColor: Color
    private var textButtonColor: Color
    
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
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(textButtonColor)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
