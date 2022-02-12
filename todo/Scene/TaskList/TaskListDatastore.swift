//
//  TaskListDatastore.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import Foundation

protocol TaskListDataStoreProtocol: AnyObject {
  var tasks: [TaskObject] { get set }
  var editingTask: TaskObject? { get set }
}

final class TaskListDataStore: TaskListDataStoreProtocol {
  var tasks: [TaskObject] = []
  var editingTask: TaskObject?
}
