//
//  ArticlesTableViewController.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 18/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//

import UIKit
import RealmSwift


class ArticlesTableViewController: UITableViewController {
    
    //* MARK : Var
    private var articles: [Articles] = []
    let jsonUrlString = "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise"
    let cellId = "articlesCell"
    let detailSegue = "detailSegue"
    
    
    //MARK : Refresher and a function to handle the table when refreshing
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        //call handle refresh function
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    @objc func handleRefresh() {
        refresher.beginRefreshing()
        //fetch data
        parseJson()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        //to stop issues with refresher in older softwares.
        if #available(iOS 10.0, *){
        tableView.refreshControl = refresher
        } else {
            tableView.addSubview(refresher)
        }
        
        //to totally remove realm file if schema is bad.
    //try? FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)

        
    }
   


    //parsing jason data from api function then encode it to datamodel
    @objc func parseJson() {
        
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let jsonDecoder = JSONDecoder()
                let downloadedArticles = try jsonDecoder.decode(JsonBase.self, from: data!)
                //perform a GCD queue so it works in the main thread.
                DispatchQueue.main.async {
                    //clear all old articles values to prepare appending it
                    self.articles.removeAll()
                    //get articles by looping into dictionary
                    
                    //realm
                    let ArticlesRealmData = ArticlesList()
                    ArticlesRealmData.title = downloadedArticles.title!
                    let subs = downloadedArticles.articles
                    for article in subs! {
                        let ArticleRealmData = ArticleRealm()
                        ArticleRealmData.title = article.title!
                        ArticleRealmData.authors = article.authors!
                        ArticleRealmData.website = article.website!
                        ArticleRealmData.date = article.date!
                        ArticleRealmData.content = article.content!
                        ArticleRealmData.image_url = article.image_url!
                        ArticlesRealmData.articles.append(ArticleRealmData)
                        for tags in article.tags!  {
                            let TagsRealmData = TagsRealm()
                            TagsRealmData.id = String(tags.id!)
                            TagsRealmData.label = tags.label!
                            ArticleRealmData.tagsItem.append(TagsRealmData)
                            }
                        }
                        let  realm = try! Realm()
                        try! realm.write {
                            realm.add(ArticlesRealmData , update: true)
                        }

                    for article in downloadedArticles.articles!
                    {
                        //appending values to table.
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
                            //then compare title
                            if title1! > title2! {
                                return true
                            }
                            //then compare author
                            if author1! > author2! {
                                return true
                            }
                        return true
                    })
                    
                    self.title = downloadedArticles.title
                    //update realm
                  //  self.addFeedToRealm()
                    self.tableView.reloadData()
                    //end refreshing data when reloaded.
                    self.refresher.endRefreshing()
                }
            }
            catch let error {
                print("Error fetching:", error)
            }
        }.resume()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //get count to be populated in table view
       return articles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ArticlesTableViewCell
        //setup ui labels and images.
        cell?.title.text = articles[indexPath.row].title
        cell?.website.text = articles[indexPath.row].website
        cell?.authors.text = articles[indexPath.row].authors
        cell?.date.text = articles[indexPath.row].date
        //get image lazely
        cell?.imageCell.image = UIImage(named: "placeholder")  //set placeholder image first.
        // to stop casting error -1002 for empty urls we performe this condition
        if !(articles[indexPath.row].image_url?.isEmpty)! {
        cell?.imageCell?.downloadImageFrom(link: articles[indexPath.row].image_url!, contentMode: UIViewContentMode.scaleAspectFit)
           //cell?.imageCell?.layer.mask?.cornerRadius = 77
        }
        else {
            print("no image")
            // or show a defualt image like below.
            //cell?.imageCell.image =  UIImage(named: "task")
        }
        return cell!
    }
    override func viewDidAppear(_ animated: Bool) {
        //when the view appears do the estimated row height and dimention.
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //then it will do to the prepare for segue to send values and navigate to the desired view controller.
        //set sender indexpath so you can get the article value.
        performSegue(withIdentifier: detailSegue, sender: indexPath)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailSegue ){
            if let detailsVc = segue.destination as? DetailsViewController {
                //the sender indexpath
                let selected = sender as! NSIndexPath
                detailsVc.details = articles[selected.row]
            }
        }
    }
    


} // end of class


//extention for lazy image loading function.
extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            //async
          DispatchQueue.main.async() {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
