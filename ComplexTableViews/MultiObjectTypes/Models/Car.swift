import Foundation

class Car {
    let brand: String
    let engine: String
    let seats: Int
    let isHybrid: Bool
    
    init(
        brand: String,
        engine: String,
        seats: Int,
        isHybrid: Bool
    ) {
        self.brand = brand
        self.engine = engine
        self.seats = seats
        self.isHybrid = isHybrid
    }
}
