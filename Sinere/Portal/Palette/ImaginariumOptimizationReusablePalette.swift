//
//  ImaginariumOptimizationReusablePalette.swift
//  Sinere
//
//  Created by Sinere on 2024/11/22.
//

import UIKit

import RxSwift
import RxCocoa

class ImaginariumOptimizationReusablePalette: UICollectionReusableView {

    @IBOutlet weak var sneEnterCharacter: UILabel!
    @IBOutlet weak var imaginariumImage: UIImageView!
    @IBOutlet weak var imaginariumNotes: UIImageView!
    
    var imaginariumNotesTapNoti:(()->())?
    
    var sneDisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sneEnterCharacter.text = "Evnbtwetra xkkekynwjovrudbs".sinereString
        
        let imaginariumNotesTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imaginariumNotesTapSelector))
        imaginariumNotes.isUserInteractionEnabled = true
        imaginariumNotes.addGestureRecognizer(imaginariumNotesTapGestureRecognizer)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.sneDisposeBag = DisposeBag()
    }
    
    @objc func imaginariumNotesTapSelector(){
        imaginariumNotesTapNoti?()
    }
    
    
}
