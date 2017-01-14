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


public final class WeeklyMenuRepository {
  
  let connection: MySQL.Connection
  
  public init(connection: MySQL.Connection) {
    self.connection = connection
  }

  public func findAll() -> [Menu]? {
    guard let resultSet: [[String: Node]] = try? connection.execute("select id, title, subtitle, description, imgUrl from menu") else {
      return nil
    }
    
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
