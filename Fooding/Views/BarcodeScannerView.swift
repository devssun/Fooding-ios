//
//  BarcodeScannerView.swift
//  Fooding
//
//  Created by 최혜선 on 05/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit
import AVFoundation

protocol BarcodeScannerViewDelegate: class {
    func detectBarcode(detectString: String)
}

class BarcodeScannerView: UIView {
    
    // for barcode
    fileprivate var video = AVCaptureVideoPreviewLayer()
    fileprivate let session = AVCaptureSession()
    fileprivate var codeFrameView: UIView?
    fileprivate var isRunStart: Bool = true
    weak var delegate: BarcodeScannerViewDelegate?
    
    fileprivate var warningLabel: UILabel = {
        let lb = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 150))
        lb.text = "카메라가 지원되지 않습니다"
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        lb.numberOfLines = 2
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        creatingCamera()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func runCamera(isRunStart: Bool = true) {
        print("바코드 스캔 상태 \(isRunStart ? "스캔 중" : "스캔 안함")")
        self.isRunStart = isRunStart
        self.isRunStart ? session.startRunning() : session.stopRunning()
    }
    
    private func creatingCamera() {
        self.backgroundColor = .lightGrey
        
        // define capture device
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            self.addSubview(warningLabel)
            warningLabel.sizeToFit()
            warningLabel.center = self.center
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            print(error)
            // 카메라 미 지원
            self.addSubview(warningLabel)
            warningLabel.sizeToFit()
            warningLabel.center = self.center
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // availableMetadataObjectTypes : An array of strings identifying the types of metadata objects that can be captured.
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = self.bounds // 전체 화면
        video.videoGravity = .resizeAspectFill
        self.layer.addSublayer(video)
        
        codeFrameView = UIView()
        if let codeFrameView = codeFrameView {
            codeFrameView.layer.borderColor = UIColor.green.cgColor
            codeFrameView.layer.borderWidth = 2.0
            self.addSubview(codeFrameView)
            self.bringSubviewToFront(codeFrameView)
        }
        
        // 세션시작
        session.startRunning()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.video.frame = self.bounds
    }
}

extension BarcodeScannerView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        var detectString: String = ""
        let barcodeTypes = [.upce, .code39, .code39Mod43, .ean13, .ean8, .code93,
                            .code128, .pdf417, .qr,
                            AVMetadataObject.ObjectType.aztec]
        
        // stop run 상태인 데 바코드 스캔된 경우 다시 session 종료
        guard isRunStart else {
            print("바코드 스캔을 종료합니다")
            self.session.stopRunning()
            return
        }
        
        if metadataObjects.count == 0 {
            codeFrameView?.frame = .zero
            return
        }
        if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
            for barcodeType in barcodeTypes {
                if (metadataObjects[0] as AnyObject).type == barcodeType {
                    
                    codeFrameView?.frame = object.bounds
                    
                    // paste clipboard
                    UIPasteboard.general.string = object.stringValue
                    detectString = object.stringValue!
                    session.stopRunning()
                    // 2초 후 실행
                    self.delegate?.detectBarcode(detectString: detectString)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        self.session.startRunning()
                    }
                    break
                }
            }
        }
    }
}
