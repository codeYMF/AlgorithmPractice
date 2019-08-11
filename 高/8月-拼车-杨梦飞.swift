//
//  拼车.swift
//  LeetCode
//
//  Created by yang on 2019/8/11.
//  Copyright © 2019年 yang. All rights reserved.
//

import Foundation

 // 将每个乘车点需要上或则下的人数提前计算出来，放在一个数组中，数组的个数由最大乘车点的值决定,
 // 最后遍历数组，计算出每个乘车点的真实人数与最大容量进行比较即可

func carPooling(_ trips: [[Int]], _ capacity: Int) -> Bool {
    // 遍历数组，找到最大的乘车点的值
    var count = 0
    for trip in trips {
        count = max(count, trip[1])
        count = max(count, trip[2])
    }
    var paths:[Int] = Array(repeating: 0, count: count)
    // 遍历计算出每个乘车点需要上或下的人数， 此处的结果已经符合了线下后上的原则
    for trip in trips {
        paths[trip[1] - 1] += trip[0]
        paths[trip[2] - 1] -= trip[0]
    }
    
    // 遍历乘车点数组，计算出每个乘车点车上的人数，并与容量进行比较
    var currentPeople = 0
    for path in paths {
        currentPeople += path
        if currentPeople > capacity {
            return false
        }
    }
    
    return true
    
}
