//
//  WeeklyMenuController.swift
//  WeeklyMenuKitura
//
//  Created by Gábor Sebestyén on 2017. 01. 15..
//
//

import Foundation

import Kitura

import SwiftyJSON

public final class WeeklyMenuController {
  
  let repository : WeeklyMenuRepository

  public init(repository : WeeklyMenuRepository, router : Router) {
    
    self.repository = repository
    
    // configure routes
    router.get("/api/weeklymenu") { request, response, _ in
      try self.showWeeklyMenu(request: request, response: response)
    }
  }

  public func showWeeklyMenu(request: RouterRequest, response: RouterResponse) throws {
    let menuList = try repository.findAll()
    
    let resp : JSONDictionary = ["data": ["menu": menuList.toDictionary() ] ]
    try response.status(.OK).send( json: JSON(resp) ).end()
  }

}
