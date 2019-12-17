//
//  ThirdViewController.swift
//  hw#7
//
//  Created by Gering Dong on 1/10/19.
//  Copyright © 2019 Gering Dong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ThirdViewController: UIViewController {


    var key = ""
    var id: String = ""
    var newTitle: String = ""
    var newDescription: String = ""
    var check = 0
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var txtFieldTitle: UITextField!
    @IBOutlet weak var txtRecipeDetails: UITextView!
    
    var labelTitle = "Title"
    var recipeDiscription = "Description"
    var TitleIntxtFeild = ""
    var recipeDetails = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTitle?.text = labelTitle
        self.lblDescription?.text = recipeDiscription
        self.txtFieldTitle?.text = TitleIntxtFeild
        self.txtRecipeDetails?.text = recipeDetails

        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Cancel", message: "Are you sure you want to discard these changes?", preferredStyle: .alert)
        
        let Yes = UIAlertAction(title: "Yes", style: .default){(action) in
            self.dismiss(animated: true, completion: nil)
        }
        let No = UIAlertAction(title:"No", style: .default, handler: nil)
        
        alert.addAction(Yes)
        alert.addAction(No)
        present(alert, animated: true)
    }
    @IBAction func saveBtn(_ sender: Any) {
            //var title: String = self.txtFieldTitle.text!
            //var description: String = self.txtRecipeDetails.text!
            let title = self.txtFieldTitle.text!
            let decription = self.txtRecipeDetails.text!
            
            if check == 0 {
                if title == "" || decription == ""{
                    let alert = UIAlertController(title: "Oops!", message: "The Title or the Description is empty!", preferredStyle: .alert)
                    let Ok = UIAlertAction(title: "Ok", style: .default, handler:nil)
                    alert.addAction(Ok)
                    self.present(alert, animated: true)
                    }
                else{
                    
                    let alert = UIAlertController(title: "Save", message: "would you like to save ?", preferredStyle: .alert)
                    let yes = UIAlertAction(title: "Yes", style: .default){(action) in
                        let parameter = ["key": self.key, "title": self.txtFieldTitle.text!, "description": self.txtRecipeDetails.text!] as [String:Any]
                        let link = "http://www.tageninformatics.com/client/jwu/csis3070_recipe/"
                        AF.request(link + "create", method: .get, parameters: parameter).responseJSON{
                        response in
                        self.performSegue(withIdentifier: "thirdToFirst", sender: self)
                        }
                    
                }
                    let cancel = UIAlertAction (title: "Cancel", style: .default, handler: nil)
                    
                    alert.addAction(yes)
                    alert.addAction(cancel)
                    self.present(alert, animated: true)
            }
                
        }
            if check == 1 {
                if title == "" || decription == "" {
                    let alert = UIAlertController(title: "Oops!", message: "The Title or the Description is empty!", preferredStyle: .alert)
                    let Ok = UIAlertAction(title: "Ok", style: .default, handler:nil)
                    alert.addAction(Ok)
                    self.present(alert, animated: true)
                    
                }
                else{
                    let alert = UIAlertController(title: "Save", message: "would you like to save ?", preferredStyle: .alert)
                    let save = UIAlertAction(title: "save", style: .default){(action) in
                        let parameters = ["key": self.key, "id": self.id] as [String: Any]
                        print(self.id)
                        let link = "http://www.tageninformatics.com/client/jwu/csis3070_recipe/"
                        AF.request(link + "delete", method: .get, parameters: parameters).responseJSON{
                            response in
                            let parameter = ["key": self.key, "title": self.txtFieldTitle.text!, "description": self.txtRecipeDetails.text!] as [String: Any]
                            AF.request(link + "create", method: .get, parameters: parameter).responseJSON{
                                response in
                                self.performSegue(withIdentifier: "thirdToFirst", sender: self)
                                
                            }
                        }
                        
                    }
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                    alert.addAction(save)
                    alert.addAction(cancel)
                    self.present(alert, animated: true)
                    
                }
                
        }
        
    }
}


