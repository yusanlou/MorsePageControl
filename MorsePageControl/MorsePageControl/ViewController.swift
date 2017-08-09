//
//  ViewController.swift
//  MorsePageControl
//
//  Created by BackNotGod on 2017/8/9.
//  Copyright © 2017年 BackNotGod. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    var pageControl : MorsePageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let page = MorsePageControl.init()
        self.view.addSubview(page)
        
        page.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
        page.numberOfPages = 10
        page.currentPage = 0
        pageControl = page
        
        let time = Timer.init(timeInterval: 1, target: self, selector: #selector(ViewController.autoPlay), userInfo: nil, repeats: true)
        RunLoop.current.add(time, forMode: RunLoopMode.commonModes)
        time.fire()
    }
    
    func autoPlay() {
        if let page = pageControl {
            page.currentPage = page.currentPage >= page.numberOfPages ? 0 : page.currentPage + 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

