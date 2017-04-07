import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookAPI {
  enum Result {
    case canceled
    case error(title: String, message: String)
    case success(response: String)
  }
  
  static let sharedInstance = FacebookAPI()
  
  let permissions = ["fields": "id, first_name, last_name, picture.type(large), email"]
  
  func login(viewController: ViewController, completionHandler: @escaping (Result) -> Void) {
    let loginManager = FBSDKLoginManager()
    
    loginManager.logIn(withReadPermissions: ["email"], from: viewController) { (result, error) -> Void in
      if let error = error {
       print("Facebook login error: \(error)")
        loginManager.logOut()
        completionHandler(.error(title: "aaa", message: "aaaa"))
      } else if result?.isCancelled == true {
        loginManager.logOut()
        completionHandler(.canceled)
      } else {
        let token = result?.token
        print("Facebook user id: \(token?.userID)")
        print("Facebook user token: \(token?.tokenString)")
        //completionHandler(.success(response: "Logou"))
        self.requestFBUserData(completionHandler: completionHandler)
      }
    }
  }
  
  private func requestFBUserData(completionHandler: @escaping (Result) -> Void) {
    if((FBSDKAccessToken.current()) != nil) {
      FBSDKGraphRequest(graphPath: "me", parameters: permissions).start(completionHandler: { (connection, result, error) -> Void in
        if (error == nil){
          //everything works print the user data
          if let result = result {
            if let user = User(data: result) {
              print(user)
              completionHandler(.success(response: "Logou"))
            } else {
              print("Error")
              completionHandler(.error(title: "aaa", message: "aaaa"))
            }
          }
        } else {
          completionHandler(.error(title: "aaa", message: "aaaa"))
        }
      })
    }
  }
}
