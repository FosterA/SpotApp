//
//  homeVC.swift
//  TestParse
//
//  Created by MU IT Program on 3/30/16.
//  Copyright © 2016 Aziz Almeqrin. All rights reserved.
//

import UIKit
import Parse


class homeVC: UICollectionViewController {
    
    var refresher : UIRefreshControl!

    
    var uuidArray = [String]()
    var picArray = [PFFile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .whiteColor()
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(homeVC.refresh), forControlEvents: UIControlEvents.ValueChanged)
        collectionView?.addSubview(refresher)

        loadPosts()
    }
    
    func refresh() {
        collectionView?.reloadData()
    }
    
    func loadPosts() {
        
        let query = PFQuery(className: "Post")
        //query.whereKey("uId", equalTo: PFUser.currentUser()!.objectId!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                
                for object in objects {
                    
                  //  self.uuidArray.append(object["uId"] as! String)
                    self.picArray.append(object["imageFile"] as! PFFile)
                }
            }
            self.collectionView?.reloadData()
        }

    }


    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return picArray.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCellWithReuseIdentifier("Cell1", forIndexPath: indexPath) as! imageCell
        
        picArray[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
            if error == nil {
                cell1.picImg.image = UIImage(data: data!)
                
                // Make circular image
                cell1.picImg.layer.cornerRadius = cell1.picImg.frame.size.width/2
                cell1.picImg.clipsToBounds = true
            }
        }
        return cell1
    }
    
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as! headerView
        
        //header.userIdlbl.text = PFUser.currentUser()!.objectId!
        
        return header
    }

    /*
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        return cell
    }
 */

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
