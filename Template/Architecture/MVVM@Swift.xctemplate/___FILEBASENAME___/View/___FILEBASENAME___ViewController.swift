//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import XFLegoVIPER

private func DataDriver(_ viewController: UIViewController) ->___FILEBASENAMEASIDENTIFIER___DataDriverProtocol? { return viewController.dataDriver as? ___FILEBASENAMEASIDENTIFIER___DataDriverProtocol }

class ___FILEBASENAMEASIDENTIFIER___ViewController: UIViewController, ___FILEBASENAMEASIDENTIFIER___ViewProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    //MARK:- Getter
    
}

//MARK:- init UI
extension ___FILEBASENAMEASIDENTIFIER___ViewController {
    
    fileprivate func setUpUI() {
        config()
        setUpViews()
        bindViewData()
    }
    
    private func config() {
        
    }
    
    private func setUpViews() {
        
    }
    
    private func bindViewData() {
        // 调用ViewModel方法
        //        DataDriver(self)?.fetchData()
    }
}

//MARK:- Change UI State
extension ___FILEBASENAMEASIDENTIFIER___ViewController {
    
}

//MARK:- DataSource
extension ___FILEBASENAMEASIDENTIFIER___ViewController {
    
}

//MARK:- UIControlDelegate
extension ___FILEBASENAMEASIDENTIFIER___ViewController {
    
}
