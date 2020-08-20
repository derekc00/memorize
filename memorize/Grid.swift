//
//  Grid.swift
//  memorize
//
//  Created by Derek Chang on 8/18/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    //@escaping is needed because we are not using the function directly
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
        
    }
    
    func body(for size: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: size)
        }
    }
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item )!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
    
}
