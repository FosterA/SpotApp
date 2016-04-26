//
//  PetCollectionViewController.swift
//  PetApp
//
//  Created by Emma Schiermeier on 3/17/16.
//  Copyright © 2016 Emma Schiermeier. All rights reserved.
//

import UIKit
//add UICollectionViewDataSource

class PetCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var activityCollection: UITableView!
    @IBOutlet weak var petCollection: UICollectionView!
    @IBOutlet weak var activityTable: UITableView!
    
    var activities : [String] = ["Ate", "Played outside", "Napped", "Ate", "Chewed on toy"]


    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.delegate = self
        petCollection.delegate = self
        photoCollection.dataSource = self
        petCollection.dataSource = self
        activityTable.delegate = self
        activityTable.dataSource = self
        
        let invitationButton = UIBarButtonItem()
        invitationButton.title = "Invitations"
        invitationButton.style = .Plain
        invitationButton.target = self
        //invitationButton.action = #selector(PetListTableViewController.performInvitationSegue)
        navigationItem.rightBarButtonItem = invitationButton
        
        petCollection.registerNib(UINib(nibName: "petCollectionCell", bundle: nil), forCellWithReuseIdentifier: "petCollectionCell")
        
        //petCollection.registerNib(UINib(nibName: "addPetCell", bundle: nil), forCellWithReuseIdentifier: "addPetCell")
        
        photoCollection.registerNib(UINib(nibName: "imageCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(photoCollection: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == photoCollection) {
            return 3;
        } else {
            return 2;
            //return # of pets we have +1
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell { indexPath.item
        if(collectionView==photoCollection)
        {
           let photoCell = photoCollection.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! PetImageCollectionViewCell
            
            photoCell.thumbnail.image = UIImage(named: "Party-hat-hedgehog.jpg")
            
            return photoCell
        }
        else
        {
            if(indexPath.item == 0)
            {
            let addPet = collectionView.dequeueReusableCellWithReuseIdentifier("addPetCell", forIndexPath: indexPath) //as! AddPetCollectionViewCell
                
                return addPet
                
            }
            else
            {
                let petProfile = petCollection.dequeueReusableCellWithReuseIdentifier("petCollectionCell", forIndexPath: indexPath) as! PetCollectionViewCell
                
                petProfile.petName.text = "Snuffles"
                petProfile.thumbnail.image = UIImage(named: "flipoff.jpg")
                
                return petProfile
            }
            
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("activityCell")
        
        cell?.textLabel!.text = activities[indexPath.row]
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(activities[indexPath.row])
    }

    
    
    
    /*
    
    func photoCollection(photoCollection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func petCollection(petCollection: UICollectionView, numberOfSectionsInCollectionView section: Int) ->Int {
        return 1
    }
    
    func petCollection(petCollection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    
    func petCollection(petCollection: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let petProfile = petCollection.dequeueReusableCellWithReuseIdentifier("petCollectionCell", forIndexPath: indexPath)
        
        let label = petProfile.viewWithTag(1) as! UILabel
        label.text = "Hello world!"
        
        return petProfile
    }
 */
    
   
   /* func petCollection(petCollection: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    }*/


}

