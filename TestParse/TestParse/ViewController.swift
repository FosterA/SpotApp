//
//  ViewController.swift
//  TestParse
//
//  Created by MU IT Program on 3/28/16.
//  Copyright © 2016 Aziz Almeqrin. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var imageToPost: UIImageView!
    @IBAction func chooseImage(sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func uploadImage(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        
        let post = PFObject(className: "Post")
        
        //let imageData = UIImagePNGRepresentation(imageToPost.image!)
        let imageData = UIImageJPEGRepresentation(imageToPost.image!, 0.5)
        
        let imageFile = PFFile(name: "image.jpg", data: imageData!)
        
        post["imageFile"] = imageFile
        //post["uId"] = PFUser.currentUser()!.objectId
        
        post.saveInBackgroundWithBlock { (success, error) -> Void in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            print("Object has been saved.")
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageToPost.image = image
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

