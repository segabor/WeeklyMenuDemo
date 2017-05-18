import Foundation

import Kitura
import LoggerAPI
import Configuration
import CloudFoundryEnv
import CloudFoundryConfig

import MySQL

import WeeklyMenuKitura

public let router = Router()
public let manager = ConfigurationManager()
public var port: Int = 8080

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

router.all("/images", middleware: StaticFileServer(path: "./images"))

let controller = WeeklyMenuController(repository: repo, router: router)

Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
