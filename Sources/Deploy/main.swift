import Foundation

import Kitura
import HeliumLogger
import LoggerAPI
import CloudFoundryEnv

import MySQL

Log.logger = HeliumLogger()
setbuf(stdout, nil)

// --- MAIN --- //


func configureDatabase() -> MySQL.Database? {
  var dbConfig : (host: String, username: String, password: String, port: UInt16, database: String)?

  do {
    // ----- //
    
    if let service = try CloudFoundryEnv.getAppEnv().getService(spec: "TodoList-MySQL") {
      
      if let creds = service.credentials {
        // Cloud DB Config
        Log.verbose("Found Cloud DB")
        
        dbConfig = (host: creds["hostname"] as! String,
                    username: creds["username"] as! String,
                    password: creds["password"] as! String,
                    port: UInt16(creds["port"] as! String)!,
                    database: creds["name"] as! String)
        
      } else {
        Log.error("Missing Cloud Service Configuration!")
      }
      
    } else {
      // Local DB Config
      Log.info("Running Local mode")
      
      dbConfig = (host: "127.0.0.1",
                  username: "root",
                  password: "",
                  port: 3306,
                  database: "todolist")
    }
    
  } catch CloudFoundryEnvError.InvalidValue {
    Log.error("Oops... something went wrong.")
  } catch {
    Log.error("Something unexpected happened: \(error.localizedDescription)")
  }

  
  guard
    let config = dbConfig,
    let db = try? MySQL.Database(
      host:     config.host,
      user:     config.username,
      password: config.password,
      database: config.database
    ) else {
      return nil
  }

  return db
}






// ----- //
