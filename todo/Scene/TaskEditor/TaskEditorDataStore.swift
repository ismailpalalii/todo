//
//  TaskEditorDataStore.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import Foundation

enum TaskEditor {
  
  // MARK: Use cases
  
  enum SetupInitials {
    struct Request {}
    
    struct Response {
      let initialText: String?
    }
    
    struct ViewModel {
      let initialText: String?
    }
  }
  
  enum CompleteEntry {
    struct Request {
      let text: String
    }
    
    struct Response {}
    
    struct ViewModel {}
  }
}
