//
//  ViewModel.swift
//  RxSwiftSample
//
//  Created by 内村祐之 on 2016/07/03.
//  Copyright © 2016年 ucuc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    enum Method {
        case Add
        case Minus
        case Multiple
        case Devide
    }
    
    var numberText = Variable<String>("0")
    var tmpNumberText = "0"
    
    var calcMode: ((x: Double, y: Double) -> Double)?
    
    func addNumber(number: String) {
        if numberText.value == "0" {
            numberText.value = ""
        }
        
        numberText.value += number
        guard let value = Double(numberText.value) else { return }
        numberText.value = String(format: "%g", value)
    }
    
    func prepareCalc(method: Method) {
        switch method {
        case .Add:
            calcMode = { $1 + $0 }
        case .Minus:
            calcMode = { $1 - $0 }
        case .Multiple:
            calcMode = { $1 * $0 }
        case .Devide:
            calcMode = { $1 / $0 }
        }
        
        tmpNumberText = numberText.value
        numberText.value = "0"
    }
    
    func calc() {
        guard let calcMode = calcMode,
            currentNumber = Double(numberText.value),
            preNumber = Double(tmpNumberText) else {
                print("error")
                return
        }
        numberText.value = String(format: "%g", calcMode(x: currentNumber, y: preNumber))
    }

    func clear() {
        tmpNumberText = "0"
        numberText.value = "0"
    }
}