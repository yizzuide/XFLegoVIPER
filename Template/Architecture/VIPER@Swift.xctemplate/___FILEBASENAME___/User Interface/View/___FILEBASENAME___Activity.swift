//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import XFLegoVIPER

private func EventHandler(_ activity: UIViewController) ->___VARIABLE_productName:identifier___EventHandlerPort? { return activity.eventHandler as? ___VARIABLE_productName:identifier___EventHandlerPort }

class ___VARIABLE_productName:identifier___Activity: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    //MARK:- Getter
    
}

//MARK:- init UI
extension ___VARIABLE_productName:identifier___Activity {
    
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
        // 调用事件层
        // EventHandler(self)?.clickAction()
    }
}

//MARK:- Change UI State
extension ___VARIABLE_productName:identifier___Activity : ___VARIABLE_productName:identifier___UserInterfacePort {
    
}

//MARK:- DataSource
extension ___VARIABLE_productName:identifier___Activity {
    
}

//MARK:- UIControlDelegate
extension ___VARIABLE_productName:identifier___Activity {
    
}
