//
//  Matrix.swift
//  Math system solver
//
//  Created by Denis Dobynda on 9/11/16.
//  Copyright © 2016 Denis Dobynda. All rights reserved.
//

import Foundation

class Matrix
{
    private var matrix: [[Double]] = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    
    private var originalMatrix: [[Double]] = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    
    private var equals: [Double] = [0,0,0,0]
    
    private var result: [Double] = [0,0,0,0]
    
    private var size: Int = 0
    
    private var EPS: Double = 0.0
    
    public func setMatrix (newMatrix: [[Double]], withSize newSize: Int)
    {
        matrix = newMatrix
        originalMatrix = newMatrix
        size = newSize
    }
    
    public func setEpsilon (newValue: Double)
    {
        EPS = newValue
    }
    
    public func setEquals ( newVector: [Double] ) -> Bool
    {
        if newVector.endIndex != size
        {
            return false
        }
        equals = newVector
        return true
    }
    
    public func getSize() -> Int
    {
        return size
    }
    
    public func getMatrix() -> [[Double]]
    {
        return matrix
    }
    
    public func getItem(i: Int, j: Int) -> Double
    {
        return matrix[i][j]
    }
    
    public func setItem(i: Int, j: Int, withItem item: Double) -> Bool
    {
        if i < size , j < size {
            matrix[i][j] = item
            originalMatrix[i][j] = item
            return true
        } else {
            return false
        }
    }
    
    public func getMatrixInString() -> String
    {
        var str: String = ""
        for i in 0..<size
        {
            for j in 0..<size
            {
                str += "\(originalMatrix[i][j]); "
            }
            str += "  =  \(equals[i]) \n"
        }
        
        return str
    }
    
    public func getResultInString() -> String
    {
        var str: String = ""
        
        for i in 0..<size
        {
            str += "X[\(i+1)] = \(result[i]); \n"
        }
        return str
    }
    
    private func swapColumns (h: Int) -> Bool
    {
        if matrix[h][h] < 0.000001 {
            for i in h..<size
            {
                if matrix[i][h] > 0.000001 {
                    swap(&matrix[h], &matrix[i])
                    return true
                }
            }
            return false
        }
        return true
    }
    
    public func tryToSolve() -> Bool
    {
        for h in 0...2
        {
            let for0 = matrix[h][h]
            equals[h] /= for0
            for i in h..<size
            {
                matrix[h][i] /= for0
            }
            
            for i in h+1..<size
            {
                let forZero = matrix[i][h]
                for j in h..<size
                {
                    matrix[i][j] -= matrix[h][j] * forZero
                }
                equals[i] -= equals[h] * forZero
            }
            
            if !swapColumns(h: h) { return false }
            
        }
        result[3] = equals[3] / matrix[3][3]
        result[2] = equals[3] - matrix[2][3] * result[3]
        result[1] = equals[1] - matrix[1][3] * result[3] - matrix[1][2] * result[2]
        result[0] = equals[0] - matrix[0][3] * result[3] - matrix[0][2] * result[2] - matrix[0][1] * result[1]
        
        return isGood()
    }
    
    public func isGood() -> Bool
    {
        for i in 0..<size
        {
            var left: Double = 0.0
            
            for j in 0..<size
            {
                left += (originalMatrix[i][j]) * result[j]
            }
            
            if ( Double.abs( left - equals[i] ) > EPS)
            {
                return false
            }
        }
        
        return true
    }
    
    
}
