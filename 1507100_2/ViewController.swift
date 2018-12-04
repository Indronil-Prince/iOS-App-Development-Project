//
//  ViewController.swift
//  1507100_2
//
//  Created by kuet on 15/11/18.
//  Copyright © 2018 kuet. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet fileprivate var signInUsernameField: UITextField!
    @IBOutlet fileprivate var signInPasswordField: UITextField!
    @IBOutlet fileprivate var signUpUsernameField: UITextField!
    @IBOutlet fileprivate var signUpPasswordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        signInUsernameField.text = ""
        signInPasswordField.text = ""
        signUpUsernameField.text = ""
        signUpPasswordField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = PFUser.current()
        if currentUser != nil {
            loadHomeScreen()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "LoggedInViewController") as! LoggedInViewController
        self.present(loggedInViewController, animated: true, completion: nil)
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        //let sv = UIViewController.displaySpinner(onView: self.view)
        PFUser.logInWithUsername(inBackground: signInUsernameField.text!, password: signInPasswordField.text!) { (user, error) in
            //UIViewController.removeSpinner(spinner: sv)
            if user != nil {
                
                self.performSegue(withIdentifier: "toLoggedIn", sender: self)
                
            }else{
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: (descrip))
                }
            }
        }
        
    }
    
    
    @IBAction func signUp(_ sender: UIButton) {
        let user = PFUser()
        user.username = signUpUsernameField.text
        user.password = signUpPasswordField.text
        let sv = UIViewController.displaySpinner(onView: self.view)
        user.signUpInBackground { (success, error) in
            UIViewController.removeSpinner(spinner: sv)
            if success{
                self.loadHomeScreen()
            }else{
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: descrip)
                }
            }
        }
    }
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }

}

