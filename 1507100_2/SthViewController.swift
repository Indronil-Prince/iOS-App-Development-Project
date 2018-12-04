//
//  SthViewController.swift
//  1507100_2
//
//  Created by kuet on 27/11/18.
//  Copyright © 2018 kuet. All rights reserved.
//

import UIKit

class SthViewController: UIViewController {
    
    @IBOutlet weak var SearchField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var s = ""
    
    struct Word :Decodable {
        var type: String?
        var definition: String?
        var example: String?
    }

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

    @IBAction func buttonTapped(_ sender: Any) {
        
        self.textView.text = ""
        
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
            
            print("Muin")
            
            do{
                let words = try JSONDecoder().decode([Word].self, from: data)
                
                
                for word in words{
                    //self.label.text = word.def
                    var w = word
                    print(word.type)
                    print(word.definition)
                    print(word.example)
                    if word.example == nil{
                        w.example = ""
                    }
                    if word.type == nil{
                        w.type = ""
                    }
                    if word.definition == nil{
                        w.definition = ""
                    }
                    self.s = self.s + "Parts of Speech: " + w.type! + "\n\n" + "Definition: " + w.definition! + "\n\n" + "Example: " + w.example! + "\n\n\n"
                    
                }
            } catch let jsonErr {
                print("Error",jsonErr)
            }
        }.resume()
        
        self.textView.text = self.s
        print(self.s)
        self.s = ""
        
    }
}
