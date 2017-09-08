//
//  Func.swift
//  Trello
//
//  Created by Mac Book on 09/07/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation

/// Add inplace two dictionaries of same type
func += <K,V> (left: inout Dictionary<K,V>, right: Dictionary<K,V>?) {
  guard let right = right else { return }
  right.forEach { key, value in
    left.updateValue(value, forKey: key)
  }
}

/// Add inplace two arrays of same type
func += <V> (left: inout Array<V>, right: Array<V>?) {
  guard let right = right else { return }
  right.forEach { value in
    left.append(value)
  }
}

/// Add inplace array on left and same type on right
func += <V> (left: inout Array<V>, right: V?) {
  guard let right = right else { return }
  left.append(right)
}

extension Int {
  var i32: Int32 {
    return Int32.init(Double(self))
  }
}
