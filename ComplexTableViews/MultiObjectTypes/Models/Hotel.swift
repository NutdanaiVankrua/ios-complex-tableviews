import Foundation

class Hotel {
    let name: String
    let phone: String
    let email: String
    let city: String
    
    init(
        name: String,
        phone: String,
        email: String,
        city: String
    ) {
        self.name = name
        self.phone = phone
        self.email = email
        self.city = city
    }
}
