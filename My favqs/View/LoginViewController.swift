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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let token = UserDefaultsHelper.getToken(), let login = UserDefaultsHelper.getLogin() {
            if NetworkManager.isConnected() {
                RequestManager.sharedInstance.headers["User-Token"] = token
                RequestManager.sharedInstance.whoAmI(username: login) { result in
                    switch result {
                    case .success(let user):
                        User.currentUser = user
                        UserDefaultsHelper.set(user: user)
                        self.goToHome()
                    case .failure(_):
                        return
                    }
                }
            } else {
                let user = UserDefaultsHelper.getUser()
                User.currentUser = user
                goToHome()
            }
        }
        
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        guard let username = loginTextField.text, let password = passwordTextField.text else {
            return
        }
        
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
                        self.goToHome()
                    case .failure(_):
                        return
                    }
                }
                
            case .failure(_):
                return
            }
        }
    }
    
    func goToHome() {
        let homeViewController = R.storyboard.main.homeViewController()
        homeViewController?.modalPresentationStyle = .fullScreen
        self.show(homeViewController!, sender: self)
        //self.present(homeViewController!, animated: true, completion: nil)
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
