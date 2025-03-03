//
//  SinereStyleAiLayoutFlow.swift
//  Sinere
//
//  Created by Sinere on 2024/11/22.
//

import Foundation
import UIKit

class SinereStyleAiLayoutFlow: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let sneLayoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var sneAdjustedAttributes: [UICollectionViewLayoutAttributes] = []
        var sneMaxYAttribute: UICollectionViewLayoutAttributes?
        
        for (attributeIndex, theOneAttribate) in sneLayoutAttributes.enumerated() {
            let snePreviousAttribute = attributeIndex == 0 ? nil : sneLayoutAttributes[attributeIndex - 1]
            let sneNextIndex = attributeIndex + 1
            let sneNextAttribute = sneNextIndex == sneLayoutAttributes.count ? nil : sneLayoutAttributes[sneNextIndex]
            
            sneAdjustedAttributes.append(theOneAttribate)
            
            let snePreviousY = snePreviousAttribute?.frame.maxY ?? 0
            let sneCurrentY = theOneAttribate.frame.maxY
            let sneNextY = sneNextAttribute?.frame.maxY ?? 0
            
            if sneCurrentY != snePreviousY && sneCurrentY != sneNextY {
                adjustmentItemPosition(for: &sneAdjustedAttributes)
            } else if sneCurrentY != sneNextY {
                adjustmentItemPosition(for: &sneAdjustedAttributes)
            }
            
            if sneMaxYAttribute == nil || (sneMaxYAttribute!.frame.origin.y < theOneAttribate.frame.origin.y) {
                sneMaxYAttribute = theOneAttribate
            }
        }
        
        return sneLayoutAttributes
    }
    
    private func adjustmentItemPosition(for layoutAttributes: inout [UICollectionViewLayoutAttributes]) {
        var sneInitialX = self.sectionInset.left
        for attributes in layoutAttributes {
            
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                sneInitialX = 0
            } else {
                var sneNewFrame = attributes.frame
                sneNewFrame.origin.x = sneInitialX
                attributes.frame = sneNewFrame
                sneInitialX += sneNewFrame.size.width + self.minimumInteritemSpacing
            }
        }
        layoutAttributes.removeAll()
    }
    
    override var collectionViewContentSize: CGSize {
        let sneContentSize = super.collectionViewContentSize
        guard sneContentSize.width > 0 else { return .zero }
        let width = collectionView?.bounds.size.width ?? 0
        return CGSize(width: width, height: sneContentSize.height + self.minimumLineSpacing)
    }
}
