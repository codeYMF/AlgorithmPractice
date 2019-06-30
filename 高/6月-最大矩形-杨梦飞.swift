//
//  最大矩形.swift
//  LeetCode
//
//  Created by yang on 2019/6/30.
//  Copyright © 2019年 yang. All rights reserved.
//

import Foundation

/*
    将二维数组的每一行都看成一个直方图，对每个直方图求出最大面积，然后取结果最大值
    构造直方图：如果遇到”0“则记为0，否则记为 height + 1
    计算每个直方图的最大面积：
        借助一个逐渐递增的栈，存放对应的index，
        如果插入的值大于栈顶元素对应的值则直接插入，否则将栈顶元素出战，并计算出移除元素到当前元素的面积，并取出最大值，直到条件不满足
        当遍历完所有数组时，栈内仍有元素，则对栈内元素进行处理
 
 */


class Solution {
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        if matrix.count == 0 || matrix[0].count == 0 {
            return 0
        }
        
        var maxRect = 0
        var height = Array(repeating: 0, count: matrix[0].count)
        for i in 0..<matrix.count {
            for j in 0..<matrix[0].count {
                height[j] = matrix[i][j] == "0" ? 0 : height[j] + 1
            }
            maxRect = max(maxRect, largestRectangleArea(heights: height))
        }
        
        return maxRect
    }
    
    
    func largestRectangleArea(heights:[Int]) -> Int {
        if heights.count == 0 {
            return 0
        }
        
        var stack = [Int]()
        var maxArea: Int = 0
        
        for i in 0..<heights.count {
            // 栈不为空且当前值小于等于栈顶元素
            while !stack.isEmpty &&  heights[i] <= heights[stack.last!] {
                // 计算移除元素到当前元素能获得的最大面积值
                let top = stack.last!
                stack.removeLast()
                let length = stack.isEmpty ? i : i - stack.last! - 1
                let currenArea = heights[top] * length
                maxArea = max(maxArea, currenArea)
            }
            stack.append(i)
         
        }
        
        let n = heights.count
        // 遍历完数组后，处理栈内剩余的值
        while !stack.isEmpty {
            let top = stack.last!
            stack.removeLast()
            
            let length = stack.isEmpty ? n : n - stack.last! - 1
            
            let currenArea = length * heights[top]
            maxArea = max(maxArea, currenArea)
        }
        
        return maxArea
    }
}
