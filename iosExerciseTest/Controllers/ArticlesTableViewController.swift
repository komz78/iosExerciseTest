//
//  ArticlesTableViewController.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 18/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {
    
    private var articles: [Articles] = []
    let jsonUrlString = "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise"
    let cellId = "articlesCell"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //parsing jason data from api function then encode it to datamodel
    func parseJson() {
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let jsonDecoder = JSONDecoder()
                let downloadedArticles = try jsonDecoder.decode(JsonBase.self, from: data!)
                //print(downloadedArticles)
                DispatchQueue.main.async {
                    for article in downloadedArticles.articles!
                    {
                        self.articles.append(article)
                    }
                
                    //Sorting Array.
                    self.articles.sort(by: { (Article1, Article2) -> Bool in
                        let date1 = Article1.date
                        let date2 = Article2.date
                        let title1 = Article1.title?.lowercased()
                        let title2 = Article2.title?.lowercased()
                        let author1 = Article1.authors?.lowercased()
                        let author2 = Article2.authors?.lowercased()
                            //compare date
                            if date1! > date2! {
                                return false
                            }
                            //compare title
                            if title1! > title2! {
                                return true
                            }
                            //compare author
                            if author1! > author2! {
                                return true
                            }
                        return true
                    })
                    
                    self.title = downloadedArticles.title
                    self.tableView.reloadData()
                }

                
            }
            catch let error {
                print("Error fetching:", error)
            }

            
        }.resume()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return articles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ArticlesTableViewCell
        
        cell?.title.text = articles[indexPath.row].title
        cell?.website.text = articles[indexPath.row].website
        cell?.authors.text = articles[indexPath.row].authors
        cell?.date.text = articles[indexPath.row].date

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        return cell!
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        performSegue(withIdentifier: "showDetails", sender: indexPath)
    }
    
    
  

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetails" )
        {
            if let detailsVc = segue.destination as? DetailsViewController {
                let selected = sender as! NSIndexPath
                detailsVc.details = articles[selected.row]
                
        }
    }
    }

}
