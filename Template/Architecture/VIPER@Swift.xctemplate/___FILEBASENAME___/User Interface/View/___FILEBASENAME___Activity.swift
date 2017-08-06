//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import XFLegoVIPER

private func EventHandler(_ activity: UIViewController) ->___FILEBASENAMEASIDENTIFIER___EventHandlerPort? { return activity.eventHandler as? ___FILEBASENAMEASIDENTIFIER___EventHandlerPort }

class ___FILEBASENAMEASIDENTIFIER___Activity: UIViewController, ___FILEBASENAMEASIDENTIFIER___UserInterfacePort {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    //MARK:- Getter
    
}

//MARK:- init UI
extension ___FILEBASENAMEASIDENTIFIER___Activity {
    
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
extension ___FILEBASENAMEASIDENTIFIER___Activity {
    
}

//MARK:- DataSource
extension ___FILEBASENAMEASIDENTIFIER___Activity {
    
}

//MARK:- UIControlDelegate
extension ___FILEBASENAMEASIDENTIFIER___Activity {
    
}
