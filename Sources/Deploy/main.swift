import Foundation

import Kitura
import LoggerAPI
import Configuration
import CloudFoundryEnv
import CloudFoundryConfig

import MySQL

public let router = Router()
public var port: Int = 8080

// Start coding here

// End of your code

Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
