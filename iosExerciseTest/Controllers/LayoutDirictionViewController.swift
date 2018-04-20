//
//  LayoutDirictionViewController.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 20/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//

import UIKit

class LayoutDirictionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var toggleDirections: UIButton!
    
    @IBAction func toggleDirections(_ sender: Any) {
        //check for supporting swapping between directions.
        if #available(iOS 9.0, *){
            if UIView.userInterfaceLayoutDirection(for: view.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
                print("orginally on RTL - changing it to left to right")
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
            else{
                print("orginally on LTR - changing it to right to left")
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }
        }
        else {
            print("handle older virsions of iOS 9 and below here.")
        }
        //show alert
        let alert = UIAlertController(title: "Toggle Layout Directions", message: "Your layout directions updated. \nGo back and check ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
