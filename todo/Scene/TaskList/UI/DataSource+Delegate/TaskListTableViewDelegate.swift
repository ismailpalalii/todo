//
//  TaskListTableViewDelegate.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import UIKit

final class TaskListTableViewDelegate: NSObject, UITableViewDelegate {
  private var cellSelectionHandler: (IndexPath) -> Void
  
  init(cellSelectionHandler: @escaping (IndexPath) -> Void) {
    self.cellSelectionHandler = cellSelectionHandler
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    cellSelectionHandler(indexPath)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
