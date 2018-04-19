//
//  ViewController.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 18/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var articles: [Articles] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchJson()
      
    }
    
    func fetchJson() {
        let jsonUrlString = "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise"
        guard let url = URL(string: jsonUrlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            do {
                //  var newArticle: [Articles] = []
                
                let dataModel = try jsonDecoder.decode(JsonBase.self, from: data!)
                self.articles = dataModel.articles!
                for article in dataModel.articles! {
                    
                    for tags in article.tags! {
                       // print(tags.label)
                    }
                
                }

            }
            catch let error {
                print("Error fetching:", error)
            }
            
            
        }
        task.resume()
        }
 
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




























