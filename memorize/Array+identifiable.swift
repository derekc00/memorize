//
//  Array+identifiable.swift
//  memorize
//
//  Created by Derek Chang on 8/18/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import Foundation

//only adds to identifiable arrays
extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id{
                return index
            }
        }
        return nil
    }
}
