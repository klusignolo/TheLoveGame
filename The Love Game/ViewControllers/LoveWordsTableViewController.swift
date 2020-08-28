//
//  LoveWordsTableViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 8/27/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit
import Foundation

class LoveWordsTableViewController: UITableViewController {
    var loveWordsList: [TextEntity] = []
    
    @IBOutlet var textEntityTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loveWordsList = getAllTextEntities()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loveWordsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let textEntityCell = tableView.dequeueReusableCell(withIdentifier: "textEntityCell", for: indexPath) as? TextEntityTableViewCell else { return UITableViewCell() }
        let textEntity = loveWordsList[indexPath.row]
        textEntityCell.wordLabel.text = textEntity.text

        return textEntityCell
    }
}
