//
//  QRScannerViewController.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 06.06.23.
//

import AVFoundation
import UIKit

// MARK: - QRScanner View Controller
public class QRScannerViewController: UIViewController {
    // MARK: Subviews
    private let QRCodeFrameView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = Model.Color.QRFrameBorder.cgColor
        view.layer.borderWidth = Model.Layout.QRFrameBorderWidth
        return view
    }()
    
    // MARK: Properties
    public var presenter: QRScannerPresentable!
    private let captureSession: AVCaptureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    private typealias Model = QRScannerUIModel
    
    // MARK: Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCaptureSession()
        initializeVideoPreview()
        addSubviews()
        
        presenter.viewDidLoad()
    }
    
    // MARK: setup
    private func addSubviews() {
        view.layer.addSublayer(videoPreviewLayer!)
        view.addSubview(QRCodeFrameView)
    }
    
    // MARK: initializing properties
    private func initializeCaptureSession() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: AVMediaType.video,
            position: .back
        )

        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        } catch {
            print("Error occured while getting an instance of the AVCaptureDeviceInput \(error)")
        }
    }
    
    private func initializeVideoPreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
    }
}

// MARK: AV Capture Metadata Outpout Objects Delegate
extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            QRCodeFrameView.frame = CGRect.zero
            return
        }

        let metadata = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadata.type == AVMetadataObject.ObjectType.qr {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadata)
            QRCodeFrameView.frame = barCodeObject!.bounds
            view.bringSubviewToFront(QRCodeFrameView)
            
            if let capturedText = metadata.stringValue {
                presenter.QRCapturedSuccessfully(capturedText)
            }
        }
    }
}

// MARK: QR Scanner Viewable
extension QRScannerViewController: QRScannerViewable {
    public func startCapturing() {
        DispatchQueue.global().async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    public func stopCapturing() {
        captureSession.stopRunning()
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
