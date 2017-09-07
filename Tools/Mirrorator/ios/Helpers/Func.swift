//
//  Func.swift
//  Trello
//
//  Created by Mac Book on 09/07/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation

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
