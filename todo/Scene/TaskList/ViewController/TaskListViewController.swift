//
//  TaskListViewController.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import UIKit

protocol TaskListDisplayLogic: AnyObject {
  func displayTasks(viewModel: TaskList.FetchTasks.ViewModel)
  func displayNewTaskAddition(viewModel: TaskList.AddNewTask.ViewModel)
  func displayTaskEditing(viewModel: TaskList.EditTask.ViewModel)
  func displayTaskDeletion(viewModel: TaskList.DeleteTask.ViewModel)
}

final class TaskListViewController: UIViewController {
  @IBOutlet private weak var tableView: UITableView!
  
  var interactor: TaskListBusinessLogic!
  var router: TaskListRoutingLogic!
  
  private var tableViewDataSource: TaskListTableViewDataSource!
  private var tableViewDelegate: TaskListTableViewDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavigationItem()
    configureTableView()
    fetchTasks()
  }
}

// MARK: TaskListViewController Scoped Methods

private extension TaskListViewController {
  func configureNavigationItem() {
    navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
      navigationItem.title = "Todo"
  }
  
  func configureTableView() {
    tableView.register(ItemTableViewCell.nib, forCellReuseIdentifier:ItemTableViewCell.reuseIdentifier)
    tableViewDataSource = TaskListTableViewDataSource(cellDeletionHandler: deleteCell)
    tableViewDelegate = TaskListTableViewDelegate(cellSelectionHandler: selectedCell)

    tableView.dataSource = tableViewDataSource
    tableView.delegate = tableViewDelegate

    tableView.tableFooterView = UIView()
  }
  
  func fetchTasks() {
    let request = TaskList.FetchTasks.Request()
    interactor.fetchTasks(request: request)
  }
  
  @objc func didTapAddButton() {
    let request = TaskList.AddNewTask.Request()
    interactor.addNewTask(request: request)
  }
  
  func selectedCell(at indexPath: IndexPath) {
    let request = TaskList.EditTask.Request(index: indexPath.row)
    interactor.editTask(request: request)
  }
  
  func deleteCell(at indexPath: IndexPath) {
    let request = TaskList.DeleteTask.Request(index: indexPath.row)
    interactor.deleteTask(request: request)
  }
}

// MARK: Display Logic

extension TaskListViewController: TaskListDisplayLogic {
  func displayTasks(viewModel: TaskList.FetchTasks.ViewModel) {
    tableViewDataSource.cellViewModels = viewModel.cellViewModels
    tableView.reloadData()
    handleEmptyState(for: viewModel.cellViewModels)
  }
  
  func displayNewTaskAddition(viewModel: TaskList.AddNewTask.ViewModel) {
    router.routeToTaskEditor(viewModel: viewModel)
  }
  
  func displayTaskEditing(viewModel: TaskList.EditTask.ViewModel) {
    router.routeToTaskEditorForEditing(viewModel: viewModel)
  }
  
  func displayTaskDeletion(viewModel: TaskList.DeleteTask.ViewModel) {
    tableViewDataSource.cellViewModels = viewModel.cellViewModels
    handleEmptyState(for: viewModel.cellViewModels)
  }
}

private extension TaskListViewController {
  func handleEmptyState(for viewModels: [ItemCellViewModelable]) {
    tableView.backgroundView = viewModels.count == 0 ? TaskListEmptyStateView.loadFromNib() : nil
  }
}
