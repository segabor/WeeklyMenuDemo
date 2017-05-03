//
//  WeeklyMenuRepository.swift
//  WeeklyMenuKitura
//
//  Created by Gábor Sebestyén on 2017. 01. 14..
//
//

import Foundation

import MySQL


public final class WeeklyMenuRepository {
  
  let database: MySQL.Database
  
  public init(database: MySQL.Database) {
    self.database = database
  }

  public func findAll() throws -> [[String:Any]] {
    let resultSet: [[String: Node]] = try database.execute("select id, title, subtitle, description, imgUrl from menu")
    
    var menuItems = [[String:Any]]()
    
    resultSet.forEach { entry in
      if
        let id = entry["id"]?.string,
        let title = entry["title"]?.string,
        let subtitle = entry["subtitle"]?.string,
        let description = entry["description"]?.string,
        let imgUrl = entry["imgUrl"]?.string
      {
        menuItems.append(["id": id, "title": title, "subtitle": subtitle, "description": description, "imgUrl": imgUrl])
      }
    }
    
    return menuItems
  }
}
