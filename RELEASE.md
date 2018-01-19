# V4.9.0
### 新增外接事件发射器插件机制
## New Feture:
1. 通过框架提供的事件发射器插件机制，可以外接各种全局事件：应用生命周期的通知（框架内置扩展`XFApplicationEmitter`，不需要的话可删除，不会影响框架运行）、网络连接的状态（Demo中提供了`XFNetworkEmitter`的参考方式）。其它的自定义事件扩展实现可参考以下代码：
```objc
#import "XFEmitterPlug.h"

@interface XFNetworkEmitter : NSObject <XFEmitterPlug>

@end


#import <AFNetworking.h>

#define AFNetworkReachabilityStatusArray \
@"AFNetworkReachabilityStatusUnknown", \
@"AFNetworkReachabilityStatusNotReachable", \
@"AFNetworkReachabilityStatusReachableViaWWAN", \
@"AFNetworkReachabilityStatusReachableViaWiFi"

@implementation XFNetworkEmitter

- (void)prepare
{
    XF_Def_TypeStringArray(AFNetworkReachabilityStatusArray)
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         // self.pipe这个管道框架会自动注入，无需自己创建
         [self.pipe emitEventName:XF_Func_TypeEnumToString(status+1, typeList) intentData:nil];
     }];
}

- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}
@end
```

# V4.8.0
### EventBus添加Time Loop

## New Feture:
1. 所有实现`XFComponentRouable`接口的组件事件层通过EventBus提供的Timer机制，实现做定时任务工作，需实现`-run`方法，其它常用方法如下：
  
  * setupTimerWithTimeInterval: 初始化定时器
  * startTimer: 启动定时器
  * pauseTimer: 暂停定时器
  * resumeTimer: 恢复/重启定时器
  * stopTimer: 停止/销毁定时器


# V4.7.0
### MVVM模块继续加强，细节改进
## New Feture:
1. 抽取VIPER里的Express到Component层，使MVVM及其它模块可以拥有些功能，通过ExpressPack来填充数据

## API Breaking:
1. 组件事件层方法`-xfLego_viewWillPopOrDismiss`改为`-viewWillPopOrDismiss`
2. 框架内部接口`XFComponentUIEvent`改为`XFComponentEventResponder`，同时删除不常用的`-dismissKeyboard `方法
3. VIPER模块事件层方法移除`-xfLego_onBackItemTouch`和`-xfLego_onDismissItemTouch `方法，改为各模块通用的`-popViewAction`和`-dismissViewAction`，并且删除`errorMessage `成员变量

## Improving:
1. 优化模块抽象层的代码，使用通用的生命周期处理方式，方便后期管理维护


# V4.6.0
### 任何对象都可成为事件接收者
## New Feture:
1. 所有对象都可以成为事件接收对象，实现步骤:

- 实现接口`XFEventDispatchPort`的方法
- 注册到组件管理`XFComponentManager`，通过`addEventReceiver:componentName:(NSString *)componentName`方法

# V4.5.0
### 引擎在组件在移除行为上的改进
## New Feture:
1. 所能模式(MVC、MVVM、VIPER...)组件的控制器视图添加一个`-xfLego_enableAutoRemoveSelfComp`钩子方法，用于框架无法考虑到的常驻在TabBar上子控制器及多级下时可移除情况，可覆盖这个方法返回`NO`来防止被框架自动移除

## Improving:
1. `LEMVVMConnector`类的功能代码优化

## Fix Bugs:
1. 修复组件发送事件可能由于组件被移除而无法接收的问题


# V4.4.3
### 迷你MVVM开发方式加强版
## New Feture:
1. 支持实现协议`LEMVVMIntent`和调用`LEMVVMConnector`方法`makeComponentFromUInterface:forName:intentData:`双方式

## Improving:
1. 内部对`LEMVVMConnector`重载方法重构

# V4.4.2
## New Feture:
1. MVVM模块Extra里添加`intentData`，在控制器上可以设置意图数据传输至事件层

## API Breaking:
1. MVVM模块Extra扩展协议名改为`LEMVVMIntent`, 支持设置自定义的组件名和组件意图数据

# V4.4.1
## New Feture:
1. MVVM模块Extra添加`compName`，在控制器上可以设置自定义组件名，再通过继承`LEMVVMNavigationController`来连接到乐高组件容器


# V4.4.0
### 旧项目的过渡方案来了之系列二，支持无厘头项目的多前辍问题
## New Feture:
1. 添加多前辍可选列表方法`-setClassPrefixList:`，通过给出的可选前辍列表，框架会自动为你找到相应的模块，且旧版设置前辍方法不受影响

## Improving:
1. 针对虚拟组件优化基因组件名（以前的叫法是：父模块名）查找的算法，现可支持`多单词基因组件名+多单词虚拟组件名`，如：
```ini
基因组件名：PostPage
虚拟组件名: NewAllPostPage、NewVideoPostPage
```

2. 框架内部针对模块匹配核心代码抽取与重构

>> 注：框架中的组件名和模块名是等同的概念

# V4.3.1
## Improving:
1. 针对Extra的MVVM扩展支持自定义组件名
## Fix Bugs:
1. 修复Extra的MVVM组件入口对象添加错误问题


