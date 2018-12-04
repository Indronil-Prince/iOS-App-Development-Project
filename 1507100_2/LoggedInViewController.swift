//
//  LoggedInViewController.swift
//  1507100_2
//
//  Created by kuet on 2/12/18.
//  Copyright © 2018 kuet. All rights reserved.
//

import Foundation
import Parse
import UIKit


class LoggedInViewController: UIViewController {
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        //appDelegate?.startPushNotifications()
    }
    
    @IBOutlet weak var SearchField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var s = ""
    struct Word :Decodable {
        var type: String?
        var definition: String?
        var example: String?
    }
    struct wordHis {
        var key: String?
        var def: String?
    }
    //JSONParsing start
    
    @IBAction func buttonTapped(_ sender: Any) {
            
            print(self.SearchField.text)
            let jsonUrlString = "https://owlbot.info/api/v2/dictionary/" + self.SearchField.text! + "?format=json&fbclid=IwAR16hWnHo5e20J2uJzn53C20wnn9HAAEmahRNVRwsUMKNAfIk7-iVufqFBQ"
            guard let url = URL(string:jsonUrlString) else
            { return }
        
            URLSession.shared.dataTask(with: url){
                (data, response, err) in
                if err != nil {
                    print(err!.localizedDescription)
                }
                guard let data = data else {return}
                
                do{
                    let words = try JSONDecoder().decode([Word].self, from: data)
                    
                    print("Muin")

                    for word in words{
                        var w = word
                        
                        //print(word.definition)
                        //print(word.example)
                        if word.example == nil{
                            w.example = ""
                        }
                        if word.type == nil{
                            w.type = ""
                        }
                        if word.definition == nil{
                            w.definition = ""
                        }
                        print(w.type)
                        self.s = self.s + "Type: " + w.type! + "\n\n" + "Definition: " + w.definition! + "\n\n" + "Example: " + w.example! + "\n\n\n"
                        
                    }
                    DispatchQueue.main.async() {
                        self.textView.text = self.s
                        
                        let wordHistory = PFObject(className:"wordHis")
                        wordHistory ["key"] = self.SearchField.text
                        wordHistory ["def"] = self.s
                        wordHistory.saveInBackground {
                            (success: Bool, error: Error?) in
                            if (success) {
                                // The object has been saved.
                            } else {
                                // There was a problem, check error.description
                            }
                        }
                    }
                    //print(self.s)
                } catch let jsonErr {
                    print("Error",jsonErr)
                }
                }.resume()
            print(self.s + "test nil")
            self.textView.text = self.s
            print(self.s)
        self.s = ""
        
        
        
        
        
        
    }
    
    //JSON parsing end
    
  
    
    @IBAction func logoutOfApp(_ sender: UIButton) {
    
        let sv = UIViewController.displaySpinner(onView: self.view)
        PFUser.logOutInBackground { (error: Error?) in
            UIViewController.removeSpinner(spinner: sv)
            if (error == nil){
                self.loadLoginScreen()
            }
            else{
                if let descrip = error?.localizedDescription{
                    self.displayMessage(message: descrip)
                }
                else{
                    self.displayMessage(message: "error logging out")
                }
            }
        }
    }
    
    func displayMessage(message:String) {
        let alertView = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    
}
