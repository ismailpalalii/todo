//
//  TaskListInteractor.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

protocol TaskListBusinessLogic: AnyObject {
  func fetchTasks(request: TaskList.FetchTasks.Request)
  func addNewTask(request: TaskList.AddNewTask.Request)
  func editTask(request: TaskList.EditTask.Request)
  func deleteTask(request: TaskList.DeleteTask.Request)
}

final class TaskListInteractor {
  private let persistenceLayer: PersistenceLayer
  private let dataStore: TaskListDataStoreProtocol
  private let presenter: TaskListPresentationLogic
  
  init(persistenceLayer: PersistenceLayer,
       dataStore: TaskListDataStoreProtocol,
       presenter: TaskListPresentationLogic) {
    
    self.persistenceLayer = persistenceLayer
    self.dataStore = dataStore
    self.presenter = presenter
  }
}

// MARK: Business Logic

extension TaskListInteractor: TaskListBusinessLogic {
  func fetchTasks(request: TaskList.FetchTasks.Request) {
    let tasks = persistenceLayer.fetch()
    dataStore.tasks = tasks
    
    let response = TaskList.FetchTasks.Response(tasks: tasks)
    presenter.presentTasks(response: response)
  }
  
  func addNewTask(request: TaskList.AddNewTask.Request) {
    let response = TaskList.AddNewTask.Response(handler: addTaskHandler)
    presenter.presentNewTaskAddition(response: response)
  }
  
  func editTask(request: TaskList.EditTask.Request) {
    dataStore.editingTask = dataStore.tasks[request.index]
    
    // Force unwrapping here, because we are sure that the dataStore has editingTask
      let response = TaskList.EditTask.Response(initialText: dataStore.editingTask!.taskDescription, handler: editTaskHandler)
    presenter.presentTaskEditing(response: response)
  }
  
  func deleteTask(request: TaskList.DeleteTask.Request) {
    let taskToDelete = dataStore.tasks[request.index]
    persistenceLayer.delete(task: taskToDelete)
    dataStore.tasks = persistenceLayer.fetch()
    
    let response = TaskList.DeleteTask.Response(tasks: dataStore.tasks)
    presenter.presentTaskDeletion(response: response)
  }
}

// MARK: Operations

extension TaskListInteractor {
  func addTaskHandler(with description: String?) {
    guard let description = description,
          description.count > 0 else {
      print("Text is nil or empty, thus not added as a new task")
      return
    }
    
    persistenceLayer.save(text: description)
    updateTasks()
  }
  
  func editTaskHandler(with description: String?) {
    guard let description = description,
          description.count > 0 else {
      print("Text is nil or empty, thus not editing the task")
      return
    }
    
    guard let editingTask = dataStore.editingTask else {
      print("Editing task not found")
      return
    }
    
    persistenceLayer.update(task: editingTask, with: description)
    updateTasks()
    dataStore.editingTask = nil
  }
  
  func updateTasks() {
    dataStore.tasks = persistenceLayer.fetch()
    
    let response = TaskList.FetchTasks.Response(tasks: dataStore.tasks)
    presenter.presentTasks(response: response)
  }
}
