//
//  CellProtocols.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 05.06.23.
//

import Foundation

// MARK: - Cell Model
public protocol CellModel {
    var cellIdentifier: String { get }
}

// MARK: - Cell View Model
public protocol CellViewModel {
    func configure(with model: CellModel)
}
