//
//  JSONSupport.swift
//  WeeklyMenuKitura
//
//  Created by Gábor Sebestyén on 2017. 01. 15..
//
//

import Foundation


public typealias JSONDictionary = [String : Any]


public protocol DictionaryConvertible {
  func toDictionary() -> JSONDictionary
}


extension Array where Element : DictionaryConvertible {
  func toDictionary() -> [JSONDictionary] {
    return self.map { $0.toDictionary() }
  }
}
