//
//  NetworkManager.swift
//  My favqs
//
//  Created by Valentin Limagne on 16/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
