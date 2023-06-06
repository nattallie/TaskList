//
//  QRScannerPresenter.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 06.06.23.
//

import Foundation

// MARK: - QR Scanner Presenter
public class QRScannerPresenter: QRScannerPresentable {
    // MARK: Properties
    private unowned let view: QRScannerViewable
    
    // MARK: Initializer
    public init(view: QRScannerViewable) {
        self.view = view
    }
    
    public func viewDidLoad() {
        view.startCapturing()
    }
    
    public func QRCapturedSuccessfully(_ text: String) {
        view.stopCapturing()
        view.showAlertMessage(title: Consts.Scenes.QRScanner.qrScanSuccess, message: Consts.Scenes.QRScanner.qrScanSuccessMessage + text)
    }
    
    public func didTapAlertActionOK() {
    }
}
