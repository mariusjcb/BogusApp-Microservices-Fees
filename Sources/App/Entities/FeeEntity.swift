import Fluent
import Vapor
import BogusApp_Common_Models

final class FeeEntity: Model, Content {
    static let schema = "fees"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "price")
    var price: Double
    
    @Field(key: "type")
    var type: FeeType

    init() { }
    
    init(_ fee: Fee) {
        self.id = fee.id
        self.price = fee.price
        self.type = fee.type
    }

    init(id: UUID, price: Double, type: FeeType) {
        self.id = id
        self.price = price
        self.type = type
    }
    
    func convert(linking benefits: [Benefit]) -> Fee {
        .init(id: id ?? UUID(), price: price, benefits: benefits, type: type)
    }
}

extension Fee: Content { }
