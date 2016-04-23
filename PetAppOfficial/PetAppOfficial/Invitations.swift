//
//  Invitations.swift
//  PetAppOfficial
//
//  Created by Adam Gadbois on 4/23/16.
//  Copyright © 2016 Adam W Gadbois. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Invitations{
    static private var initialized = false
    static private var invitationsArray = [[String](),[String](),[String]()]
    static private var tableViewController: InvitationTableViewController?
    
    static func initialize(){
        if !initialized{
            loadInvitations()
            initialized = true
        }
    }
    static func getArray() -> [[String]]{
        return invitationsArray
    }
    
    static func addInvitation(status: Int,id: String){
        invitationsArray[status].append(id)
        tableViewController?.refresh(self)
    }
    
    static func setTableViewController(tableViewController: InvitationTableViewController){
        self.tableViewController = tableViewController
    }
    
    private static func loadInvitations(){
        var invitationEntities = [NSManagedObject]()
        //Load saved invitation IDs from core data.
        //Get the app delegate. Must be casted because it could have been subclassed
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //Get methods to do core data stuff
        let managedContext = appDelegate.managedObjectContext
        //Looks for entities of type InvitationID
        let fetchRequest = NSFetchRequest(entityName:"Invitation")
        
        do {
            let fetchedResults =
                try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                invitationEntities = results
            } else {
                print("Could not fetch invitations")
            }
        } catch {
            return
        }
        for invitation in invitationEntities{
            if let id = invitation.valueForKey("id") as? String{
                OperationsQueue.addOperation(InvitationDownloader(id: id))
            }
        }
    }
}