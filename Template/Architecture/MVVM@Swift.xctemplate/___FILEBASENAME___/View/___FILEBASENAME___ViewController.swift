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

//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 调用ViewModel方法
//        DataDriver(self)?.fetchData()
        self.config()
        self.setUpViews()
        self.bindViewData()
    }
    
    private func config() {
        
    }
    
    private func setUpViews() {
        
    }
    
    private func bindViewData() {
        
    }
    
    
    
//MARK:- Change UI State
    
//MARK:- UIControlDelegate
    
//MARK:- Getter
}