# V4.3.0
### 旧项目的过渡方案来了之系列一，多种过渡方案任你选，可以是普通控制器添加到组件容器来接收组件事件，可以是无URL路由的MVVM组件连接器来转化你的控制器变身MVVM层的View，再添加一个ViewModel就Go了！
## New Feture:
1. `XFComponentManager`添加可加入普通控制器到组件容器的过渡方法`+addIncompatibleComponent:componentName:`, 在控制器的dealloc方法要调用`+removeIncompatibleComponentWithName:`移除
2. MVVM模块添加MVVM组件连接器`LEMVVMConnector`和连接器导航`LEMVVMNavigationController`, 同样是增加的过渡功能，使用普通的写法来达到组件事件数据传递的功能

## Fix Bugs:
1. 修复系统应用级通知在调用没有实现`-receiveComponentEventName:intentData:`方法的组件时崩溃的问题，感谢@shanshuiren


# V4.2.1
## Fix Bugs:
1. 修复子组件重复利用问题，`XF_SubUInterface_URL`不再有缓存组件功能，查找组件请使用`[XFComponent findComponentForName:@"xxx"]`方法。

# V4.2.0
### 历害了！框架内置支持系统应用级通知！
## New Feture:
1. 添加应用级别通知到框架，每个组件都可以通过`- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData`来获得转化后的组件事件
## Fix Bugs:
1. 修复使用OC代码跳转`[self.uiBus openURL:@"xx://xxx/xxx?nav=UI" withTransitionBlock:...`的present自定义跳转方式崩溃的问题

# V4.1.1
## Fix Bugs:
1. 修复VIPER组装宏`XF_AutoAssemblyModule_Fast`显示的警告问题
2. 修复MVVM模块expressData属性修饰问题


# V4.1.0
### 增强对Swift语言可选类型的支持，添加OC模块无前辍功能
## New Feture:
1. 内部纠正并添加关键API的参数是否为null的特性
2. 无前辍的OC模块也能被框架正确识别
3. Swift模板更新，针对不同的功能使用Extension方式

## Improving:
1. 优化查找父模块名的算法（注意：添加的虚拟组件名只能为一个单词）

# V4.0.0
### 全面支持Swift语言，可以混写OC、Swift模块组件及它们之间通过URL跳转，API使用还是原来的配方，还是同样的味道~
## New Feture:
1. 内部自动判断跳转的组件是属于OC模块还是Swift, 开发者可以同时开发OC模块和Swift，对旧项目过渡友好
2. 只有存在OC模块的情况才需要手动设置类前辍，纯Swift项目并不需要
3. 添加了一些用于适配Swift开发API接口，如：发送事件、组装方法
4. 针对Swift开发添加类似OC的模板文件，一键生成我们所需的各种模式(MVC、MVVM、VIPER)模块，加快开发者开发速度

## API Breaking:
1. 移除VIPER模块里Routing组装器里的对导航支持，因为和URL添加导航的方式有重复，使用组装方法参数简单化，对之前使宏组装方式影响不大

# V3.5.0
### 插件机制增强，加强核心代码针对插件的抽象化，目录结构调整更简结，可以安全升级，可以安全升级，可以安全升级，重要的事说三遍！！！
## New Feture:
1. UI总线类`XFUIBus`添加方法`+openURLForGetUInterface:`,通过URL获得一个组件的视图层
2. 添加组件URL参数针对https的url值传输的支持
3. 模块组件视图层添加`XFComponentUI`接口、事件层添加`XFComponentUIEvent`接口，用于处理通用功能


# V3.3.0
### 子组件的全模式支持
## New Feture:
1. MVVM/MVC 模式组件支持通过URL的方式添加子组件
2. 添加组件URL参数对url值传输的支持
## Fix Bugs:
1. 修复框架在加入旧项目中后，并没有一个组件时，卡在找不到组件处理器的断言的问题

# V3.2.1
### 一些细节的改进
## New Feture:
1. 各模式组件添加快速获得当前模块名`XF_ModuleName`（组件名)
2. MVVM模块的数据驱动层添加和VIPER模块事件层的双向数据绑定宏和按钮命令宏
## Improving:
1. 优化查找父模块名的算法
## Fix Bugs:
1. 修复使用多变参数发送组件事件数据的问题

# V3.2.0
### 多实例模式组件，动态URL参数传递，全局事件组件数据发送
## New Feture:
1. 添加了`navC`使用导航类名的行为参数,`navTitle`设置导航标题
2. 添加动态URL参数传递方式，避免硬编码的问题！
3. 界面层添加了一个双向绑定宏`XF_$_Input`,用于输入框控件类型
4. 组件管理器添加全局发送事件数据宏`XF_SendEventForComponent_`
5. 事件层添加键盘退出方法`-dismissKeyboard`
6. 添加MVC/MVVM模式组件创建多例的功能
## Fix Bugs:
1. 修复URL参数无法传中文值的问题

# V3.1.1
## Fix bugs:
1. 修复旧宏API`XF_ShowRootComponent2Window_`、`XF_PUSH_Component_`、`XF_Present_Component_`无法使用的问题

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
4. 修改组件可
