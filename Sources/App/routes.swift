import Fluent
import Vapor

enum Microservices: String, CaseIterable {
    case benefits
}

extension Microservices {
    var path: String {
        return rawValue
    }
    
    var host: String? {
        return Environment.get(self.rawValue.uppercased() + "_HOST")
    }
}

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    try app.register(collection: TodoController())
}
