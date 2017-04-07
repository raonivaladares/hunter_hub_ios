import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SignUpViewController: ViewController {
  
  override func viewDidLoad() {
    
  }
 
  // MARK: View life-cycle
  // MARK: Segue
  // MARK: Action handlers
  @IBAction func buttonFacebookAction(_ sender: UIButton) {
    FacebookAPI.sharedInstance.login(viewController: self) { result in
      print(result)
    }
    
//    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
//    fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
//      if (error == nil){
//        let fbloginresult : FBSDKLoginManagerLoginResult = result!
//        if(fbloginresult.grantedPermissions.contains("email"))
//        {
//          self.getFBUserData()
//        }
//      }
//    }
  }
  // MARK: Extensions
  // MARK: Public methods
  // MARK: Private methods
  func getFBUserData(){
    if((FBSDKAccessToken.current()) != nil){
      FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
        if (error == nil){
          //everything works print the user data
          if let result = result {
            if let user = User(data: result) {
                print(user)
            } else {
              print("Error")
            }
            
          }
        }
      })
    }
  }
}
