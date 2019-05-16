//
//  DataSourceSection.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/16/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct Section<Item> {
    var items: [Item]
}

extension Section: SectionModelType {
    init(original: Section<Item>, items: [Item]) {
        self = original
        self.items = items
    }
}
