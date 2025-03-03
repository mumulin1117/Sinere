//
//  ImaginariumHandlerCollectionReusablePalette.swift
//  Sinere
//
//  Created by Sinere on 2024/11/22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ImaginariumHandlerCollectionReusablePalette: UICollectionReusableView {

    @IBOutlet weak var sneEnterCharacter: UILabel!
    @IBOutlet weak var sneEnterPlaceholder: UILabel!
    @IBOutlet weak var sneEnterTextPalette: UITextView!
    
    var sneEnterTextPaletteinputChanged:((String)->())?
    
    var sneDisposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.sneDisposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sneEnterTextPalette.rx.text.orEmpty.subscribe {[weak self] newValue in
            self?.sneEnterPlaceholder.isHidden = newValue.count > 0
            self?.sneEnterTextPaletteinputChanged?(newValue)
        }.disposed(by: sneDisposeBag)
        
        sneEnterCharacter.text = "Evnbtwetra xkkekynwjovrudbs".sinereString
        sneEnterPlaceholder.text = "Pjlyeuansleb yeenpteetro ithhbep kkaegywwjozrndqsw qyjouua mwiainht".sinereString
    }
    
}

class ImaginariumCollectionTitleReusablePalette: UICollectionReusableView {
    
    var reusableTitle:UILabel!
    
    var sneOptionalTitle:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        self.reusableTitle = UILabel()
        self.reusableTitle.textColor = .white
        self.reusableTitle.font = .systemFont(ofSize: 16, weight: .bold)
        self.addSubview(self.reusableTitle)
        self.reusableTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(24)
        }
        
        
        self.sneOptionalTitle = UILabel()
        self.sneOptionalTitle.textColor = .white
        self.sneOptionalTitle.alpha = 0.6
        self.sneOptionalTitle.font = .systemFont(ofSize: 14)
        self.addSubview(self.sneOptionalTitle)
        self.sneOptionalTitle.snp.makeConstraints { make in
            make.left.equalTo(self.reusableTitle.snp.right).offset(4)
            make.centerY.equalTo(self.reusableTitle.snp.centerY)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ImaginariumCollectionPalette:UICollectionViewCell {
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var imaginariumTitle: UILabel!
    
}
