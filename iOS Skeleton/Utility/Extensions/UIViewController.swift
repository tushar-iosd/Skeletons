//
//  UIViewController.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 18/06/21.
//

import UIKit


extension UIViewController {
    static var window: UIWindow?
    func setRootViewController(storyBoard: String){
        let name = String(describing: type(of: self))
        let popOverVC = UIStoryboard(name: storyBoard, bundle: nil).instantiateViewController(withIdentifier: name)
        let navObj = UINavigationController.init(rootViewController: popOverVC)
        UIViewController.window?.rootViewController = navObj
   /*  let s =  UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
            .filter({$0.isKeyWindow}).first?.rootViewController = navObj */ //Works too
        
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (sceneDelegate?.delegate as? SceneDelegate) {
            sd.window?.rootViewController = navObj
            sd.window?.makeKeyAndVisible()
        }
        
      
       /*  UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = navObj
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.makeKeyAndVisible()*/
        
}
}
