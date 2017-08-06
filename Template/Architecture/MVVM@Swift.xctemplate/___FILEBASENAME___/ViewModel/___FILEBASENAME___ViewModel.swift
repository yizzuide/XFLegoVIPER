//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import XFLegoVIPER

private func View(_ viewModel: LEViewModel) ->___FILEBASENAMEASIDENTIFIER___ViewProtocol? { return viewModel.view as? ___FILEBASENAMEASIDENTIFIER___ViewProtocol }

class ___FILEBASENAMEASIDENTIFIER___ViewModel: LEViewModel, ___FILEBASENAMEASIDENTIFIER___DataDriverProtocol{
    
    override func viewDidLoad() {
        //        print("当前组件名: \(XFComponentReflect.componentName(forComponent: self))")
        //        print("接收到了意图数据：\(self.componentData!)")
        
    }
    
}

//MARK:- Lego Life Cycle
extension ___FILEBASENAMEASIDENTIFIER___ViewModel {
    // 初始化视图数据
    override func initRenderView() {
        
    }
    
    // 绑定命令
    override func initCommand() {
        
    }
    
    // 注册通知
    override func registerMVxNotifactions() {
        
    }
    
    // 接收到组件返回数据
    override func onNewIntent(_ intentData: Any) {
        
    }
    
    // 接受到MVx构架通知或组件的事件
    override func receiveComponentEventName(_ eventName: String, intentData: Any?) {
        
    }
}

//MARK:- Action
extension ___FILEBASENAMEASIDENTIFIER___ViewModel {
    
}

//MARK:- ValidData
extension ___FILEBASENAMEASIDENTIFIER___ViewModel {
    
}

//MARK:- FetchData
extension ___FILEBASENAMEASIDENTIFIER___ViewModel {
    
}
