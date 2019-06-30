//
//  戳气球.swift
//  LeetCode
//
//  Created by yang on 2019/6/22.
//  Copyright © 2019年 yang. All rights reserved.
//

import Foundation


/*
 此问题采用动态规划的方法
 推算状态转移方程，
     dp[i][j]代表戳破第i个和第j个气球区间内所获得的最大气球的数量
     假设k是i，j区间内的一个气球满足i<= k <= j, 且K气球最后被戳破
     则区间被分成了 [i][k - 1], [k], [k + 1][j] 三个区间
     正常情况下k被戳破时的得分为 coins[k - 1] * coins[k] * coins[k + 1]
     然而k是最后一个被戳破的，[i][k - 1]，[k + 1][j] 区间的气球都已经不存在，只能取其相邻的[i - 1]和[j + 1]
     所以k在[i][j]区间内最后被戳破的得分为 coins[i - 1] * coins[k] * coins[j + 1]
     加上之前的得分得出总得分为：dp[i][k - 1] + dp[k + 1][j] + coins[i - 1] * coins[k] * coins[j + 1]
 所以状态转移方程为：
    dp[i][j] = max(dp[i][j], dp[i][k - 1] + dp[k + 1][j] + coins[i - 1] * coins[k] * coins[j + 1])
 
 */

func maxCoins(_ nums: [Int]) -> Int {
    if nums.count == 0 {
        return 0
    }
    
    // 补全金币数组的值
    var coins = nums
    coins.insert(1, at: 0)
    coins.append(1)
    
    let n = nums.count
    // 填充数组初始值
    var dp = Array(repeating: Array(repeating: 0, count: coins.count), count: coins.count)
    
    
    for len in 1...n   {    // 表示气球数量从1...n不断的扩大
        // 动态扩大戳破气球的范围
        // 先获得小范围的数据如dp[1][1],dp[2][2]...，再依次推断出大范围的数据dp[1][2]...dp[1][n]
        for i in 1...n - len + 1   {
            let j = i + len - 1
            for k in i...j  {
                dp[i][j] = max(dp[i][j], dp[i][k - 1] + dp[k + 1][j] + coins[i - 1] * coins[k] * coins[j + 1])
            }
        }
    }
    
    return dp[1][n]
}
