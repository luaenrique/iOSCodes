//  ViewController.swift
//  MapApp
//
//  Created by Luã Enrique on 02/04/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var longitudeText: UITextField!
    @IBOutlet weak var latitudeText: UITextField!
    @IBOutlet weak var annotationsText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendDataToMap(_ sender: Any) {
        let myViewMaps = storyboard?.instantiateViewController(withIdentifier: "SecondView") as! SecondView!
        myViewMaps?.stringLatitude = latitudeText.text!
        myViewMaps?.stringLongitude = longitudeText.text!
        myViewMaps?.stringAnnotations = annotationsText.text!
        navigationController?.pushViewController(myViewMaps!, animated: true)
    }
    
}
