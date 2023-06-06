//
//  QRScannerRouter.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 06.06.23.
//

import UIKit

// MARK: - QRScanner Router
public class QRScannerRouter: QRScannerRoutable {
    // MARK: Properties
    private unowned let controller: UIViewController
    private let capturedTextSaverCallback: (String) -> Void
    
    // MARK: Initializer
    public init(controller: UIViewController, capturedTextSaver: @escaping (String) -> Void) {
        self.controller = controller
        self.capturedTextSaverCallback = capturedTextSaver
    }
    
    public func dismissModal(message: String) {
        controller.dismiss(animated: true, completion: { [weak self] in
            self?.capturedTextSaverCallback(message)
        })
    }
}
