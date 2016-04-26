//
//  Pets.swift
//  PetAppOfficial
//
//  Created by Adam Gadbois on 4/25/16.
//  Copyright © 2016 Adam W Gadbois. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Pets{
    static var petArray = [NSManagedObject]()
    
    static func getArray() -> [NSManagedObject]{
        if petArray.isEmpty{
            loadArray()
        }
        return petArray
    }
    
    static func addPet(pet: NSManagedObject){
        petArray.append(pet)
    }
    
    static private func loadArray(){
        //Load saved pet entities from core data.
        //Get the app delegate. Must be casted because it could have been subclassed
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //Get methods to do core data stuff
        let managedContext = appDelegate.managedObjectContext
        //Looks for entities of type note
        let fetchRequest = NSFetchRequest(entityName:"Pet")
        
        do {
            let fetchedResults =
                try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                petArray = results
            } else {
                print("Could not fetch pets")
            }
        } catch {
            return
        }
    }
}