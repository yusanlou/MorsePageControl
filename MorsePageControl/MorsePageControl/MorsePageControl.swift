//
//  MorsePageControl.swift
//  NTSLTerminus
//
//  Created by BackNotGod on 2017/4/6.
//  Copyright © 2017年 tom. All rights reserved.
//

import UIKit
import SnapKit

public var SCAL: CGFloat {
    get {
        return UIScreen.main.bounds.size.width / 320
    }
}

// point
class MorsePage: UIView {
    var selected = false
    var cornerRadius : CGFloat?{
        didSet{
            self.layer.cornerRadius = cornerRadius ?? 0
        }
    }
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class MorsePageControl: UIControl {
    
    var morsePages : [MorsePage] = []
    
    var selectedWidth : CGFloat = 12*SCAL
    var normalWith : CGFloat = 4*SCAL
    var intervalWith : CGFloat = 7*SCAL
    
    /// defalut is white
    var pageColor : UIColor?{
        didSet{
            for page in morsePages {
                page.backgroundColor = pageColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var currentPage : Int = 0 {
        didSet{
            if currentPage >= numberOfPages || currentPage < 0 {
                currentPage = 0
            }
            morsePages.forEach{$0.selected = false}
            if currentPage < morsePages.count {
                morsePages[currentPage].selected = true
            }
            updateLayout()
        }
    }
    
    var numberOfPages: Int = 0{
        didSet{
            if numberOfPages != morsePages.count {
                morsePages.forEach{$0.removeFromSuperview()}
                morsePages.removeAll()
                for i in 0..<numberOfPages {
                    let page = MorsePage.init()
                    page.selected = i == currentPage ? true : false
                    page.backgroundColor = pageColor ?? UIColor.blue
                    self.addSubview(page)
                    morsePages.append(page)
                    updateLayout()
                }
            }
            if numberOfPages <= 1 {
                self.isHidden = true
            }else{
                self.isHidden = false
            }
        }
    }
    
    override func updateConstraints() {
        var last : MorsePage?
        
        morsePages.forEach { (page) in
            page.cornerRadius = normalWith/2
            page.snp.remakeConstraints({ (make) in
                make.width.equalTo(page.selected ? self.selectedWidth : self.normalWith)
                make.height.equalTo(self.normalWith)
                if let _last = last{
                    make.left.equalTo(_last.snp.right).offset(self.intervalWith)
                }else{
                    if self.numberOfPages > 0 {
                        let left = (self.bounds.size.width - self.selectedWidth - CGFloat((self.numberOfPages - 1))*(self.normalWith+self.intervalWith))/2
                        make.left.equalTo(self.snp.left).offset(left)
                    }else{
                        make.left.equalTo(self.snp.left).offset(self.intervalWith)
                    }
                }
                make.centerY.equalTo(self)
            })
            last = page
        }
        
        super.updateConstraints()
    }
    
    func updateLayout() {
        
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
        
        UIView.animate(withDuration: 0.3, animations: { 
            self.layoutIfNeeded()
        }) 
    }
}

