//
//  DetailsViewController.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 18/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
     var details: Articles?
    @IBOutlet var detailImage: UIImageView!
    
    @IBOutlet var detailTitle: UILabel!
    @IBOutlet var detailWebsite: UILabel!
    @IBOutlet var detailDate: UILabel!
    @IBOutlet var detailAuthor: UILabel!
    @IBOutlet var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    func setupUI() {
        
        //setup image lazily.
        if !(details?.image_url?.isEmpty)! {
            detailImage.downloadImageFrom(link: (details?.image_url)!, contentMode: UIViewContentMode.scaleToFill)
        }
        else {
            detailImage.image = UIImage(named: "task")
        }
        //setup labels.
        detailTitle.text = details?.title
        detailWebsite.text = details?.website
        detailDate.text = details?.date
        detailAuthor.text = details?.authors
        contentTextView.text = details?.content
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
