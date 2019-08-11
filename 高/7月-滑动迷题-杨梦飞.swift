//
//  滑动迷题.swift
//  swift测试
//
//  Created by yang on 2019/7/30.
//  Copyright © 2019 yang. All rights reserved.
//





// 某种状态下只有四种走法，上下左右移动，vistited记录遍历过的状态，防止重复遍历，
// 并在每次交换后记录下交换后的状态作为下一轮需要遍历的状态
// 在每次遍历前先判断是否已经求出解, 直到找出解或者遍历结束
func slidingPuzzle(_ board: [[Int]]) -> Int {
    
    var vistited = [[[Int]]]()                      // 存放已经遍历过的情况
    var p = [([[Int]], (Int, Int))]()               // 存放下一步即将要遍历的状态
    let dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]   // 存放可能移动的方向
    let target = [[1, 2, 3],[4, 5, 0]]              // 目标状态
   
    // 遍历出0的位置，并将瓦片的初始状态和0的位置记录到数组p中
    for i in 0..<2 {
        for j in 0..<3 {
            if board[i][j] == 0 {
                p.append((board,(i, j)))
            }
        }
    }
    
    var step:Int = 0
    
    while !p.isEmpty {
        for _ in 0..<p.count {
            let current = p.first!.0
            let zero = p.first!.1
            
            if current == target {
              return step
            }
            
            vistited.append(current)   // 记录已经遍历过的状态
            
            p.removeFirst()            // 删除即将要遍历的状态
            
            for dir in dirs {
                let x = zero.0 + dir.0   // 竖直方向
                let y = zero.1 + dir.1   // 水平方向
                
                if x < 0 || x >= 2 || y < 0 || y >= 3 { // 超出了移动的范围
                    continue
                }
                
                // 交换0和dir方向上的数字的位置
                var tempCurrent = current
                let temp = tempCurrent[x][y]
                tempCurrent[x][y] = 0
                tempCurrent[zero.0][zero.1] = temp
        
                if vistited.contains(tempCurrent) {    // 如果当前状态已经遍历过，直接跳过
                    continue
                }
                
                p.append((tempCurrent, (x,y))) // 将交换位置后的位置状态和 0的位置信息存到p中，以供下次使用
                
            }
        }
        
        step += 1
    }
    
    
    return -1
}
