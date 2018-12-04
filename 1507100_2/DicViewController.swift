//
//  DicViewController.swift
//  1507100_2
//
//  Created by kuet on 26/11/18.
//  Copyright © 2018 kuet. All rights reserved.
//

import UIKit

class DicViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    struct Word {
        let type: String?
        let def: String?
        let example: String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func searchTapped(_ sender: Any) {
        
        let jsonUrlString = "https://owlbot.info/api/v2/dictionary/cat?format=json&fbclid=IwAR16hWnHo5e20J2uJzn53C20wnn9HAAEmahRNVRwsUMKNAfIk7-iVufqFBQ"
        guard let url = URL(string:jsonUrlString) else
        { return }
        print("Muin")
        
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else {return}
            
            do{
                let words = try JSONDecoder().decode([Word].self, from: data)
                
                for word in words{
                    self.label.text = word.def
                }
            } catch let jsonErr {
                print("Error",jsonErr)
            }
        }
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
