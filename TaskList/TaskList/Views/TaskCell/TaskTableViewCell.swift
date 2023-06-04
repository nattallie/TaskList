//
//  TaskTableViewCell.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 05.06.23.
//

import UIKit

// MARK: - Task Table View Cell
class TaskTableViewCell: UITableViewCell, CellViewModel {
    // MARK: Subviews
    private let dummyView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = Model.Layout.cornerRadius
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Model.Color.border.cgColor
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Model.Layout.spacing
        stackView.axis = .vertical
        return stackView
    }()
    
    private let taskLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = Model.Font.task
        label.textColor = Model.Color.text
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = Model.Font.title
        label.textColor = Model.Color.text
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = true
        textView.alwaysBounceVertical = true
        textView.showsVerticalScrollIndicator = false
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.font = Model.Font.description
        textView.textColor = Model.Color.text
        return textView
    }()
    
    // MARK: properties
    static let cellIdentifier = "TaskTableViewCell"
    
    private typealias Model = TaskTableViewCellUIModel
    
    // MARK: initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set Up
    private func setup() {
        contentView.backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(dummyView)
        dummyView.addSubview(stackView)
        
        stackView.addArrangedSubview(taskLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionTextView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            dummyView.leadingConstraint(toView: contentView, constant: Model.Layout.margin / 2),
            dummyView.trailingConstraint(toView: contentView, constant: -Model.Layout.margin / 2),
            dummyView.topConstraint(toView: contentView, constant: Model.Layout.margin / 2),
            dummyView.bottomConstraint(toView: contentView, constant: -Model.Layout.margin / 2),
            
            stackView.leadingConstraint(toView: dummyView, constant: Model.Layout.margin),
            stackView.trailingConstraint(toView: dummyView, constant: -Model.Layout.margin),
            stackView.topConstraint(toView: dummyView, constant: Model.Layout.margin),
            stackView.bottomConstraint(toView: dummyView, constant: -Model.Layout.margin),
            
            descriptionTextView.heightConstraint(relation: .greaterThanOrEqual, constant: Model.Layout.descriptionMinHeight)
        ])
    }
    
    // MARK: Configure
    func configure(with model: CellModel) {
        guard let taskDetails = model as? TaskDetails else { return }
        
        taskLabel.text = taskDetails.task
        titleLabel.text = taskDetails.title
        descriptionTextView.text = "📝: \(taskDetails.description)"
        dummyView.backgroundColor = UIColor(from: taskDetails.colorCode)
    }
}
