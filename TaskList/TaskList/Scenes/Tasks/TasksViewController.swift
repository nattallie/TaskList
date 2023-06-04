//
//  TasksViewController.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import UIKit

// MARK: - Tasks View Controller
public class TasksViewController: UIViewController {
    // MARK: Properties
    public var presenter: TasksPresentable!
    
    private typealias Model = TasksUIModel
    
    // MARK: Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - Tasks Viewable
extension TasksViewController: TasksViewable {}
