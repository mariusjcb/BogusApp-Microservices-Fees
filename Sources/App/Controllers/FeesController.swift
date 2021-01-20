import Fluent
import Vapor
import BogusApp_Common_Models

struct FeesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let fees = routes.grouped("")
        fees.get(use: index)
        fees.post(use: create)
        fees.group(":id") { fee in
            fee.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Benefit]> {
        return FeeEntity.query(on: req.db).all().mapEach { $0.convert() }
    }

    func create(req: Request) throws -> EventLoopFuture<Benefit> {
        guard req.remoteAddress?.hostname == "127.0.0.1" else {
            Abort(.forbidden)
        }
        let fee = try req.content.decode(BenefitEntity.self)
        return fee.save(on: req.db).map { fee.convert() }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard req.remoteAddress?.hostname == "127.0.0.1" else {
            Abort(.forbidden)
        }
        return FeeEntity.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
