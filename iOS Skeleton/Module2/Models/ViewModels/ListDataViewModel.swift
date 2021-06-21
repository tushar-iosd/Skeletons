//
//  ListDataViewModel.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 21/06/21.
//

import UIKit

class ListDataViewModel {
    
    func randomApiCall(){
        WebServiceManager.shared.callRandomListApi( for: [:], successClosure: { (isSuccess) in
            if isSuccess {
                print("success here")
            }
        }) { (_) in
            
        }
        
    }
}

