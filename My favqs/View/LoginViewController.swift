//
//  LoginViewController.swift
//  My favqs
//
//  Created by Valentin Limagne on 15/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import Rswift

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        if let token = UserDefaultsHelper.getToken(), let login = UserDefaultsHelper.getLogin() {
            RequestManager.sharedInstance.headers["User-Token"] = token
            RequestManager.sharedInstance.whoAmI(username: login) { result in
                switch result {
                case .success(let user):
                    User.currentUser = user
                    let homeViewController = R.storyboard.main.homeViewController()
                    homeViewController?.modalPresentationStyle = .fullScreen
                    self.show(homeViewController!, sender: self)
                case .failure(_):
                    return
                }
            }
        }
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        guard let username = loginTextField.text, let password = passwordTextField.text else {
            return
        }
        
        _ = UIViewController.displaySpinner(onView: self.view)
        RequestManager.sharedInstance.login(username: username, password: password) { result in
            switch result {
            case .success(let user):
                guard let safeToken = user.userToken, let safeLogin = user.login else {
                    return
                }
                
                RequestManager.sharedInstance.headers["User-Token"] = safeToken
                UserDefaultsHelper.set(token: safeToken)
                UserDefaultsHelper.set(login: safeLogin)
                
                RequestManager.sharedInstance.whoAmI(username: safeLogin) { result in
                    switch result {
                    case .success(let user):
                        User.currentUser = user
                        let homeViewController = R.storyboard.main.homeViewController()
                        homeViewController?.modalPresentationStyle = .fullScreen
                        self.show(homeViewController!, sender: self)
                    case .failure(_):
                        return
                    }
                }
                
            case .failure(_):
                return
            }
        }
        
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == loginTextField) {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
