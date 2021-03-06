//
//  TaskListTableViewDataSource.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import UIKit

final class TaskListTableViewDataSource: NSObject, UITableViewDataSource {
  var cellViewModels: [ItemCellViewModelable] = []
  
  private var cellDeletionHandler: (IndexPath) -> Void
  
  init(cellDeletionHandler: @escaping (IndexPath) -> Void) {
    self.cellDeletionHandler = cellDeletionHandler
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let viewModel = cellViewModels[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier, for: indexPath) as! ItemTableViewCell
    cell.configureCell(with: viewModel)
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.performBatchUpdates {
        cellDeletionHandler(indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
  }
}

