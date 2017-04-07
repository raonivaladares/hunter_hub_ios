import Foundation
import SwiftyJSON

struct User {
  let firstName: String!
  let lastName: String!
  let email: String!
  
  init?(data: Any) {
    let json = JSON(data)
    
    guard let firstName = json["first_name"].string else {
      print("SignUp error: first_name")
      return nil
    }
    
    guard let lastName = json["last_name"].string else {
      print("SignUp error: last_name")
      return nil
    }
    
    guard let email = json["email"].string else {
      print("SignUp error: email")
      return nil
    }
    
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
  }
}
