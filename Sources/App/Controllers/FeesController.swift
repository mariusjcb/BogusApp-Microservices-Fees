import Fluent
import Vapor
import BogusApp_Common_Models

struct FeesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let fees = routes.grouped("")
        fees.get(use: index)
    }

    func index(req: Request) throws -> EventLoopFuture<[Fee]> {
        return FeeEntity.query(on: req.db).all()
            .sequencedFlatMapEachCompact { fee -> EventLoopFuture<Fee?> in
                self.fetchBenefits(req: req, for: fee.id!)
                    .map { Fee(id: fee.id!, price: fee.price, benefits: $0, type: fee.type) }
            }
    }

    func fetchBenefits(req: Request, for benefitId: UUID) -> EventLoopFuture<[Benefit]> {
        var url = URI(string: Microservices.benefits.host ?? "")
        url.path = benefitId.uuidString
        let request = ClientRequest(method: .GET, url: url, headers: HTTPHeaders(), body: nil)
        return req.client.send(request).map {
            try! JSONDecoder().decode([Benefit].self, from: $0.body!)
        }
    }
}
