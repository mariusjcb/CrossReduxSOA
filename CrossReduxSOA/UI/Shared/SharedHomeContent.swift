//
//  SharedHomeContentProtocol.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

protocol SharedHomeContent {
    func textForSearchingCriteria(_ searchingCriteria: String?) -> String
}

extension SharedHomeContent {
    var searchTextFieldPlaceholder: String {
        return "Search for details...".localized
    }
    
    func textForSearchingCriteria(_ searchingCriteria: String?) -> String {
        if searchingCriteria?.isEmpty == false {
            return "Searching for:".localized + " \(searchingCriteria!)"
        } else {
            return "No searching criteria".localized
        }
    }
}
