import PackageDescription

let package = Package(
    name: "WeeklyMenuDemo",
    targets: [
      Target(
        name: "Deploy",
        dependencies: ["WeeklyMenuDemo"]
      ),
      Target(name: "WeeklyMenuDemo")
    ],

    dependencies: [
      .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1),
      .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1),
      .Package(url: "https://github.com/vapor/mysql", majorVersion: 1),
      .Package(url: "https://github.com/IBM-Swift/CloudConfiguration.git", majorVersion: 2)
    ]
)
