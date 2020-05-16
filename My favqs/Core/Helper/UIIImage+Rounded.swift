//
//  UIIImage+Rounded.swift
//  My favqs
//
//  Created by Valentin Limagne on 16/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
