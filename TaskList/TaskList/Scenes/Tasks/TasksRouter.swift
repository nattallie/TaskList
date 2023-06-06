//
//  TasksRouter.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 06.06.23.
//

import UIKit

// MARK: - Tasks Router
public class TasksRouter: TasksRoutable {
    // MARK: Properties
    private unowned let controller: UIViewController
    
    // MARK: initializer
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    public func navigateToQRScanner() {
        let scannerVC: UIViewController = QRScannerFactory.create()
        controller.modalPresentationStyle = .overFullScreen
        controller.present(scannerVC, animated: true)
    }
}
