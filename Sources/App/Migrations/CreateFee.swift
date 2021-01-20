import Fluent
import BogusApp_Common_Models

struct CreateFee: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("fees")
            .id()
            .field("name", .string, .required)
            .field("price", .json, .required)
            .field("type", .json, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("fees").delete()
    }
}
