import Foundation
import Fluent
import BogusApp_Common_Models

struct InsertDemoBenefits: Migration {
    let fees: [Fee] = [
        
        // Facebook
        .init(id: UUID(), price: 140, benefits: [], type: .monthly),
        .init(id: UUID(), price: 200, benefits: [], type: .monthly),
        .init(id: UUID(), price: 100, benefits: [], type: .monthly),
        .init(id: UUID(), price: 75, benefits: [], type: .monthly),
        
        // LinkedIn
        .init(id: UUID(), price: 150, benefits: [], type: .monthly),
        .init(id: UUID(), price: 180, benefits: [], type: .monthly),
        .init(id: UUID(), price: 90, benefits: [], type: .monthly),
        .init(id: UUID(), price: 60, benefits: [], type: .monthly),
        
        // Twitter
        .init(id: UUID(), price: 170, benefits: [], type: .monthly),
        .init(id: UUID(), price: 250, benefits: [], type: .monthly),
        .init(id: UUID(), price: 120, benefits: [], type: .monthly),
        .init(id: UUID(), price: 80, benefits: [], type: .monthly),
        
        // Instagram
        .init(id: UUID(), price: 180, benefits: [], type: .monthly),
        .init(id: UUID(), price: 270, benefits: [], type: .monthly),
        .init(id: UUID(), price: 130, benefits: [], type: .monthly),
        .init(id: UUID(), price: 80, benefits: [], type: .monthly),
        
        // Google AdWords
        .init(id: UUID(), price: 150, benefits: [], type: .monthly),
        .init(id: UUID(), price: 230, benefits: [], type: .monthly),
        .init(id: UUID(), price: 90, benefits: [], type: .monthly),
        .init(id: UUID(), price: 80, benefits: [], type: .monthly),
        
        // SEO
        .init(id: UUID(), price: 270, benefits: [], type: .monthly),
        .init(id: UUID(), price: 320, benefits: [], type: .monthly),
        .init(id: UUID(), price: 180, benefits: [], type: .monthly),
        .init(id: UUID(), price: 110, benefits: [], type: .monthly),
    ]
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return benefits
            .map { elem in
                BenefitEntity
                    .query(on: database)
                    .filter(.string("name"), .equal, elem.name)
                    .filter(.string("price"), .equal, elem.type)
                    .filter(.string("type"), .equal, elem.type)
                    .delete()
            }.last!
    }
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return benefits
            .map { BenefitEntity($0) }
            .map { $0.save(on: database) }
            .last!
    }
}
