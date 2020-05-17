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
    @IBOutlet weak var quoteTableView: UITableView!
    
    var quotes: [Quote] = [Quote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicImageView.makeRounded()
        
        quoteTableView.tableFooterView = UIView(frame: .zero)
        quoteTableView.register(R.nib.quoteTableViewCell)
        quoteTableView.dataSource = self
        quoteTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let safeUsername = User.currentUser?.login,
            let safeFavCount = User.currentUser?.publicFavoritesCount,
            let safePicURL = User.currentUser?.picURL else {
                return
        }
        
        usernameLabel.text = safeUsername
        favQuoteLabel.text = "I like \(safeFavCount) quote(s)"
        profilePicImageView.af.setImage(withURL: URL(string: safePicURL)!)
        
        if NetworkManager.isConnected() {
            getQuotes(username: safeUsername, completion: {
                
            })
        } else {
            quotes = UserDefaultsHelper.getQuotes()?.quotes as! [Quote]
            quoteTableView.reloadData()
        }
        
    }
    
    func getQuotes(username: String, completion: (() -> ()?)) {
        RequestManager.sharedInstance.getLikedQuotes(username: username) { result in
            switch result {
            case .success(let quotesResult):
                self.quotes = quotesResult.quotes
                UserDefaultsHelper.set(quotes: quotesResult)
                self.quoteTableView.reloadData()
            case .failure(_):
                return
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.quoteTableViewCell, for: indexPath)!
        cell.setData(quote: self.quotes[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

