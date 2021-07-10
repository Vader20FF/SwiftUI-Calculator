//
//  ContentView.swift
//  Calculator
//
//  Created by Łukasz Janiszewski on 09/07/2021.
//

import SwiftUI


struct ContentView: View {
    @State var a = "2"
    @State var customOperator = "+"
    @State var b = "3"
    @State var equalitySign = "="
    @State var result = "5"
    
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
                                    
                            ButtonView(buttonText: "+/-", foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                            ButtonView(buttonText: "%", foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                            ButtonView(buttonText: "/", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        HStack (spacing: screenWidth * 0.02) {
                            ButtonView(buttonText: "7", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: "8", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: "9", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: "x", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        HStack (spacing: screenWidth * 0.02) {
                            ButtonView(buttonText: "4", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: "5", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: "6", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: "-", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        HStack (spacing: screenWidth * 0.02) {
                            ButtonView(buttonText: "1", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: "2", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: "3", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: "+", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        HStack (spacing: screenWidth * 0.02) {
                            Spacer(minLength: screenWidth * 0.240)
                            ButtonView(buttonText: "0", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: ",", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            ButtonView(buttonText: "=", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                    }
                    
                            
                }
                .padding(.bottom, screenHeight * 0.001)
        }
        
        }
        
    }
}



func addition(a: Double, b: Double) -> Double {
    return a + b
}


func subtraction(a: Double, b: Double) -> Double {
    return a - b
}


func multiplication(a: Double, b: Double) -> Double {
    return a * b
}


func division(a: Double, b: Double) -> Double {
    return a / b
}


func clear() -> Double {
    return 0
}


func reverseNumber(a: Double) -> Double {
    return -a
}


func percent(a: Double) -> Double {
    return a / 100
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
