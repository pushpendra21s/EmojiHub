//
//  ObservableUtility.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import Foundation

/**
        Generic class to observe the property changes
 
    This class is a Generic Listner class which is used to observe the change in value.
 */

class DataObservable<T> {
    typealias ValueHandler = (T?) -> Void
    var value: T? {
        didSet {
            self.listner?(value)
        }
    }
    init(_ value: T?) {
        self.value = value
    }
    
    private var listner: ValueHandler?
    func bindValue(_ listner:@escaping ValueHandler) {
        listner(value)
        self.listner = listner
    }
}
