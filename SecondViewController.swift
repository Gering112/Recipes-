//
//  SecondViewController.swift
//  h#5
//
//  Created by Gering Dong on 12/17/18.
//  Copyright © 2018 Gering Dong. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblLable: UILabel!
    
    @IBOutlet weak var txtOutput: UITextView!
    
    
    
    var theTitle: String? = "test"
    var theString: String? = "test2"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtOutput?.text = theString!
        self.lblLable?.text = theTitle!
    }
    



}
