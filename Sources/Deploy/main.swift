import Foundation

import Kitura
import LoggerAPI
import Configuration
import CloudFoundryEnv
import CloudFoundryConfig

import MySQL

import SwiftyJSON
import WeeklyMenuDemo

public let router = Router()
public var port: Int = 8080

// Start coding here
public let manager = ConfigurationManager()
manager.load(file: "config.json", relativeFrom: .project)
       .load(.environmentVariables)

port = manager.port


let dbConfig = try! manager.getMySQLService(name: "WeeklyMenuDB")
let db = try! MySQL.Database(
  host:     dbConfig.host,
  user:     dbConfig.username,
  password: dbConfig.password,
  database: dbConfig.database)


let repo = WeeklyMenuRepository(database: db)


router.get("/api/weeklymenu") {
  request, response, next in
  
  do {
    let menuList = try repo.findAll()
    
    let resp : [String:Any] = ["data": ["menu": menuList ] ]
    try response.status(.OK).send( json: JSON(resp) ).end()
  } catch {
    Log.error("Failed to fetch data from repository: \(error.localizedDescription)")
    
    try response.status(.internalServerError).send(json: JSON(["error":"DB Error"])).end()
  }
}
// End of your code

Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
