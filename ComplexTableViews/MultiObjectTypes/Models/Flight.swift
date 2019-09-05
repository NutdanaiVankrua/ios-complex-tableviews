import Foundation

class Flight {
    let code: String
    let plane: String
    let seat: String
    
    init(
        code: String,
        plane: String,
        seat: String
    ) {
        self.code = code
        self.plane = plane
        self.seat = seat
    }
}
