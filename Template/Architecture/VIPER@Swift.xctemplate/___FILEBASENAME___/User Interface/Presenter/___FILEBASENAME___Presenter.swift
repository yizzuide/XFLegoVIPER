//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import XFLegoVIPER

private func Interactor(_ presenter: XFPresenter) ->___FILEBASENAMEASIDENTIFIER___InteractorPort? { return presenter.interactor as? ___FILEBASENAMEASIDENTIFIER___InteractorPort }
private func UserInterface(_ presenter: XFPresenter) ->___FILEBASENAMEASIDENTIFIER___UserInterfacePort? { return presenter.userInterface as? ___FILEBASENAMEASIDENTIFIER___UserInterfacePort }
private func Routing(_ presenter: XFPresenter) ->___FILEBASENAMEASIDENTIFIER___WireFramePort? { return presenter.routing as? ___FILEBASENAMEASIDENTIFIER___WireFramePort }

class ___FILEBASENAMEASIDENTIFIER___Presenter: XFPresenter, ___FILEBASENAMEASIDENTIFIER___EventHandlerPort {

    override func viewDidLoad() {
//        print("___FILEBASENAMEASIDENTIFIER___Presenter -- 当前组件名: \(XFVIPERModuleReflect.moduleName(forModuleLayerObject: self)))")
//        print("接收到了意图数据：\(self.componentData!)")
    }
    
    override func initRenderView() {
        
//        Interactor(self)?.fetchData()
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
    
}
