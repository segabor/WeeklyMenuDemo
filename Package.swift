import PackageDescription

let package = Package(
    name: "WeeklyMenuKitura",
    targets: [
      Target(
        name: "Deploy",
        dependencies: ["WeeklyMenuKitura"]
      ),
      Target(
        name: "WeeklyMenuKitura"
      )
    ],

    dependencies: [
      .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 4),
      .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 4),
      .Package(url: "https://github.com/vapor/mysql", majorVersion: 1, minor: 0),
      .Package(url: "https://github.com/IBM-Swift/Swift-cfenv.git", majorVersion: 1, minor: 9)
    ]
)
