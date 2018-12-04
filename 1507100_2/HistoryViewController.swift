//
//  HistoryViewController.swift
//  1507100_2
//
//  Created by kuet on 4/12/18.
//  Copyright © 2018 kuet. All rights reserved.
//

import UIKit
import Foundation
import Parse

class HistoryViewController: UIViewController {

    @IBOutlet weak var text: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFQuery(className:"wordHis")
        query.getObjectInBackground(withId: "wmYuODGRbH") {
            (wordHis: PFObject?, error: Error?) -> Void in
            if error == nil && wordHis != nil {
                print(wordHis)
                
                    self.text.text = wordHis!["key"] as! String
                
            } else {
                print(error)
            }
        }

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

}
