//
//  UIViewController+Spinner.swift
//  My favqs
//
//  Created by Valentin Limagne on 16/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

extension UIViewController {
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnedView = UIView.init(frame: onView.bounds)
        spinnedView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnedView.center
        
        DispatchQueue.main.async {
            spinnedView.addSubview(ai)
            onView.addSubview(spinnedView)
        }
        return spinnedView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
