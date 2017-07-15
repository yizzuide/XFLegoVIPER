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

        // 调用事件层
        // EventHandler(self)?.clickAction()
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
