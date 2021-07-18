//
//  ContentView.swift
//  Calculator
//
//  Created by Łukasz Janiszewski on 09/07/2021.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            ZStack {
                Color.black.ignoresSafeArea()
            
                if checkDeviceOrientation() == "iphone portrait" {
                    VStack {
                        CalculationsFieldView(viewModel: viewModel)
                            .frame(width: screenWidth * 0.9, height: screenHeight * 0.43)
                        
                        ButtonsPadView(viewModel: viewModel)
                    }
                    .padding(.bottom)
                } else if checkDeviceOrientation() == "small iphone landscape" {
                    HStack {
                        ButtonsPadView(viewModel: viewModel)
                        
                        CalculationsFieldView(viewModel: viewModel)
                    }
                    .padding(.vertical)
                } else if checkDeviceOrientation() == "large iphone landscape" {
                    HStack {
                        ButtonsPadView(viewModel: viewModel)
                        
                        CalculationsFieldView(viewModel: viewModel)
                    }
                    .padding(.vertical)
                } else if checkDeviceOrientation() == "ipad" {
                    HStack {
                        ButtonsPadView(viewModel: viewModel)
                                
                        CalculationsFieldView(viewModel: viewModel)
                    }
                    .padding(.vertical)
                }
            }
        }
    }
    
    func checkDeviceOrientation() -> String {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            return "iphone portrait"
        } else if horizontalSizeClass == .compact && verticalSizeClass == .compact {
            return "small iphone landscape"
        } else if horizontalSizeClass == .regular && verticalSizeClass == .compact {
            return "large iphone landscape"
        } else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return "ipad"
        } else {
            return "iphone portrait"
        }
    }
}


struct CalculationsFieldView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            VStack (spacing: screenHeight * 0.10) {
                ScrollView(.horizontal) {
                    Text(viewModel.a)
                        .font(.system(size: screenHeight * 0.2))
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
                    .font(.system(size: screenHeight * 0.12))
                
                ScrollView(.horizontal) {
                    Text(viewModel.b)
                        .font(.system(size: screenHeight * 0.2))
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
                    .font(.system(size: screenHeight * 0.12))
                
                ScrollView(.horizontal) {
                    Text(viewModel.result)
                        .font(.system(size: screenHeight * 0.2))
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
            }
            .frame(width: screenWidth * 0.9, height: screenHeight * 0.9)
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
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let shape = Circle()
            ZStack {
                if isAnimated {
                    shape.fill().foregroundColor(foregroundButtonColor)
                    Text(text)
                        .font(.system(size: screenWidth * 0.43))
                        .foregroundColor(textButtonColor)
                } else {
                    shape.fill().foregroundColor(foregroundButtonColor)
                    Text(text)
                        .font(.system(size: screenWidth * 0.43))
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
    
}


struct ButtonsPadView: View {
    let viewModel: CalculatorViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            
            VStack {
                HStack (spacing: screenWidth * 0.01) {
                    ButtonView(viewModel: viewModel, buttonText: clearSign, foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: oppositeSign, foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: percentSign, foregroundButtonColor: specialButtonsColor, textButtonColor: specialButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: divisionSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                }
                
                HStack (spacing: screenWidth * 0.01) {
                    ButtonView(viewModel: viewModel, buttonText: "7", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: "8", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: "9", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: multiplicationSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                }
                
                HStack (spacing: screenWidth * 0.01) {
                    ButtonView(viewModel: viewModel, buttonText: "4", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: "5", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: "6", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: subtractionSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                }
                
                HStack (spacing: screenWidth * 0.01) {
                    ButtonView(viewModel: viewModel, buttonText: "1", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: "2", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: "3", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: additionSign, foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                }
                
                HStack (spacing: screenWidth * 0.01) {
                    ButtonView(viewModel: viewModel, buttonText: "↑", foregroundButtonColor: arrowUpButtonColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: "0", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: ".", foregroundButtonColor: numericButtonsColor, textButtonColor: numericButtonsTextColor)
                    
                    ButtonView(viewModel: viewModel, buttonText: "=", foregroundButtonColor: arithmeticButtonsColor, textButtonColor: arithmeticButtonsTextColor)
                }
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
