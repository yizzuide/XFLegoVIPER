//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import XFLegoVIPER

private func View(_ viewModel: LEViewModel) ->___VARIABLE_productName:identifier___ViewProtocol? { return viewModel.view as? ___VARIABLE_productName:identifier___ViewProtocol }

class ___VARIABLE_productName:identifier___ViewModel: LEViewModel {
    
    override func viewDidLoad() {
        //        print("当前组件名: \(XFComponentReflect.componentName(forComponent: self))")
        //        print("接收到了意图数据：\(self.componentData!)")
        
    }
    
}

//MARK:- Lego Life Cycle
extension ___VARIABLE_productName:identifier___ViewModel {
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
extension ___VARIABLE_productName:identifier___ViewModel : ___VARIABLE_productName:identifier___DataDriverProtocol {
    
}

//MARK:- ValidData
extension ___VARIABLE_productName:identifier___ViewModel {
    
}

//MARK:- FetchData
extension ___VARIABLE_productName:identifier___ViewModel {
    
}
