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
    @ObservedObject var viewModel: CalculatorViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    CalculationView(viewModel: viewModel)
                    
                    VStack {
                        let specialButtonsColor = Color("SpecialButtonsColor")
                        let arithmeticButtonsColor = Color("ArithmeticButtonsColor")
                        let numericButtonsColor = Color("NumericButtonsColor")
                        let arrowUpButtonColor = Color("ArrowUpButtonColor")
                        let specialButtonsTextColor = Color(.black)
                        let arithmeticButtonsTextColor = Color(.white)
                        let numericButtonsTextColor = Color(.white)
                        
                        HStack (spacing: -screenHeight * 0.03) {
                            ButtonView(viewModel: viewModel, buttonText: clearSign, foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: oppositeSign, foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: percentSign, foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: divisionSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        
                        HStack (spacing: -screenHeight * 0.03) {
                            ButtonView(viewModel: viewModel, buttonText: "7", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: "8", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: "9", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: multiplicationSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        
                        HStack (spacing: -screenHeight * 0.03) {
                            ButtonView(viewModel: viewModel, buttonText: "4", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: "5", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: "6", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: subtractionSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        
                        HStack (spacing: -screenHeight * 0.03) {
                            ButtonView(viewModel: viewModel, buttonText: "1", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: "2", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: "3", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: additionSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                        
                        HStack (spacing: -screenHeight * 0.03) {
                            ButtonView(viewModel: viewModel, buttonText: "↑", foregroundButtonColor: arrowUpButtonColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: "0", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: ".", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                            
                            ButtonView(viewModel: viewModel, buttonText: "=", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                        }
                    }
                }
                .padding(.bottom, screenHeight * 0.001)
            }
        }
    }
}


struct CalculationView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            VStack (spacing: screenHeight * 0.10) {
                ScrollView(.horizontal) {
                    Text(viewModel.a)
                        .foregroundColor(.white)
                        .contextMenu {
                            Button {
                                viewModel.copyToClipboard(number: viewModel.a)
                            } label: {
                                Label("Kopiuj", systemImage: "nil")
                            }
                        }
                }
                .frame(width: screenWidth * 0.85, height: screenHeight * 0.05)
                .padding(.top, screenHeight * 0.06)
                
                Text(viewModel.customOperator)
                    .frame(width: screenWidth * 0.7, height: screenHeight * 0.05, alignment: .leading)
                    .foregroundColor(.red)
                    .font(.system(size: 40))
                
                ScrollView(.horizontal) {
                    Text(viewModel.b)
                        .foregroundColor(.white)
                        .contextMenu {
                            Button {
                                viewModel.copyToClipboard(number: viewModel.b)
                            } label: {
                                Label("Kopiuj", systemImage: "nil")
                            }
                        }
                }
                .frame(width: screenWidth * 0.85, height: screenHeight * 0.05)
                
                Text(viewModel.equalitySign)
                    .frame(width: screenWidth * 0.7, height: screenHeight * 0.05, alignment: .leading)
                    .foregroundColor(.red)
                    .font(.system(size: 40))
                
                ScrollView(.horizontal) {
                    Text(viewModel.result)
                        .foregroundColor(.white)
                        .contextMenu {
                            Button {
                                viewModel.copyToClipboard(number: viewModel.result)
                            } label: {
                                Label("Kopiuj", systemImage: "nil")
                            }
                        }
                }
                .frame(width: screenWidth * 0.85, height: screenHeight * 0.05)
                .padding(.bottom, screenHeight * 0.06)
            }
            .frame(width: screenWidth * 0.9, height: screenHeight)
            .padding(.leading, screenWidth * 0.05)
            .font(.system(size: screenWidth * 0.15))
        }
    }
}


struct ButtonView: View {
    let viewModel: CalculatorViewModel
    
    private var text: String
    private var foregroundButtonColor: Color
    private var textButtonColor: Color
    @State private var isAnimated = true
    
    init(viewModel: CalculatorViewModel, buttonText: String, foregroundButtonColor: Color, textButtonColor: Color) {
        self.viewModel = viewModel
        self.text = buttonText
        self.foregroundButtonColor = foregroundButtonColor
        self.textButtonColor = textButtonColor
    }
    
    var body: some View {
        let shape = Circle()
        ZStack {
            if isAnimated {
                shape.fill().foregroundColor(foregroundButtonColor)
                Text(text)
                    .font(.largeTitle)
                    .foregroundColor(textButtonColor)
            } else {
                shape.fill().foregroundColor(foregroundButtonColor)
                Text(text)
                    .font(.largeTitle)
                    .foregroundColor(textButtonColor)
            }
        }
        .onTapGesture {
            viewModel.chooseButton(buttonText: self.text)
            withAnimation(.spring()) {
                isAnimated.toggle()
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CalculatorViewModel()
        Group {
            ContentView(viewModel: viewModel)
        }
    }
}
