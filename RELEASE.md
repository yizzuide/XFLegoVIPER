# V3.1.0
### 完全向后兼容的更新，使用V3.0.0的开发者可安全升级
## New Feature:
1. 模块组件添加针对键盘弹出通知的快速处理宏：注册键盘弹出通知`XF_RegisterKeyboardNotifaction`、处理键盘弹出通知`XF_HandleKeyboardNotifaction`、自动处理通用键盘弹出通知`XF_AutoHandleKeyboardNotifaction`，及组件界面通过`XFComponentUI`接口的`- (void)needUpdateInputUInterfaceY: durationTime:`方法来调整输入界面的Y值移动
2. 抽取共同模块代码到分类`UIViewController+ComponentUI`和`UIView+ComponentSubView`，用于扩展其它模式的模块组件快速开发，如乐高框架扩展的MVVM模块
3. 扩展的MVVM模块添加同VIPER模块一样的生命周期方法，如：`-viewWillAppear`、`-viewDidDisappear`、`-initCommand`、`-initRenderView`等等
4. 扩展的MVVM模块的ViewModel层添加同VIPER模块事件层的快递数据`expressData`属性，视图层可以通过接口`LEDataDriverProtocol`获取
## Fix bugs:
1. 修复导航按住向右划返回接着向左推恢复这个过程中，导致组件关联引用和当前组件被提前释放的问题


# V3.0.0
### 重新调整乐高框架目录相结构，重构核心代码，提供新的自定义扩展模块插件、URL路由插件机制，更好用的VIPER模块多例共享方式。

## New Feture：
1. 添加新方式共享模块宏`XF_AutoAssemblyModuleForShareShell_Fast`，配合在视图层使用宏`XF_SubUInterface_`或`XF_SubUInterface_URL`来动态添加子模块，不用再创建新的子路由类，使共享子模块更简单
2. 事件总线里统一使用新的宏`XF_SendEventForComponents_`来发送组件事件消息，组件名改为放到参数最后，并且使用的是可变参数
3. 事件总线里注册通知宏`XF_RegisterMVxNotis_`现已采用可变参数，多个通知名需用逗号分隔，以前接收单个数组方式将变得无效
4. 增强宏`XF_SubUInterface_`为添加子组件方式（兼容之前版本）
5. 新增宏`XF_SubUInterface_URL`使用URL组件的添加方式，支持`nav`添加导航的行为参数
6. 添加`XFLegoConfig`类用于配置框架的启动环境，使用类方法`+defaultConfig`设置默认配置
7. 新增URL路由插件化接口`XFRoutePlug`，可通过`XFLegoConfig`类的`-setRoutePlug`方法设置自定义URL规则的路由插件
8. UI总线类`XFUIBus`使用插件方式全面重构，现在可以扩展其它架构模式模块，如：MVVM (框架扩展已提供)、MVP、MVCS等
9. 框架配置类`XFLegoConfig`加入可添加组件处理器插件方法`-addComponentHanderPlug`

## API Breaking:
1. 移除事件总线里发送模块事件的旧API宏`XF_SendEventForModule_`、`XF_SendEventForModules_`、`XF_SendEventForComponent_`，统一使用`XF_SendEventForComponents_`
2. 移除`XFRoutingLinkManager`类的设置模块前辍方法`+setModulePrefix`和 `+modulePrefix`，框架内部实现自动检测类前辍的功能
3. 移除`XFComponentManager`类的`+enableLog`方法，这个方法移动到`XFLegoConfig`类中
4. 修改组件可运行接口名`XFControllerComponentRunnable`为`XFControllerRunnable`
5. 修改视图工厂类名`XFInterfaceFactory`为`XFUInterfaceFactory`
6. 移除视图工厂类宏`XF_UInterfaceForMVx_Show_Fast`和`XF_SubUInterfaceForMVx_AddChild_Fast`，统一用`XF_SubUInterface_`或`XF_SubUInterface_URL`代替
7. 修改XFRouting类方法名`-realInterface`为`-realUInterface`
8. 移除XFRouting类方法`-realNavigator`，使用`routing.realUInterface.navigationController`来获取
9. 移除VIPER模块有关导航组装宏：XF_AutoAssemblyModuleWithNav_ShareDM、XF_AutoAssemblyModuleWithNav、XF_AutoAssemblyModuleWithNav_Fast，另外XF_AutoAssemblyModule去掉`NavName`参数，使用全新统一的组件URL行为参数`nav=XX`来代替

## Fix bugs:
1. 修复组件名长度为2时，URL组件匹配失败问题
2. 修复VIPER模块子路由释放后没有被标识释放成功的问题

# V2.6.1
- 修复从控制器组件到模块组件情况下的URL行为参数`nav`来装配导航控制器而Crash的问题

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
