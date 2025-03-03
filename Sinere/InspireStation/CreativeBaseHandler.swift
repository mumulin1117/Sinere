//
//  CreativeBaseHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/20.
//

import UIKit
import RxSwift
import RxCocoa

class CreativeBaseHandler: UIViewController {
    
    public let sneDisposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = UIColor.init(red: 4/255.0, green: 6/255.0, blue: 32/255.0, alpha: 1)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white, // 设置颜色
            .font: UIFont.systemFont(ofSize: 17, weight: .medium) // 设置字体和大小
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = titleAttributes
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        
        if let navigationController = self.navigationController {
            if navigationController.viewControllers.count > 2 {
                let sinereBarback = UIButton(type: .custom)
                sinereBarback.setImage(UIImage(named: "sineredAppBarBack"), for: .normal)
                sinereBarback.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                sinereBarback.contentHorizontalAlignment = .left
                sinereBarback.rx.tap.subscribe {[weak self] _ in
                    if let self = self {
                        self.navigationController?.popViewController(animated: true)
                    }
                }.disposed(by: sneDisposeBag)
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: sinereBarback)
            }
        }
        
    }
    
    
    public func sinereRightButtonItems(imageNames:[String],buttonClicks:[(()->())]){
        var rightBarButtonItems = [UIBarButtonItem]()
        for (index,imageName) in imageNames.enumerated() {
            let sinereBarback = UIButton(type: .custom)
            sinereBarback.setImage(UIImage(named: imageName), for: .normal)
            sinereBarback.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            sinereBarback.contentHorizontalAlignment = .right
            sinereBarback.rx.tap.subscribe {_ in
                buttonClicks[index]()
            }.disposed(by: sneDisposeBag)
            rightBarButtonItems.append(UIBarButtonItem(customView: sinereBarback))
        }
        navigationItem.rightBarButtonItems = rightBarButtonItems
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension CreativeBaseHandler:UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if let navigationController = self.navigationController{
            return navigationController.viewControllers.count > 2
        }
        
        return true
    }
}
