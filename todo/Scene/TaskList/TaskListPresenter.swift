//
//  TaskListPresenter.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TaskListPresentationLogic
{
  func presentSomething(response: TaskList.Something.Response)
}

class TaskListPresenter: TaskListPresentationLogic
{
  weak var viewController: TaskListDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: TaskList.Something.Response)
  {
    let viewModel = TaskList.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
