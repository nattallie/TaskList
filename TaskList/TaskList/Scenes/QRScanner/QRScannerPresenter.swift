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
    private let router: QRScannerRoutable
    private var capturedMessage: String?
    
    // MARK: Initializer
    public init(view: QRScannerViewable, router: QRScannerRoutable) {
        self.view = view
        self.router = router
    }
    
    public func viewDidLoad() {
        view.startCapturing()
    }
    
    public func QRCapturedSuccessfully(_ text: String) {
        view.stopCapturing()
        view.showAlertMessage(title: Consts.Scenes.QRScanner.qrScanSuccess, message: Consts.Scenes.QRScanner.qrScanSuccessMessage + text)
        capturedMessage = text
    }
    
    public func didTapAlertActionOK() {
        router.dismissModal(message: capturedMessage ?? "")
    }
}
