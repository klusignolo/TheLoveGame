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
    var wordType: WordType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: TextEntityTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: TextEntityTableViewCell.reuseIdentifier())
        loadWordList()
    }
    
    private func loadWordList() {
        if let type = wordType {
            loveWordsList = DBUtility.getAllTextEntities()
                .filter { $0.type == type.rawValue }
                .sorted(by: {
                    if $0.naughtyLevel == $1.naughtyLevel {
                        return $0.text! < $1.text!
                    } else {
                        return $0.naughtyLevel < $1.naughtyLevel
                    }
                })
            setTitle(type)
        }
    }
    
    private func setTitle(_ type: WordType) {
        var titleText = ""
        switch type {
        case .Action:
            titleText = "Actions"
        case .Adverb:
            titleText = "Adverbs"
            break
        case .Adjective:
            titleText = "Adjectives"
            break
        case .Beginning:
            titleText = "Beginnings"
            break
        case .Interjection:
            titleText = "Interjections"
            break
        case .Part:
            titleText = "Parts"
            break
        case .Pronoun:
            titleText = "Pronouns"
            break
        case .Punctuation:
            titleText = "Punctuation"
        break
        }
        self.title = titleText
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loveWordsList.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TextEntitySegue", sender: loveWordsList[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textEntity = loveWordsList[indexPath.row]
            let textEntityCell = tableView.dequeueReusableCell(withIdentifier: TextEntityTableViewCell.reuseIdentifier()) as! TextEntityTableViewCell
        textEntityCell.wordLabel.text = textEntity.text
        textEntityCell.naughtyLevelLabel.text = "Naughty Level: \(textEntity.naughtyLevel)"
            return textEntityCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TextEntitySegue" {
            if let textEntityVC =  segue.destination as? TextEntityViewController {
                textEntityVC.textEntity = sender as? TextEntity
            }
        }
    }
}
