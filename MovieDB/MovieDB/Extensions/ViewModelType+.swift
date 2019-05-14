//
//  ViewModelType+.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

extension ViewModelType {
    func checkIfDataIsEmpty<T: Collection>(fetchItemsTrigger: Driver<Void>,
                                           loadTrigger: Driver<Bool>,
                                           items: Driver<T>) -> Driver<Bool> {
        return Driver.combineLatest(fetchItemsTrigger, loadTrigger)
            .map { $0.1 }
            .withLatestFrom(items) { ($0, $1.isEmpty) }
            .map { loading, isEmpty -> Bool in
                if loading { return false }
                return isEmpty
        }
    }
}
