//
//  PetListTableViewController.swift
//  PetProfile
//
//  Created by Christopher King on 4/2/16.
//  Copyright © 2016 Christopher A King. All rights reserved.
//

import UIKit
import CoreData
import Parse

class PetListTableViewController: UITableViewController {

    var pets = [NSManagedObject]()
    var isAddInvitation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profiles"
        
        let nib = UINib(nibName: "PetCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "petCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        if !isAddInvitation{
            let invitationButton = UIBarButtonItem()
            invitationButton.title = "Invitations"
            invitationButton.style = .Plain
            invitationButton.target = self
            invitationButton.action = #selector(PetListTableViewController.performInvitationSegue)
            navigationItem.rightBarButtonItem = invitationButton
        }
        else{
            let sendInvitationButton = UIBarButtonItem()
            sendInvitationButton.title = "Send"
            sendInvitationButton.style = .Plain
            sendInvitationButton.target = self
            sendInvitationButton.action = #selector(PetListTableViewController.sendInvitation)
            navigationItem.rightBarButtonItem = sendInvitationButton
            //navigationItem.leftBarButtonItem!.title = "Cancel"
        }
     
        loadPets()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPets(){
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
                pets = results
            } else {
                print("Could not fetch pets")
            }
        } catch {
            return
        }
    }
    
    func performInvitationSegue(){
        performSegueWithIdentifier("invitations", sender: self)
    }
    
    func sendInvitation(){
        if let indices = tableView.indexPathsForSelectedRows{
            var selectedPets=[NSManagedObject]()
            for index in indices{
                selectedPets.append(pets[index.row])
            }
            OperationsQueue.addOperation(InvitationUploader(pets: selectedPets))
            self.isAddInvitation = false
            self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "You must select at least one pet!", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pets.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("petCell", forIndexPath: indexPath)
        
        let pet = pets[indexPath.row]
        if let title = pet.valueForKey("petName") as? String{
            cell.textLabel?.text = title
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !isAddInvitation{
            performSegueWithIdentifier("pet", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController
        if let identifier = segue.identifier{
            switch(identifier){
            case "invitations":
                if let invitationViewController = destinationViewController as? InvitationTableViewController{
                    
                }
                break
            case "pet":
                if let PetProfileTableViewController = destinationViewController as? PetProfileTableViewController {
                    PetProfileTableViewController.pet = pets[tableView.indexPathForSelectedRow!.row]
                }
                break
            default:
                break
            }
        }
    }
    
    func deletePetAtIndex(index: Int) {
        if (index < pets.count) {
            let pet = pets[index]
            
            // remove from array of notes
            pets.removeAtIndex(index)
            
            // remove from managed data
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.deleteObject(pet)
            // Complete save and handle potential error
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            deletePetAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
