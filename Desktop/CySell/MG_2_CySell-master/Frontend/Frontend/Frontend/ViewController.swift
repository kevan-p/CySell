
import UIKit
import Alamofire
import FacebookLogin
import FBSDKLoginKit


var firstName : String? = ""
var profileID : String? = ""

/// This is a ViewController for the main page.
class ViewController: UIViewController {
    

    
    @IBAction func TicketsButton(_ sender: UIButton) {
    }
    
    @IBAction func ElectronicsButton(_ sender: UIButton) {
    }
    @IBAction func FurnitureButton(_ sender: UIButton) {
    }
    
    @IBAction func BooksButton(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let _ = FBSDKAccessToken.current() {
            profileFetch()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func profileFetch() {
        print("fetch profile")
        
        let parameters = ["fields": "email, id, first_name, last_name, picture.width(480).height(480)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters)?.start(completionHandler: { (connection, result, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            else {
                guard let data = result as? [String:Any] else { return }
                
                let facebookFirst = data["first_name"]
                let facebookID    = data["id"]
                
            
                
                firstName = facebookFirst as! String
                profileID = facebookID as! String
                
            }
            
            print(result ?? "result")
        })
    }
}
