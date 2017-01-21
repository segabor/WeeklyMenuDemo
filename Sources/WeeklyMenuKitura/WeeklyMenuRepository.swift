//
//  WeeklyMenuRepository.swift
//  WeeklyMenuKitura
//
//  Created by Gábor Sebestyén on 2017. 01. 14..
//
//

import Foundation

import MySQL

public struct Menu {
  let id: String
  let title: String
  let subtitle: String
  let description: String
  let imgUrl: String
}

extension Menu : DictionaryConvertible {
  public func toDictionary() -> JSONDictionary {
    var dict = JSONDictionary()
    
    dict["id"] = self.id
    dict["title"] = self.title
    dict["subtitle"] = self.subtitle
    dict["description"] = self.description
    dict["imgUrl"] = self.imgUrl
    
    return dict
  }
}



public final class WeeklyMenuRepository {
  
  let database: MySQL.Database
  
  public init(database: MySQL.Database) {
    self.database = database
  }

  public func findAll() throws -> [Menu] {
    let resultSet: [[String: Node]] = try database.execute("select id, title, subtitle, description, imgUrl from menu")
    
    var menuItems = [Menu]()
    
    resultSet.forEach { entry in
      if
        let id = entry["id"]?.string,
        let title = entry["title"]?.string,
        let subtitle = entry["subtitle"]?.string,
        let description = entry["description"]?.string,
        let imgUrl = entry["imgUrl"]?.string
      {
        menuItems.append( Menu(id: id, title: title, subtitle: subtitle, description: description, imgUrl: imgUrl))
      }
    }
    
    return menuItems
  }
}
