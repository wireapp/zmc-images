//
//  ZMImageDownsampleOperation.swift
//  WireImages-ios
//
//  Created by Bill, Yiu Por Chan on 05.07.21.
//  Copyright © 2021 Wire. All rights reserved.
//

import Foundation
import CoreServices

extension ZMImageDownsampleOperation {
    @objc
    func createImageProperties(mimeType: NSString, imageSize: CGSize) -> ZMIImageProperties? {
        
        ///TODO: unmanagedFileUTI on M1 simulator
        let unmanagedFileUTI = UTTypeCopyPreferredTagWithClass(mimeType, kUTTagClassMIMEType)
        
        guard let retainedValue = unmanagedFileUTI?.takeRetainedValue() else {
            return nil
        }
        
        return ZMIImageProperties(
            size: imageSize,
            length: UInt(downsampleImageData.count),
            mimeType: retainedValue as String)
    }
}
