//
//  InvitationTableViewController.swift
//  PetAppOfficial
//
//  Created by Adam Gadbois on 4/22/16.
//  Copyright © 2016 Adam W Gadbois. All rights reserved.
//

import UIKit
import CoreData
import ParseUI

class InvitationTableViewController: UITableViewController {
    
    var newID: String?
    let invitationStatus = ["Confirmed","Pending","Past"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Invitations.setTableViewController(self)
        
        
        self.refreshControl?.addTarget(self, action: #selector(InvitationTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        let nib = UINib(nibName: "InvitationCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "invitationCell")

        self.title = "Invitations"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refresh(sender:AnyObject)
    {
        // Updating your data here...
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        let newInvitationButton = UIBarButtonItem()
        newInvitationButton.title = "New"
        newInvitationButton.style = .Plain
        newInvitationButton.target = self
        newInvitationButton.action = #selector(InvitationTableViewController.performNewInvitationSegue)
        navigationItem.rightBarButtonItem = newInvitationButton
        
        tableView.reloadData()
    }
    
    func performNewInvitationSegue(){
        performSegueWithIdentifier("newInvitation", sender: self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Invitations.getArray().count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Invitations.getArray()[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("invitationCell", forIndexPath: indexPath) as! InvitationCell

        cell.label.text = Invitations.getArray()[indexPath.section][indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return invitationStatus[section]
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController
        
        if let newInvitationViewController = destinationViewController as? PetListTableViewController{
                    newInvitationViewController.isAddInvitation = true
        }
    }

}
