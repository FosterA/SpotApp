//
//  OperationsQueue.swift
//  PetAppOfficial
//
//  Created by Adam Gadbois on 4/23/16.
//  Copyright © 2016 Adam W Gadbois. All rights reserved.
//

import Foundation

class OperationsQueue{
    static private var queue = NSOperationQueue()
    
    static func addOperation(operation: NSOperation){
        queue.addOperation(operation)
    }
}