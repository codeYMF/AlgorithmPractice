//
//  单词拆分.swift
//  LeetCode
//
//  Created by yang on 2019/7/28.
//  Copyright © 2019年 yang. All rights reserved.
//

import Foundation

//  首先查找出以每个字母开头的并且存在于字典中单词的个数及位置
//  然后通过找到的单词个数及位置的数组再遍历找到能够拼接的句子

func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {

    if s.isEmpty  || wordDict.isEmpty {
        return []
    }
    
    let wordsLengthSet = Set(wordDict.map{$0.count})   // 获取字典中字符的长度，并转换为set进行去重
    var wordsLengthArray = [Int]()                     // 存储去重后的字典中字符的长度
    for length in wordsLengthSet {
        wordsLengthArray.append(length)
    }
    var subLengths:[[Int]?] = Array(repeating: nil, count: s.count + 1)
    subLengths[0] = [Int]()
    let wordSet = Set(wordDict)

    // 从第一字符开始遍历，每次增加字典中字符长度，依次截取字符串，判断是否在字典中，
    // 若成立则记录进subLengths这个二维数组中，其中外层数组为字符的起始位置序号，内层数组为长度
    for i in 0..<s.count where subLengths[i] != nil  {
        for j in 0..<wordsLengthArray.count {
           let range = NSRange(location: i, length: wordsLengthArray[j])
            if i + wordsLengthArray[j] <= s.count && wordSet.contains((s as NSString).substring(with: range)) {
                subLengths[i]?.append(wordsLengthArray[j])
                if subLengths[i + wordsLengthArray[j]] == nil {
                    subLengths[i + wordsLengthArray[j]] = [Int]()
                }
            }
        }
    }

    if subLengths[s.count] == nil {
        return []
    }

    var result = [String]()
    var words = [String]()
    // 递归将字符拼接成句子
    getSentence(s, subLengths, 0, &result, &words)

    return result
}


func getSentence(_ s:String, _ subLengths: [[Int]?], _ start: Int, _ array: inout [String], _ words: inout [String] ) {
    // 当起始位置根字符串的长度相等时，退出递归，并将单词组成句子，存到array中
    if start == s.count {
        let con = words.joined(separator: " ")
        array.append(con)
        return
    }
    // 根据subLengths记录的位置和长度信息取出字符组成单词
    if let subLength = subLengths[start] {
        for length in subLength {
           let word = (s as NSString).substring(with: NSRange(location: start, length: length))
            words.append(word)
            getSentence(s, subLengths, start + length,  &array, &words)
            words.removeLast()  // 还原为进入递归前的状态，以免单词被重复添加进语句中
        }
    }
}

