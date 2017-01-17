# V2.6.0
- 修复使用Present方式跳转组件时，框架无法侦听dismiss事件，导致生命周期出现异常
- URL组件跳转新增保留行为参数`nav`，用于包装对象组件到导航控制器，适用于模块组件和控制器组件
- UI总线内部针对URL参数和Intent对象区别处理

# V2.5.0
- 乐高框架内部重组目录结构，使代码结构更清晰明了
- 增强对控制器组件的支持，使普通控制器可以通过`XF_EXPORT_COMPONENT`导出为组件
- 统一模块组件和控制器组件的UI总线(现可设置HTTP处理组件)、事件总线(内部改为可对组件发事件消息)、组件数据传递API
- 增加Real-Time组件链跟踪功能
- 乐高替换内部控制器分类方法覆盖为swizzle方法，提升代码安全性
- 框架修改意图回传方法名为`-onNewIntent:`，和接收事件方法统一名称


# V2.0.0
- Remove macro of using `Routing` class to transition between modules (移除直接通过Routing类来做模块跳转,升级要谨慎！)
- change named `moudle` to `module` (全局修正API模块名‘moudle’->‘module’,升级要谨慎！)
- Reconstruction some function from Routing class to three: `XFUIBus`、`XFEventBus`、`XFModuleAssembly` (重构Routing代码为三个类：XFUIBus、XFEventBus、XFModuleAssembly)
- add `XFExpressPack` render data package function to `Presenter` (新增XFExpressPack渲染数据包功能)
- Fix crash bug in some condition (修复在多次快速切换模块界面的情况下崩溃问题)
- A new way of auto assemble module that using one line macro (`XF_AutoAssemblyModule_Fast`) as fast as possible (全新的全自动模块组装功能，仅一行无参数宏代码<XF_AutoAssemblyModule_Fast>)
- Add using module name to transition between modules (新增以模块名跳转API宏)
- Add using URL component to transition between modules, also support controller (新增以URL组件跳转API宏,针对UITabBarController重新改造模块管理生命周期及子模块绑定)
- Add share module macro within `Routing` layer (`XF_AutoAssemblyModuleFromShareModuleName(shareModuleName)`) to create multi-instance module (添加基于其它模块组件成份类的模块共享功能,使用宏`XF_AutoAssemblyModuleFromShareModuleName(shareModuleName)`，可使用模块共享功能来实现模块多例的创建)
- Add auto assemble a custom navigation controller marco (`XF_AutoAssemblyModuleWithNav_Fast`) from project prefix (添加自动组装项目模块前辍的导航控制器的功能，使用宏`XF_AutoAssemblyModuleWithNav_Fast`)
- Don't need to set module prefix now, it will be auto inspect start at project running (内部完成自动分析模块前辍，以后不用再通过`[XFRoutingLinkManager setModulePrefix:@"xx"]`来配置)
- Add Routable interface `XFComponentRoutable` for VIPER module and MVx Controller (新增针对控制器添加`XFComponentRoutable`接口,用于组件传值的字典参数`URLParams`和自定义对象`componentData`两个)
- Advance performance for getting `Presenter` from `Activity` subviews (优化Activity子视图获得事件层的性能，重构切换组件化控制器的代码，)
- change receive event method to `-receiveComponentEventName:intentData:` (事件接收方法改为`-receiveComponentEventName:intentData:`,升级要谨慎！)
- Update assemble module method to `+assembleRouting` (更改内部重组模块构建方法`+assembleRouting`，使不同模块间继承时各自组装自己层)
