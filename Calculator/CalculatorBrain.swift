//
//  CalculatorBrain.swift
//  Swift Test
//
//  Created by Joann Lin on 4/2/17.
//  Copyright © 2017 Joann Lin. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    // structs have automatic initializers
    private var accumulator: Double?
    
    private enum Operation {
        case digit(Int)
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case clear
    }
    
    private var operations: Dictionary<String, Operation> =
    [
    "C" : Operation.clear,
    "0" : Operation.digit(0),
    "1" : Operation.digit(1),
    "2" : Operation.digit(2),
    "3" : Operation.digit(3),
    "4" : Operation.digit(40),
    "5" : Operation.digit(5),
    "6" : Operation.digit(6),
    "7" : Operation.digit(7),
    "8" : Operation.digit(8),
    "9" : Operation.digit(9),
    "π" : Operation.constant(Double.pi),
    "e" : Operation.constant(M_E),
    "√" : Operation.unaryOperation(sqrt),
    "cos" : Operation.unaryOperation(cos),
    "±" : Operation.unaryOperation({ -$0 }),        //inline functions
    "×" : Operation.binaryOperation({ $0 * $1 }),   //AKA closures
    "+" : Operation.binaryOperation({ $0 + $1 }),
    "-" : Operation.binaryOperation({ $0 - $1 }),
    "÷" : Operation.binaryOperation({ $0 / $1 }),
    "=" : Operation.equals
    ]
    
    private var pendingbinaryoperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    // in structs, if it changes value of struct's property, need to mark it as mutating
    mutating private func performPendingBinaryOperation() {
        if pendingbinaryoperation != nil && accumulator != nil {
            accumulator = pendingbinaryoperation!.perform(with: accumulator!)
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .digit(let digit):
                accumulator = Double(digit)
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!);
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingbinaryoperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            case .clear:
                accumulator = nil;
            }
        }
    }
    
    
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
