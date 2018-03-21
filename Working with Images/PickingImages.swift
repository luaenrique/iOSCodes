//
//  ViewController.swift
//  WorkingWithImages
//
//  Created by Luã Enrique on 21/03/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var myImage: UIImageView!
    
    
    @IBAction func SelectImage(_ sender: Any) {
        let imagePicker = UIImagePickerController() //Setting up the image picker controller
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary //Choosing from where the image will come. (In this case, I have selected photoLibrary)
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        myImage.image = info[UIImagePickerControllerOriginalImage] as! UIImage //Setting the image in the ImageView from the PickerController
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
