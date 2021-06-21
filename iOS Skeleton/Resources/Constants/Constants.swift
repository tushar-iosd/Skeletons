//
//  Constants.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 02/06/21.
//

import UIKit
// MARK:  typeAliases
typealias JSONDictionary = [String:Any]
typealias completionClosure = (_ success: Bool, _ data: Data?,_ error: NSError?) -> ()
typealias apiCallFailureClosure = (_ error: NSError) -> ()
typealias booleanClosure = (Bool) -> ()
struct Constants {
    //Storyboard Name
    struct StoryboardName {
        static let main     =   UIStoryboard.init(name: "Main", bundle: nil)
        static let mainStoryBoard = "Main"
        static let secondModuleStoryboard = UIStoryboard.init(name: "SecondModule", bundle: nil) 
    }
    
    
    struct RelativeURLPath {
        static let serverURL = "https://jsonplaceholder.typicode.com/"
        static let randomList = "/posts/1/comments"
        
    }
    
}
