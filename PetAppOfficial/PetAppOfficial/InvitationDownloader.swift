//
//  InvitationDownloader.swift
//  PetAppOfficial
//
//  Created by Adam Gadbois on 4/22/16.
//  Copyright © 2016 Adam W Gadbois. All rights reserved.
//

import UIKit
import Parse

class InvitationDownloader: NSOperation {
    var id = String()
    
    init(id: String){
        self.id = id
    }
    
    override func main(){
        let query = PFQuery(className: "Invitation")
        
        var invitation: PFObject?
        do{
            try invitation = query.getObjectWithId(id)
        }
        catch{
            return
        }
        if let status = invitation?.valueForKey("Status") as? Int{
            if let id = invitation?.objectId{
                Invitations.addInvitation(status, id: id)
            }
        }
    }
}
