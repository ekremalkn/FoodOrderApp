//
//  SignUpController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 17.12.2022.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    
    let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
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
    
    //MARK: - ConfigureUI elements

    private func configureUI() {
        signUpButton.layer.cornerRadius = 15
        emailTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
    }
   
}
