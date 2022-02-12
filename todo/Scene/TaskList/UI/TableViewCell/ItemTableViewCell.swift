//
//  ItemTableViewCell.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet private weak var itemLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    accessoryType = .disclosureIndicator
  }
  
  func configureCell(with viewModel: ItemCellViewModelable) {
    itemLabel.text = viewModel.labelText
  }
}
