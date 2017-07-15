//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import XFLegoVIPER

class ___FILEBASENAMEASIDENTIFIER___Routing: XFRouting, ___FILEBASENAMEASIDENTIFIER___WireFramePort {

    // 实现父类组装函数
    open override class func assemble() -> Self {
        // 使用自动组装器方式
        let routing = self.standard()
        routing?.assembly.autoAssemblyModule() // 普通组件使用这个函数
//        routing?.assembly.autoAssemblyShareModule() // 虚拟组件时使用这个函数
        return routing!
    }
    
    /*func transition2XXX() {
        self.uiBus.openURL(forPush: "xx://xxx/xxx", customCode: nil)
    }*/
}
