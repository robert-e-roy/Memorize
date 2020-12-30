//
//  Array+Only.swift
//  Memorize
//
//  Created by Robert Roy on 12/29/20.
//

import Foundation


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
