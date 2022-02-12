//
//  UITableViewCell+Extensions.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import UIKit

extension UITableViewCell {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
