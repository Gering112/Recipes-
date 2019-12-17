//
//  ViewController.swift
//  h#5
//
//  Created by Gering Dong on 12/12/18.
//  Copyright © 2018 Gering Dong. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
   
    @IBOutlet weak var tblCell: UITableView!
   // var parameters = [[String:AnyObject]]() // array of dictionary
    
    var key = ""
    var post = JSON()
    
    
   
    var selectIndex: Int = 0
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    
        cell?.textLabel?.text = post[indexPath.row]["title"].string
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let parameters = self.post[indexPath.row]
        let edit = UITableViewRowAction(style: .default , title: "Edit"){(action, indexPath) in
            self.selectIndex = indexPath.row
            self.editAction(parameters: parameters, indexPath: indexPath)
        }
        let delete = UITableViewRowAction(style: .default, title: "Delete") {(action, indexPath) in
            self.selectIndex = indexPath.row
            self.deleteAction()
            
        }
        edit.backgroundColor = .blue
        return [edit, delete]
    }
    private func editAction(parameters: Any, indexPath: IndexPath ){
        performSegue(withIdentifier: "firstToThird", sender: self)
        
        let alert = UIAlertController(title: "Cancel", message: "Are you sure you want to discard these changes?", preferredStyle: .alert)
        let delete = UIAlertAction(title: "Yes", style: .default){(action) in
            self.performSegue(withIdentifier: "firstToThird", sender: self)
            
        }
        let cancelBtn = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(delete)
        alert.addAction(cancelBtn)
        present(alert, animated: true)
    }
    
    
    private func deleteAction(){
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this recipe?", preferredStyle: .alert)
        let delete = UIAlertAction(title: "Yes", style: .default){(action) in
            //self.post.arrayObject?.remove(at: indexPath.row)
            //self.tblCell?.deleteRows(at: [indexPath], with: .automatic)
            let par = ["key": self.key, "id": self.post[self.selectIndex]["id"].string!]
            let base_url = "http://www.tageninformatics.com/client/jwu/csis3070_recipe/"
            AF.request(base_url + "delete", method: .get, parameters:par).response { response in
                self.viewDidLoad()
                }
            }
        let cancelAction = UIAlertAction(title:"No", style: .default, handler: nil)
        alert.addAction(delete)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "id"
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath.row
        performSegue(withIdentifier: "firstToSecond", sender: self)
        
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstToSecond"{
            let destinationViewController = segue.destination as! SecondViewController
            destinationViewController.theString = self.post[selectIndex]["description"].string
            destinationViewController.theTitle = self.post[selectIndex]["title"].string
        
        } else if segue.identifier == "firstToThird"{
            let destinationViewController2 = segue.destination as! ThirdViewController
            destinationViewController2.TitleIntxtFeild = self.post[selectIndex]["title"].string!
           // destinationViewController2.recipeDiscription = "Recipe"//self.parameters[selectIndex]["id"] as? String
            //destinationViewController2.TitleIntxtFeild = "please enter"// self.parameters[selectIndex]["title"] as? String
            destinationViewController2.recipeDetails = self.post[selectIndex]["description"].string!
            destinationViewController2.key = self.key
            destinationViewController2.id = self.post[selectIndex]["id"].string!
            
            
        }
    }
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // gets the data
        
        self.key = UserDefaults.standard.string(forKey: "key") ?? ""
        if self.key == ""{
            let letters = "1234567890abcdef"
            for _ in 0..<64{
                let keyRandom = (arc4random_uniform(UInt32(letters.count)))
                self.key += "\(letters[letters.index(letters.startIndex, offsetBy: Int(keyRandom))])"
                
            }
        }
        UserDefaults.standard.set(self.key, forKey: "key")
        
        print("key is " + self.key)
        let parameters = ["key": self.key]
        let base_url = "http://www.tageninformatics.com/client/jwu/csis3070_recipe/"
        AF.request(base_url + "list", method: .get, parameters:parameters).response { response in
            
            print(response)
            var r = JSON (response.result.value as Any)
            self.post = JSON(response.data!)
            DispatchQueue.main.async {
                self.tblCell.reloadData()
            }
            self.post = r["recipes"]
            
            }.resume()
  
    }
    
    

        
}



    


// 24c92dfd0aa492bc3fa980670501adcdbf70f76ab06cbe870bb7192ab757a69a



