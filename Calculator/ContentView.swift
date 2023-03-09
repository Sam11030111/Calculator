//
//  ContentView.swift
//  Calculator
//
//  Created by 李竑陞 on 2023/3/6.
//

import SwiftUI

enum CalculateBtn: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var btnColor: Color {
        switch self {
        case .divide, .multiply, .subtract, .add, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(red: 55/255, green: 55/255, blue: 55/255, opacity: 1)
        }
    }
}

enum Operation {
    case divide, multiply, subtract, add, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let btns: [[CalculateBtn]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                // Text display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                }
                .padding()
                
                // Buttons
                ForEach(btns, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button {
                                self.btnTap(btn: item)
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                    .background(item.btnColor)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            }
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func btnTap(btn: CalculateBtn) {
        switch btn {
        case .divide, .multiply, .subtract, .add, .equal:
            if btn == .add {
                self.currentOperation = .add
                self.runningNumber = Int(value) ?? 0
            } else if btn == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(value) ?? 0
            } else if btn == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(value) ?? 0
            } else if btn == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(value) ?? 0
            } else if btn == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            
            if btn != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .negative, .percent:
            break
        default:
            let number = btn.rawValue
            if value == "0" {
                value = number
            } else {
                value = "\(value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalculateBtn) -> CGFloat {
        if item == .zero {
            return (UIScreen.main.bounds.width - 4*12) / 2
        }
        return (UIScreen.main.bounds.width - 5*12) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5*12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
