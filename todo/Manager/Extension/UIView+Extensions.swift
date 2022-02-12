//
//  UIView+Extensions.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import UIKit

extension UIView {
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: Self.self))
  }
  
  static func loadFromNib() -> Self {
    return Bundle(for: Self.self).loadNibNamed(String(describing: Self.self),
                                               owner: nil,
                                               options: nil)![0] as! Self
  }
}
