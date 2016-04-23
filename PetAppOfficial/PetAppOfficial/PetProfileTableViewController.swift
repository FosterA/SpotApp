//
//  PetProfileTableViewController.swift
//  PetProfile
//
//  Created by Christopher King on 4/2/16.
//  Copyright © 2016 Christopher A King. All rights reserved.
//

import UIKit
import CoreData
import ParseUI

class PetProfileTableViewController: UITableViewController {

    @IBOutlet weak var petName: UITextField!
    @IBOutlet weak var ownerName: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var dietNeeds: UITextView!
    @IBOutlet weak var medicationNeeds: UITextView!
    @IBOutlet weak var vetInfoNeeds: UITextView!
    
    var pet: NSManagedObject?
    var pfPet: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Pet Profile"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(PetProfileTableViewController.savePet))

        if let pet = pet {
            petName.text = pet.valueForKey("petName") as? String
            ownerName.text = pet.valueForKey("ownerName") as? String
            dietNeeds.text = pet.valueForKey("diet") as? String
            medicationNeeds.text = pet.valueForKey("medication") as? String
            vetInfoNeeds.text = pet.valueForKey("vet") as? String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func savePet() {
        if let petName = petName.text{
            if petName.isEmpty{
                let alertController = UIAlertController(title: "Error", message: "Your pet must have a name!", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(okAction)
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        if pet == nil {
            let petEntity =  NSEntityDescription.entityForName("Pet", inManagedObjectContext: managedContext)
            
            pet = NSManagedObject(entity: petEntity!, insertIntoManagedObjectContext:managedContext)
            if let id = pet?.valueForKey("id") as? String{
                let query = PFQuery(className: "Pet")
                query.getObjectInBackgroundWithId(id, block: { (object, error) -> Void in
                    self.pfPet = object
                })
            }
        }
        if pfPet == nil {
            pfPet = PFObject(className: "Pet")
        }
        
        var profileImageData: NSData?
        if let profileImage = profileImage.image{
            if let profileImageData = UIImageJPEGRepresentation(profileImage, 1.0){
                pfPet?["PetProfileImage"] = PFFile(name: "ProfileImage.JPG", data: profileImageData)
                pet?.setValue(profileImageData, forKey: "profileImage")
            }
        }
        pfPet?["PetName"] = petName.text
        pet?.setValue(petName.text, forKey: "petName")
        pfPet?["OwnerName"] = ownerName.text
        pet?.setValue(ownerName.text, forKey: "ownerName")
        pfPet?["Diet"] = dietNeeds.text
        pet?.setValue(dietNeeds.text, forKey: "diet")
        pfPet?["Medication"] = medicationNeeds.text
        pet?.setValue(medicationNeeds.text, forKey: "medication")
        pfPet?["Vet"] = vetInfoNeeds.text
        pet?.setValue(vetInfoNeeds.text, forKey: "vet")
        pfPet?.saveInBackgroundWithBlock{(success,error) -> Void in
            if let id = self.pfPet?.objectId{
                self.pet?.setValue(id, forKey: "id")
            }
            
            // Complete save and handle potential error
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 1 && indexPath.row == 0) {
            dietNeeds.becomeFirstResponder()
        }
        else if (indexPath.section == 1 && indexPath.row == 1){
            medicationNeeds.becomeFirstResponder()
        }
        else if (indexPath.section == 1 && indexPath.row == 2){
            vetInfoNeeds.becomeFirstResponder()
        }
        
    }
    
    
    //Need function to make the text field the first responder
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
