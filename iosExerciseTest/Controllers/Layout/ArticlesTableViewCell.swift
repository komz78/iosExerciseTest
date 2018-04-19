//
//  ArticlesTableViewCell.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 18/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var authors: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
    }

}
