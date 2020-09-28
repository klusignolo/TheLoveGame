//
//  PartsOfSpeechTableViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/19/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit
import Foundation

class PartsOfSpeechTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: LoveSettingTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LoveSettingTableViewCell.reuseIdentifier())
    }
    
    enum wordTypeIndex: Int {
        case Part = 0
        case Actions = 1
        case Adjectives = 2
        case Adverbs = 3
        case Pronouns = 4
        case Beginnings = 5
        case Interjections = 6
        case Punctuation = 7
    }

    // MARK: - Table view data source
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoveWordsSegue" {
            let loveWordsVC = segue.destination as! LoveWordsTableViewController
            loveWordsVC.wordType = sender as? WordType
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let loveCell = tableView.dequeueReusableCell(withIdentifier: LoveSettingTableViewCell.reuseIdentifier()) as! LoveSettingTableViewCell
        switch wordTypeIndex.init(rawValue: indexPath.row) {
        case .Part:
            loveCell.leftLabel.text = "Parts"
            break
        case .Actions:
            loveCell.leftLabel.text = "Actions"
            break
        case.Adjectives:
            loveCell.leftLabel.text = "Adjectives"
            break
        case .Adverbs:
            loveCell.leftLabel.text = "Adverbs"
            break
        case .Pronouns:
            loveCell.leftLabel.text = "Pronouns"
            break
        case .Beginnings:
            loveCell.leftLabel.text = "Beginnings"
            break
        case .Interjections:
            loveCell.leftLabel.text = "Interjections"
            break
        case .Punctuation:
            loveCell.leftLabel.text = "Punctuation"
            break
        default:
            break
        }
        return loveCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch wordTypeIndex.init(rawValue: indexPath.row) {
        case .Part:
            performSegue(withIdentifier: "LoveWordsSegue", sender: WordType.Part)
            break
        case .Actions:
            performSegue(withIdentifier: "LoveWordsSegue", sender: WordType.Action)
            break
        case.Adjectives:
            performSegue(withIdentifier: "LoveWordsSegue", sender: WordType.Adjective)
            break
        case .Adverbs:
            performSegue(withIdentifier: "LoveWordsSegue", sender: WordType.Adverb)
            break
        case .Pronouns:
            performSegue(withIdentifier: "LoveWordsSegue", sender: WordType.Pronoun)
            break
        case .Beginnings:
            performSegue(withIdentifier: "LoveWordsSegue", sender: WordType.Beginning)
            break
        case .Interjections:
            performSegue(withIdentifier: "LoveWordsSegue", sender: WordType.Interjection)
            break
        case .Punctuation:
            performSegue(withIdentifier: "LoveWordsSegue", sender: WordType.Punctuation)
            break
        default:
            break
        }
    }
}
