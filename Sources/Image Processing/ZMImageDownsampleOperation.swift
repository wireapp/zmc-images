//
// Wire
// Copyright (C) 2021 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//


import Foundation
import CoreServices
import UniformTypeIdentifiers

extension ZMImageDownsampleOperation {
    @objc
    func createImageProperties(uti: String, imageSize: CGSize) -> ZMIImageProperties? {
        
        let mimeType: String
        if #available(iOS 14, *) {
            guard let utType = UTType(uti) else {
                return nil
            }
            ///TODO: hard code table?
//            let jpg = UTType.jpeg

            guard let preferredMIMEType = utType.preferredMIMEType else {
                return nil
            }

            mimeType = preferredMIMEType
        } else {
            let unmanagedMime = UTTypeCopyPreferredTagWithClass(uti as CFString, kUTTagClassMIMEType)
            
            guard let retainedValue = unmanagedMime?.takeRetainedValue() else {
                return nil
            }

            mimeType = retainedValue as String
        }
        
        
        return ZMIImageProperties(
            size: imageSize,
            length: UInt(downsampleImageData.count),
            mimeType: mimeType)
    }
}
