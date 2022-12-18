//
//  SignUpController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 17.12.2022.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - CreateUser Method Firebase
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        if emailTextField.text != nil {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { data, error in
                
                if error != nil {
                    DuplicateFuncs.alertMessage(title: "Hata!", message: "Email kısmını uygun formatta doldurunuz.", vc: self)
                } else {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "LogInController") as! LogInController
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true)
                }
            }
        }
        
    }
    
   
    
    
}
