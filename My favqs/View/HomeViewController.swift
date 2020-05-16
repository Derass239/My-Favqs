//
//  HomeViewController.swift
//  My favqs
//
//  Created by Valentin Limagne on 16/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var favQuoteLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicImageView.makeRounded()
    }

    override func viewDidAppear(_ animated: Bool) {
        guard let safeUsername = User.currentUser?.login,
            let safeFavCount = User.currentUser?.publicFavoritesCount,
            let safePicURL = User.currentUser?.picURL else {
                return
        }
        
        usernameLabel.text = safeUsername
        favQuoteLabel.text = "I like \(safeFavCount) quote(s)"
        profilePicImageView.af.setImage(withURL: URL(string: safePicURL)!)
    }
}
