//
//  SViewController.swift
//  SimpleCrud
//
//  Created by Luã Enrique Zangrande on 26/02/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import UIKit

class SViewController: UIViewController {

    
    var id = String()
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var user = Usuarios(id: Int(id)!)
        usernameText.text = user.getUsername()
        passwordText.text = user.getPassword()
        // Do any additional setup after loading the view.
    }

    @IBAction func UpdateUser(_ sender: Any) {
        if(usernameText.text != "" && passwordText.text != ""){
            var user = Usuarios(id: Int(id)!, username: usernameText.text!, password: passwordText.text!)
            user.updateUser()
        }
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
