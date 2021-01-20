import Fluent
import Vapor
import BogusApp_Common_Models

final class FeeBenefitEntity: Model, Content {
    static let schema = "fees"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "feeIds")
    var feeIds: FeeEntity.ID
    
    @Field(key: "benefitIds")
    var benefitIds: String
    
    var fee: Parent<FeeBenefitEntity, Fee> {
        
    }
}
 
