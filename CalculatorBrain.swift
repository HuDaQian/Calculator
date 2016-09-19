//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jie on 16/9/9.
//  Copyright © 2016年 com.HuXiaoQian. All rights reserved.
//

import Foundation

class CalculatorBrain {
    enum Op {
        case Operand(Double)
        case UnaryOperation(String,(Double) -> Double)
        case BinaryOperation(String,(Double,Double) -> Double)
    }
    private var opStack = [Op]()
    private var knowOps = [String:Op]()
    init() {
        knowOps["×"] = Op.BinaryOperation("×", *)
        knowOps["÷"] = Op.BinaryOperation("÷", {$1 / $0})
        knowOps["−"] = Op.BinaryOperation("−", {$1 - $0})
        knowOps["+"] = Op.BinaryOperation("+", +)
        knowOps["√"] = Op.UnaryOperation("√", sqrt)
    }

    func pushOperand(operand:Double) {
        opStack.append(Op.Operand(operand))
    }
    func performOperation(symbol:String) {
        if let operation = knowOps[symbol] {
            opStack.append(operation)
        }
    }
}
