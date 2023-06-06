//
//  TasksViewController.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import UIKit

// MARK: - Tasks View Controller
public class TasksViewController: UIViewController {
    // MARK: Subviews
    private let containerView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Model.Color.background
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = Consts.Scenes.Tasks.title
        label.font = Model.Font.title
        label.textColor = Model.Color.title
        return label
    }()
    
    private lazy var QRButton: UIButton = {
        let button: UIButton = .init(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapQRButton), for: .touchUpInside)
        button.setImage(.init(systemName: "qrcode.viewfinder"), for: .normal)
        return button
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar: UISearchBar = .init()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = .init()
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.attributedTitle = NSAttributedString(string: Consts.Scenes.Tasks.pullToRefresh)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.register(
            TaskTableViewCell.self,
            forCellReuseIdentifier: TaskTableViewCell.cellIdentifier
        )
        tableView.separatorColor = .clear
        return tableView
    }()
    
    // MARK: Properties
    public var presenter: TasksPresentable!
    
    private typealias Model = TasksUIModel
    
    private var titleTopConstraint: NSLayoutConstraint?
    
    // MARK: Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        presenter.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        titleTopConstraint?.constant = UIApplication.shared.rootWindow?.safeAreaInsets.top ?? 0
    }
    
    // MARK: setUp
    private func setUp() {
        addSubviews()
        addConstraints()
        addKeyboardObservers()
    }
    
    private func addSubviews() {
        view.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(QRButton)
        containerView.addSubview(searchBar)
        containerView.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate(containerView.fillSuperView())
        NSLayoutConstraint.activate([
            titleLabel.leadingConstraint(toView: containerView, constant: Model.Layout.horizontalMargin),
            titleLabel.trailingConstraint(toView: containerView, constant: -Model.Layout.horizontalMargin),
            titleLabel.topConstraint(toView: containerView).reference(in: &titleTopConstraint),
            
            QRButton.trailingConstraint(toView: containerView, constant: -Model.Layout.horizontalMargin),
            QRButton.topConstraint(toView: titleLabel),
        
            searchBar.leadingConstraint(toView: containerView, constant: Model.Layout.horizontalMargin),
            searchBar.trailingConstraint(toView: containerView, constant: -Model.Layout.horizontalMargin),
            searchBar.topConstraint(toView: titleLabel, attribute: .bottom, constant: Model.Layout.spacing),
            
            tableView.leadingConstraint(toView: containerView, constant: Model.Layout.horizontalMargin),
            tableView.trailingConstraint(toView: containerView, constant: -Model.Layout.horizontalMargin),
            tableView.topConstraint(toView: searchBar, attribute: .bottom, constant: Model.Layout.spacing),
            tableView.bottomConstraint(toView: containerView)
        ])
    }
    
    // MARK: Keyboard Observers
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil,
            using: keyboardWillShow
        )
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil,
            using: keyboardWillHide
        )
    }
    
    private func keyboardWillShow(notification: Notification) {
        let keyboardInfo: SystemKeyboardInfo = .init(notification: notification)
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: keyboardInfo.frame.height + Model.Layout.spacing, right: 0)
    }
    
    private func keyboardWillHide(notification: Notification) {
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: Observers
    @objc func refresh(_ sender: AnyObject) {
        presenter.pullToRefresh()
    }
    
    @objc func didTapQRButton(_ sender: UIButton) {
        presenter.didTapQRButton()
    }
}

// MARK: - Tasks Viewable
extension TasksViewController: TasksViewable {
    public func refreshAllTasks() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.tableView.numberOfRows(inSection: 0) > 0 {
                self.tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    public func setSearchText(_ text: String) {
        DispatchQueue.main.async {
            self.searchBar.text = text
            self.searchBar.resignFirstResponder()
        }
    }
    
    public func endRefreshing() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    public func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: Consts.Common.OK,
                style: .default,
                handler: { [weak self] _ in
                    self?.presenter.didTapAlertActionOK()
                }
            )
        )
            
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

// MARK: - Search Bar Delegate
extension TasksViewController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchTextDidChange(searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        presenter.searchTextDidChange(searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}

// MARK: - Table View Data Source
extension TasksViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeued = tableView.dequeueReusableCell(
            withIdentifier: TaskTableViewCell.cellIdentifier,
            for: indexPath
        )
        presenter.configure(dequeued as! CellViewModel, at: indexPath.row)
        return dequeued
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfTasks
    }
}
