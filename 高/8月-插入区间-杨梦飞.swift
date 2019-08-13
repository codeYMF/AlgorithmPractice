//
//  插入区间.swift
//  LeetCode
//
//  Created by yang on 2019/8/12.
//  Copyright © 2019年 yang. All rights reserved.
//

import Foundation

// 首先将intervals和newInterval组合成一个新的数组，然后按照起始点进行升序排序
// 取出新数组中的第一个元素放入result中，然后对数组进行遍历，
// 根据有无重叠区域确定是直接插入到result中还是修改result中已有的元素

func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
    // 当intervals为空时，直接返回newInterval组成的数组
    if intervals.count == 0 {
        return [newInterval]
    }
    
    // 将 intervals和newInterval组成新的数组并排序
    var newIntervals:[[Int]] = intervals
    newIntervals.append(newInterval)
    
    newIntervals = newIntervals.sorted { (first, second) -> Bool in
        return first[0] < second[0]
    }
    
    var result = [[Int]]()
    result.append(newIntervals.first!)
    
    for interval in newIntervals {
        var last = result.last!
        if last[1] < interval[0] { // result中最后一个元素与interval无重叠区域，直接插入result数组
            result.append(interval)
        } else if last[1] <= interval[1] { // 有重叠区域，且result数组最后一个元素的区域较小，则扩大result最后一个元素的区域
            let newLast = [last[0], interval[1]]
            result.removeLast()
            result.append(newLast)
        }
        
    }
    
    return result
}

