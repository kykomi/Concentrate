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
    
    var selectedCategory: Category!
    var articles: [HatebArticle] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        load(Category.hotentry)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Original Methods
    func load(_ category: Category) {
        selectedCategory = category
        RssRequestClient().request(category, status: .hot, completionHandler: self.didLoadArticles)
    }
    
    func didLoadArticles(articles: [HatebArticle]) {
        self.articles = articles
        DispatchQueue.main.async { [weak self] in
            guard let wself = self else { return }
            wself.navigationItem.title = wself.selectedCategory.title()
            wself.tableView.reloadData()
            wself.tableView.scrollToRow(at: IndexPath(row: 0, section: 0) , at: .top, animated: false)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "entry", for: indexPath) as? EntryCellTableViewCell else {
            fatalError("Can not cast EntryCellTableViewCell")
        }
        
        let entry = self.articles[indexPath.row]
        cell.setData(entry)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = articles[indexPath.row]
        let sfVC = SFSafariViewController(url: selected.url, entersReaderIfAvailable: false)
        present(sfVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
