//
//  UIViewController+Extensions.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import UIKit

extension UIViewController {
  static func loadFromNib() -> Self {
    func instantiateFromNib<T: UIViewController>() -> T {
      return T.init(nibName: String(describing: T.self), bundle: nil)
    }
    
    return instantiateFromNib()
  }
}
