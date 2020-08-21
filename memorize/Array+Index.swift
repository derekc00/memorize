//
//  Array+Index.swift
//  memorize
//
//  Created by Derek Chang on 8/20/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element ) {
        for index in 0..<self.count {
            if self[index].id == matching.id{
                return index
            }
        }
    }
}
