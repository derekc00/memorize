//
//  Array+Only.swift
//  memorize
//
//  Created by Derek Chang on 8/20/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import Foundation

extension Array {
    
    //return the first and only one element in array or nil
    var only: Element? {
        count == 1 ? first : nil
    }
}
