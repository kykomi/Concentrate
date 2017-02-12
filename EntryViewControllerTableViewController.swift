//
//  EntryViewControllerTableViewController.swift
//  Concentrate
//
//  Created by 小宮山 司 on 2017/02/12.
//  Copyright © 2017年 Tsukasa K. All rights reserved.
//

import UIKit

class EntryViewControllerTableViewController: UITableViewController {
    
    var entries: [HatebArticle] = []

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
        RssRequestClient().request(category: .it, status: .hot, completionHandler: self.didLoadEntry)
        tableView.reloadData()
    }
    
    func didLoadEntry(entries: [HatebArticle]) {
        self.entries = entries
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
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entry", for: indexPath)
        let entry = self.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        return cell
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
