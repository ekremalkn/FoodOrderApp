//
//  ProfileViewModel.swift
//  NumNum
//
//  Created by Ekrem Alkan on 25.12.2022.
//

import Foundation
import Firebase

protocol ProfileViewModelDelegate: AnyObject {
    func errorDidOccur(error: Error)
    func didSignOutSuccesful()
}

class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    let currentUser = Auth.auth().currentUser
    
    var username: String?
    var email: String?
    
    //MARK: - FetchUserInfo from firebase

    func fetchUser() {
        if let currentUser {
            username = currentUser.displayName
            email = currentUser.email
        }
    }
    
    //MARK: - SignOut methods

    func signOut() {
        do {
            try  Auth.auth().signOut()
            delegate?.didSignOutSuccesful()
        } catch {
            delegate?.errorDidOccur(error: error)
            
            
        }
    }
}
