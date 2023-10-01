import UIKit
import Foundation

struct Contact: Codable {
//    var photoData: Data
    var fullName: String
    var phoneNumber: String
    var isFavourite: Bool = false
    
    init(
//        photoData: Data,
        fullName: String, phoneNumber: String) {
 //       self.photoData = photoData
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        
    }
}
