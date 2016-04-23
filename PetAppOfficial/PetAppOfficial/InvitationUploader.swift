//
//  InvitationUploader.swift
//  PetAppOfficial
//
//  Created by Adam Gadbois on 4/23/16.
//  Copyright © 2016 Adam W Gadbois. All rights reserved.
//

import UIKit
import CoreData
import Parse

class InvitationUploader: NSOperation {
    var pets = [NSManagedObject]()
    let query = PFQuery(className: "Pet")
    
    init(pets: [NSManagedObject]){
        self.pets = pets
    }
    
    override func main(){
        let pfInvitation = PFObject(className: "Invitation")
        pfInvitation["Status"] = 1
        for pet in pets{
            if let id = pet.valueForKey("id") as? String{
                do{
                    let pfPet = try query.getObjectWithId(id)
                    pfInvitation.relationForKey("Pets").addObject(pfPet)
                } catch let error{
                    print("Error adding pet relation: \(error)")
                    return
                }
            }
        }
        do{
            try pfInvitation.save()
        } catch let error{
            print("Error uploading invitation to server: \(error)")
            return
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let invitationEntity =  NSEntityDescription.entityForName("Invitation", inManagedObjectContext: managedContext)
        
        if let id = pfInvitation.objectId{
            let invitation = NSManagedObject(entity: invitationEntity!, insertIntoManagedObjectContext:managedContext)
            Invitations.addInvitation(1, id: id)
            invitation.setValue(id, forKey: "id")
            invitation.setValue(1,forKey: "status")
        }
        
        // Complete save and handle potential error
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
            return
        }
    }
}
