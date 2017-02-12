//
//  EntryViewControllerTableViewController.swift
//  Concentrate
//
//  Created by 小宮山 司 on 2017/02/12.
//  Copyright © 2017年 Tsukasa K. All rights reserved.
//

import UIKit
import SafariServices

class EntryViewControllerTableViewController: UITableViewController, CategoryChoiceDelegate {
    
    var articles: [HatebArticle] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        load(Category.it)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Original Methods
    func load(_ category: Category) {
        RssRequestClient().request(category, status: .hot, completionHandler: self.didLoadArticles)
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

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ((segue.destination as? UINavigationController)?.topViewController as? CategoryChoiceTableViewController)?.delegate = self
    }
    
    // MARK: Category Choice Delegate
    func didSelect(category: Category) {
        load(category)
    }

}
