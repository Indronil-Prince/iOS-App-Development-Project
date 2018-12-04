//
//  LoginViewController.swift
//  1507100_2
//
//  Created by kuet on 15/11/18.
//  Copyright © 2018 kuet. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userEmail = emailTextField.text
        let userpassword = passwordTextField.text
        let storedEmail = UserDefaults.standard.string(forKey: "UserEmail")
        
        let storedPassword = UserDefaults.standard.string(forKey: "Userpassword")
        if(userEmail == storedEmail && userpassword == storedPassword){
            navigateToMainInterface();
        }
        
        navigateToMainInterface();
        
    }
    
    private func navigateToMainInterface() {
        
        //present to navigationVC
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else{
            return;
        }
        
        present(mainNavigationVC, animated: true, completion: nil);
        
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
