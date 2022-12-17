//
//  ProfileController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 17.12.2022.
//

import UIKit
import Firebase

class ProfileController: UIViewController {

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.separatorStyle = .singleLine
    }
    



}

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            try  Auth.auth().signOut()
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "LogInController") as! LogInController
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true)
        } catch {
            
        }
       
    }
    
    
}
