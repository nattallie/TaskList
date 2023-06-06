//
//  QRScannerInterface.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 06.06.23.
//

import Foundation

// MARK: - QRScanner Viewable
public protocol QRScannerViewable: AnyObject {
    func startCapturing()
    func stopCapturing()
    func showAlertMessage(title: String, message: String)
}

// MARK: - QRScanner Presentable
public protocol QRScannerPresentable {
    func viewDidLoad()
    func QRCapturedSuccessfully(_ text: String)
    func didTapAlertActionOK()
}

// MARK: - QRScanner Routable
public protocol QRScannerRoutable {
    func dismissModal(message: String)
}
