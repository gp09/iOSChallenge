//
//  LoginViewViewController.swift
//  MimoiOSCodingChallenge
//
//  Created by Priyank on 15/06/2017.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import UIKit
import Auth0

@objc class LoginViewViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet var actionButtons: [UIButton]!
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.actionButtons.forEach { $0.roundLaterals() }
      //  self.textFields.forEach { $0.setPlaceholderTextColor(.lightVioletColor()) }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - IBAction
    
    @IBAction func login(_ sender: UIButton) {
        self.performLogin()
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        self.validateForm()
    }
    
 
    // MARK: - Private
    
    fileprivate var retrievedCredentials: Credentials?
    
    fileprivate var loading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.loading {
                    self.spinner.startAnimating()
                    self.actionButtons.forEach { $0.isEnabled = false }
                } else {
                    self.spinner.stopAnimating()
                    self.actionButtons.forEach { $0.isEnabled = true }
                }
            }
        }
    }
    
    fileprivate func performLogin() {
        self.view.endEditing(true)
        self.loading = true
        Auth0
            .authentication()
            .login(
                usernameOrEmail: self.emailTextField.text!,
                password: self.passwordTextField.text!,
                realm: "Username-Password-Authentication",
                scope: "openid profile")
            .start { result in
                DispatchQueue.main.async {
                    self.loading = false
                    switch result {
                    case .success(let credentials):
                        self.loginWithCredentials(credentials)
                    case .failure(let error):
                        print("Failed")
                     //   self.showAlertForError(error)
                    }
                }
        }
    }
    
    
    fileprivate func loginWithCredentials(_ credentials: Credentials) {
        self.retrievedCredentials = credentials
        self.performSegue(withIdentifier: "ShowProfile", sender: nil)
    }
    
    fileprivate func validateForm() {
        self.loginButton.isEnabled = self.formIsValid
    }
    
    fileprivate var formIsValid: Bool {
        return self.emailTextField.hasText && self.passwordTextField.hasText
    }
    
}

 
