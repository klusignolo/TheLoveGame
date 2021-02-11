//
//  LaunchScreenViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 11/4/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    private let loveGameVCIdentifier = "LoveGameViewController"
    @IBOutlet weak var heartIcon: UIImageView!
    private let heartImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 129))
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .loveRed
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(heartImage)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        heartImage.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
    
    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.heartImage.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
        })
        
        UIView.animate(withDuration: 2, animations: {
            self.heartImage.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    let storyboard = UIStoryboard(name: "LoveGame", bundle: nil)
                    let loveGameVC = storyboard.instantiateViewController(identifier: self.loveGameVCIdentifier) as! LoveGameViewController
                    loveGameVC.modalPresentationStyle = .fullScreen
                    loveGameVC.modalTransitionStyle = .crossDissolve
                    self.present(loveGameVC, animated: true)
                })
            }
        })
    }
}
