//
//  TTSegmentedControl+Rx.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

extension Reactive where Base: TTSegmentedControl {
    public var selectedSegmentIndex: ControlProperty<Int> {
        let selectedIndex = BehaviorSubject<Int>(value: base.currentIndex)
        
        base.didSelectItemWith = { (id: Int, _: String?) in
            selectedIndex.onNext(id)
        }
        
        return ControlProperty(values: selectedIndex.asObservable(),
                               valueSink: selectedIndex.asObserver())
    }
}
