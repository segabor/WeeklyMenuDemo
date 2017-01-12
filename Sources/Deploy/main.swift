import Foundation

import Kitura
import HeliumLogger
import LoggerAPI
import CloudFoundryEnv


Log.logger = HeliumLogger()
setbuf(stdout, nil)


do {
  let host: String, username: String, password: String, port: UInt16, database: String

  if let service = try CloudFoundryEnv.getAppEnv().getService(spec: "TodoList-MySQL") {

    // let host: String, username: String, password: String, port: UInt16, database: String

    if let credentials = service.credentials{
      host = credentials["hostname"] as! String
      username = credentials["username"] as! String
      password = credentials["password"] as! String
      port = UInt16(credentials["port"] as! String)!
      database = credentials["name"] as! String
    } else {
      host = "127.0.0.1"
      username = "root"
      password = ""
      port = UInt16(3306)
      database = "todolist"
    }

    let options = [String : AnyObject]()

    Log.verbose("Found TodoList-MySQL")
  } else {
    host = "127.0.0.1"
    username = "root"
    password = ""
    port = UInt16(3306)
    database = "todolist"

    Log.info("Could not find Bluemix MySQL service")
  }
} catch CloudFoundryEnvError.InvalidValue {
  Log.error("Oops... something went wrong. Server did not start.")
}
