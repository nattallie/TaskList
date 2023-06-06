//
//  QRScannerFactory.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 06.06.23.
//

import UIKit

// MARK: - QR Scanner Factory
public struct QRScannerFactory {
    // MARK: Initializers
    private init() {}
    
    // MARK: Factory
    public static func create(capturedTextSaver: @escaping (String) -> Void) -> UIViewController {
        let viewController: QRScannerViewController = .init()
        
        let presenter: QRScannerPresenter = .init(
            view: viewController,
            router: QRScannerRouter(controller: viewController, capturedTextSaver: capturedTextSaver)
        )
        
        viewController.presenter = presenter
        
        return viewController
    }
}
