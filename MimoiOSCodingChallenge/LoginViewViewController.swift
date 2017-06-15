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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
    
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - IBAction
    
    @IBAction func login(_ sender: UIButton) {
        self.performRegister()
        
       // self.performLogin()
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
    fileprivate func performRegister() {
        self.view.endEditing(true)
        self.loading = true
        Auth0
            .authentication()
            .createUser(email: "priyank.working@gmail.com", username: "pgupta03", password: "priyank123", connection: "Username-Password-Authentication", userMetadata: ["first_name":"priyank","last_name": "gupta"])            .start { result in
                DispatchQueue.main.async {
                    self.loading = false
                    switch result {
                    case .success(let user):
                        self.showAlertForError(er: user.email as! String)

                      //  self.performSegue(withIdentifier: "DismissSignUp", sender: nil)
                    case .failure(let error):
                        self.showAlertForError(er: error as! String)
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
                         self.showAlertForError(er: error.localizedDescription)
                                         }
                }
        }
    }
    
    fileprivate func showAlertForError(er:String) {
        let alert = UIAlertController(title: "Alert", message: er  , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func loginWithCredentials(_ credentials: Credentials) {
        self.retrievedCredentials = credentials
        let viewController: SettingsViewController = SettingsViewController()
        self.present(viewController, animated: true, completion:nil)
    }
    
    fileprivate func validateForm() {
        self.loginButton.isEnabled = self.formIsValid
    }
    
    fileprivate var formIsValid: Bool {
        return self.emailTextField.hasText && self.passwordTextField.hasText
    }
    
    
}

 
