import Fluent
import Vapor
import BogusApp_Common_Models

final class FeeBenefitEntity: Model, Content {
    static let schema = "fees"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "feeId")
    var feeId: FeeEntity.IDValue
    
    @Field(key: "benefitId")
    var benefitId: String
    
    var fee: Parent<FeeBenefitEntity, FeeEntity> {
        return parent(\.feeId)
    }
}
 
