//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import XFLegoVIPER

private func Interactor(_ presenter: XFPresenter) ->___VARIABLE_productName:identifier___InteractorPort? { return presenter.interactor as? ___VARIABLE_productName:identifier___InteractorPort }
private func UserInterface(_ presenter: XFPresenter) ->___VARIABLE_productName:identifier___UserInterfacePort? { return presenter.userInterface as? ___VARIABLE_productName:identifier___UserInterfacePort }
private func Routing(_ presenter: XFPresenter) ->___VARIABLE_productName:identifier___WireFramePort? { return presenter.routing as? ___VARIABLE_productName:identifier___WireFramePort }

class ___VARIABLE_productName:identifier___Presenter: XFPresenter {
    
    override func viewDidLoad() {
        //        print("当前组件名: \(XFComponentReflect.componentName(forComponent: self))")
        //        print("接收到了意图数据：\(self.componentData!)")
    }
    
}

//MARK:- Lego Life Cycle
extension ___VARIABLE_productName:identifier___Presenter {
    // 初始化视图数据
    override func initRenderView() {
        //        Interactor(self)?.fetchData()
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
extension ___VARIABLE_productName:identifier___Presenter : ___VARIABLE_productName:identifier___EventHandlerPort {
    
}

//MARK:- ValidData
extension ___VARIABLE_productName:identifier___Presenter {
    
}
