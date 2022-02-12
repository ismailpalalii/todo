//
//  TaskEditorViewController.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import UIKit

protocol TaskEditorDisplayLogic: AnyObject {
    func displayInitials(viewModel: TaskEditor.SetupInitials.ViewModel)
    func displayEntryCompletion(viewModel: TaskEditor.CompleteEntry.ViewModel)
}

final class TaskEditorViewController: UIViewController {
    @IBOutlet private weak var textView: UITextView!
    
    var interactor: TaskEditorBusinessLogic!
    var router: (TaskEditorRoutingLogic & TaskEditorDataPassing)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTextView()
        setupInitials()
    }
}

// MARK: TaskEditorViewController Scoped Methods

private extension TaskEditorViewController {
    func configureNavigationItem() {
            navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
    }
    
    func configureTextView() {
        textView.becomeFirstResponder()
    }
    
    func setupInitials() {
        let request = TaskEditor.SetupInitials.Request()
        interactor.setupInitials(request: request)
    }
    
    @objc func didTapDoneButton() {
        let request = TaskEditor.CompleteEntry.Request(text: textView.text)
        interactor.completeEntry(request: request)
    }
    
    @objc func didTapCancelButton() {
        let request = TaskEditor.CompleteEntry.Request(text: textView.text)
        interactor.completeEntry(request: request)
    }
}

extension TaskEditorViewController: TaskEditorDisplayLogic {
    func displayInitials(viewModel: TaskEditor.SetupInitials.ViewModel) {
        textView.text = viewModel.initialText
    }
    
    func displayEntryCompletion(viewModel: TaskEditor.CompleteEntry.ViewModel) {
        router.routeToBack()
    }
}

