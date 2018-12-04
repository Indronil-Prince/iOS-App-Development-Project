//
//  RegViewController.swift
//  1507100_2
//
//  Created by kuet on 27/11/18.
//  Copyright © 2018 kuet. All rights reserved.
//

import UIKit

class RegViewController: UIViewController {

    @IBOutlet weak var userEmail: UIView!
    @IBOutlet weak var userPass: UITextField!
    @IBOutlet weak var userRePass: UITextField!
    @IBOutlet weak var userMail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func regTapped(_ sender: Any) {
        
        let userEmail = self.userMail.text;
        let userPassword = self.userPass.text
        let repeatPassword = self.userRePass.text;
        
        //Check for empty Fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (repeatPassword?.isEmpty)!)
        {
            //Display Alert Message
            displayMyAlertMessage(userMessage: "All fields are required!");
            return;
        }
        
        //Check if password match
        if(userPassword != repeatPassword)
        {
            //Display Alert msg
            displayMyAlertMessage(userMessage: "Password didn't match!");
            return;
        }
        
        //Store data
        
        let defaults = UserDefaults.standard;
        
        defaults.set(0, forKey: "numberOfUsers");
        
        defaults.set(userEmail, forKey: "userEmail");
        defaults.set(userPassword, forKey: "userPassword");
        
        //UserDefaults.standard.set(userEmail,forKey: value(forKey: "userEmail") as! String);
        //UserDefaults.standard.set(userPassword,forKey: value(forKey: "userPassword") as! String);
        //UserDefaults.standard.synchronize();
        
        //Display alert msg w/ user confirm
        displayMyAlertMessage(userMessage: "Registration Successfull!")
        
        
        navigateToSearch()
        
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle:UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion: nil);
        
    }
    
    private func navigateToSearch() {
        
        print("test")
        //present to navigationVC
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as? SthViewController
        self.navigationController?.pushViewController(mainStoryboard!,animated: true)
        
        guard let SthVC = mainStoryboard.instantiateViewController(withIdentifier: "SthViewController") as? SthViewController else{
            return;
        }
        
        present(SthVC, animated: true, completion: nil);
    
    }
    

}
