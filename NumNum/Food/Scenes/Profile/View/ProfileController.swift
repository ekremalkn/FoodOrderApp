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
    
    @IBOutlet weak var signOutButton: UIButton!
    
    let profileViewModel = ProfileViewModel()
    
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        profileViewModel.delegate = self
        profileViewModel.fetchUser()
        signOutButton.layer.cornerRadius = 15
        table.separatorStyle = .none
    }
    
    //MARK: - Button Actions

    @IBAction func signOutButton(_ sender: UIButton) {
        profileViewModel.signOut()
        goLogInScreen()
    }
    
    private func goLogInScreen() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LogInController") as! LogInController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    //MARK: - TableViewSetup

    private func tableViewSetup() {
        table.register(UINib(nibName: "\(ProfileViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(ProfileViewCell.self)")
    }
    
}

//MARK: - ProfileViewModelDelegate

extension ProfileController: ProfileViewModelDelegate {
    func errorDidOccur(error: Error) {
        print(error.localizedDescription)
    }
    
    func didSignOutSuccesful() {
        
    }
}

//MARK: - TableViewMethods

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(ProfileViewCell.self)") as! ProfileViewCell
        cell.configure(data: profileViewModel.email!)
        return cell
    }
    
}
