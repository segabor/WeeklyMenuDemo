import Foundation

import Kitura
import HeliumLogger
import LoggerAPI
import CloudFoundryEnv

import MySQL

Log.logger = HeliumLogger()
setbuf(stdout, nil)

struct DbConfig {
  let host: String
  let username: String
  let password: String
  let port: UInt16
  let database: String
}

let localConfig = DbConfig(host: "127.0.0.1", username: "root", password: "", port: 3306, database: "todolist")

var dbConfig : DbConfig?



do {
  // ----- //
  
  if let service = try CloudFoundryEnv.getAppEnv().getService(spec: "TodoList-MySQL") {

    if let creds = service.credentials {
      // Cloud DB Config

      dbConfig = DbConfig(host: creds["hostname"] as! String,
                  username: creds["username"] as! String,
                  password: creds["password"] as! String,
                  port: UInt16(creds["port"] as! String)!,
                  database: creds["name"] as! String)

      Log.verbose("Found Cloud DB")
    } else {
      Log.error("Missing Service Configuration!")
    }

  } else {
    dbConfig = localConfig

    Log.info("Could not find Bluemix MySQL service")
    Log.info("Running Local mode")
  }
  
} catch CloudFoundryEnvError.InvalidValue {
  Log.error("Oops... something went wrong. Server did not start.")
}





// ----- //
var db : MySQL.Database?

if let config = dbConfig {
  db = try MySQL.Database(
    host:     config.host,
    user:     config.username,
    password: config.password,
    database: config.database
  )
  // let connection = try mysql.makeConnection()
}
