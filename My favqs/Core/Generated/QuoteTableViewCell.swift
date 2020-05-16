//
//  QuoteTableViewCell.swift
//  My favqs
//
//  Created by Valentin Limagne on 16/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var nbFavLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(quote: Quote) {
        
        let tagString = quote.tags.joined(separator: ", ")
        
        bodyLabel.text = quote.body
        authorLabel.text = "- " + quote.author
        tagLabel.text = "tags: " + tagString
        
        if (quote.favoritesCount > 1) {
            nbFavLabel.text = "\(quote.favoritesCount) favs"
        } else {
            nbFavLabel.text = "\(quote.favoritesCount) fav"
        }
        
    }
}
