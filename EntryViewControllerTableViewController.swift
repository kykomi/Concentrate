//
//  EntryViewControllerTableViewController.swift
//  Concentrate
//
//  Created by 小宮山 司 on 2017/02/12.
//  Copyright © 2017年 Tsukasa K. All rights reserved.
//

import UIKit
import SafariServices

class EntryViewControllerTableViewController: UITableViewController {
    
    var articles: [HatebArticle] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Original Methods
    func load() {
        RssRequestClient().request(category: .it, status: .hot, completionHandler: self.didLoadArticles)
        tableView.reloadData()
    }
    
    func didLoadArticles(articles: [HatebArticle]) {
        self.articles = articles
        DispatchQueue.main.async { [weak self] in
            guard let wself = self else { return }
            wself.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entry", for: indexPath)
        let entry = self.articles[indexPath.row]
        cell.textLabel?.text = entry.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = articles[indexPath.row]
        let sfVC = SFSafariViewController(url: selected.url, entersReaderIfAvailable: false)
        present(sfVC, animated: true, completion: nil)
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
