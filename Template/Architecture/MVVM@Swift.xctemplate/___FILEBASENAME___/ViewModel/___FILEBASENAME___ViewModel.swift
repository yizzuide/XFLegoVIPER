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

//MARK:- Life Cycle
    override func viewDidLoad() {
//        print("当前组件名: \(LEMVVMModuleReflect.moduleName(for: self))")
//        print("接收到了意图数据：\(self.componentData!)")
        
    }
    
    // 初始化视图数据
    override func initRenderView() {
        
    }
    
    // 绑定命令
    override func initCommand() {
        
    }
    
    // 接收到组件返回数据
    override func onNewIntent(_ intentData: Any!) {
        
    }
    
    // 注册通知
    override func registerMVxNotifactions() {
        
    }
    
    // 接受到MVx构架通知或组件的事件
    override func receiveComponentEventName(_ eventName: String!, intentData: Any!) {
        
    }
    
    
//MARK:- Action
    
    
//MARK:- ValidData

    
    
//MARK:- FetchData
    
    
}
