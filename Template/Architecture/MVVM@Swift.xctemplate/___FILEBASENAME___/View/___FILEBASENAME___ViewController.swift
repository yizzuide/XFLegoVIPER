//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import XFLegoVIPER

private func DataDriver(_ viewController: UIViewController) ->___VARIABLE_productName:identifier___DataDriverProtocol? { return viewController.dataDriver as? ___VARIABLE_productName:identifier___DataDriverProtocol }

class ___VARIABLE_productName:identifier___ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    //MARK:- Getter
    
}

//MARK:- init UI
extension ___VARIABLE_productName:identifier___ViewController {
    
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
extension ___VARIABLE_productName:identifier___ViewController : ___VARIABLE_productName:identifier___ViewProtocol {
    
}

//MARK:- DataSource
extension ___VARIABLE_productName:identifier___ViewController {
    
}

//MARK:- UIControlDelegate
extension ___VARIABLE_productName:identifier___ViewController {
    
}
