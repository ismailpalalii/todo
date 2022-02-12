//
//  PersistenLayer.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import Foundation

protocol TaskObject: AnyObject {
  var taskDescription: String { get set }
  var recordDate: Date { get set }
}

protocol PersistenceLayer: AnyObject {
  func fetch() -> [TaskObject]
  func save(text: String)
  func update(task: TaskObject, with text: String)
  func delete(task: TaskObject)
}
