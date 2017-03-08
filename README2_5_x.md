# 1. Getting Started (快速开始)

Welcome to XFLegoVIPER!

This is a guide to help developers get up to speed with XFLegoVIPER. It is geared primarily towards anyone who is know VIPER design pattren.
XFLegoVIPER is based on a modular, and partially support URL route architecture, allowing route a VIPER module as well as ViewController.

> **注意**：XFLegoVIPER框架的中文名为`乐高`。

### 我们来构建第一个模块

#### 从零开始

在开始构建一个模块前，我们先约定好一些规范，这样就可以快速创建一个模块，并可以自动加载到框架的运行容器。

* ##### 组件名

  在乐高世界里把VIPER的模块名和MVx的控制器名统称为组件名，如：在VIPER模块里BDJLoginRouting、BDJLoginPresenter等层的组件名为Login，同一个模块的各层组件名一定要相同，在MVx模式里BDJLoginViewController的组件名为Login。

* ##### 前缀与后辍

  每一个类都应该有前辍名和后辍，如：在VIPER模块里BDJLoginRouting、BDJLoginPresenter的前缀为BDJ，后辍名为分别为Routing、Presenter，在MVx里BDJLoginViewController的前缀是BDJ，后辍名是ViewController。

  在使用乐高作为项目的驱动引擎时，类前辍不可以省略，这也使用OC编程的好的风格。后辍名诸如Activity、Routing、Presenter是VIPER模块对各层的称名，以方便内部解析引擎对当前模块的自动构建，在MVx里控制器必需以ViewController作为后辍名，这样框架才能把它归为组件类型。
  
* ##### 模块化与组件化
	
	模块化是把项目功能划分出一个个模块，想要解决模块之间的耦合就要通过组件化方式，以组件的方式把一个一个模块隔离开来。
	
	一个模块可以是一个组件，一个控制器也是一个组件，对于组件来说一个可插件的东西就是组件，而这个插件的丢失不会影响整个系统的运行。乐高提供VIPER模块化用来细分功能代码，同时提供了组件化用来串起VIPER模块和旧项目的控制器，以统一跳转的API来处理不同的组件。
	

* ##### VIPER模块的必要组成部分

  一个基于VIPER的模块必需拥有：视图层（Activity）、事件层（Presenter）、路由层（Routing），由于在乐高内部对视图层是弱引用，而它们关系引用是Activity-&gt;Presenter-&gt;Routing，所以一个模块的的存在是由视图层决定。如果没有事件层，模块事件就无法传递，那这个模块也不会加入到乐高框架的运行容器。如果路由层没有就不能称为一个模块了，因为在乐高的世界里，一个路由就代表一个模块，它拥有当前模块的三大功能：多功能模块组装器、UI总线、事件总线。

* ##### VIPER模块各层负责的功能

  * 视图层（Activity）：子视图绘制、布局、动画，绑定事件层

  * 事件层（Presenter）：视图渲染数据填充、UI事件、模块事件消息处理，数据请求

  * 路由层（Routing）：模块组装与跳转

  * 业务层（Interactor）：模型数据获取、业务处理

  * 数据管理层（DataManager）：提供数据来源（远程、本地&lt;缓存文件、数据库&gt;）、数据类型匹配与整理

* ##### VIPER模块简图
	![VIPER flow](https://www.objc.io/images/issue-13/2014-06-07-viper-wireframe-76305b6d.png)
	
	个别名称不同的层与乐高对应如下：
	* View -> Activity
	* Wireframe -> Routing (原VIPER设计模式中，Wireframe与Routing通用）
	* Data Store -> DataManager

* #### VIPER模块层接口调用关系
	* Activity <-> Presenter
	
	![Alt text](http://g.gravizo.com/g?
		@startuml;
		participant "Activity" as A;
		participant "Presenter" as P;
		A -> P: <XFEventHandlerPort>
		- didDoneClickAction:;
		@enduml
		)
		
		
	* Presenter -> Activity
		
	![Alt text](http://g.gravizo.com/g?
		@startuml;
		participant "Presenter" as P;
		participant "Activity" as A;
		P -> A: <XFUserInterfacePort>
		- needUpdateUIState:;
		@enduml
		)
		
	* Presenter -> Interactor
	
	![Alt text](http://g.gravizo.com/g?
		@startuml;
		participant "Presenter" as P;
		participant "Interactor" as I;
		P -> I: <XFInteractorPort>
		- fetchTopicData:;
		@enduml
		)

	* Presnter -> Routing
	
	![Alt text](http://g.gravizo.com/g?
		@startuml;
		participant "Presenter" as P;
		participant "Routing" as R;
		P -> R: <XFWrieframePort>
		- transition2Login:;
		@enduml
		)
		
	* Interactor->DataManager
		
	![Alt text](http://g.gravizo.com/g?
		@startuml;
		participant "Interactor" as I;
		participant "DataManager" as D;
		I -> D: <XFDataManagerPort>
		- grabTopics:;
		@enduml
		)
		
* ##### 关于宏
	宏即预处理指令，用于解决重复的代码，屏蔽背后复杂的API，如：`XF_AutoAssemblyModuleWithNav_Fast` 一个用于快速组装模块的宏。它极大的简化了API的复杂度和代码行数，同时又能屏蔽背后API被升级时修改或废弃的带来风险，所以强烈推荐优先使用模块各层提供的宏编写代码。
	> 注意：
	* 有关于数据绑定的宏需要联合`ReactiveCocoa`响应函数式编程库的支持，如要使用`XF_C_`、`XF_$_`、`XF_CEXE_`、`XF_CEXE_Enable_`宏时需要加入`ReactiveCocoa`库。
	* 另外还一个要注意的是，一些宏包含的多行代码且不是单独一个方法时会对断点调试会有影响！！如：`XF_$_`、`XF_CEXE_`、`XF_CEXE_Enable_`、`XF_EventIs_`、`XF_ShowURLComponent2Window_`等，对于需要调试的代码段，可以把它们封装进一个单独方法里。


#### 创建当前模块各层

* ##### 基于乐高框架模板（推荐）

  [点我开始使用模板](https://github.com/yizzuide/XFLegoVIPER#using-template)

* ##### 手动创建

  分别创建模块层继承自：XFActivity、XFPresenter、XFRouting、XFInteractor、XFDataManager。
  
  创建它们的层接口继承自：XFUserInterfacePort、 XFEventHandlerPort 、 XFWireFramePort 、 XFInteractorPort 、 XFDataManagerPort 。

#### 快速组装一个模块

乐高框架目标是快速编写基于VIPER设计模式的代码，所以在名层头文件都提供了常用功能的宏，下面的宏是至今最快的模块组装方式：

```objc

#import "BDJIndexTabRouting.h"

@implementation BDJIndexTabRouting

// 组装模块
XF_AutoAssemblyModule_Fast

@end
```

#### 选择一种喜欢的组件跳转方式

* ##### 使用组件名方式

	只要符合组件的命名规范，就可以使用下面的方式：
	
```objc
	#import "BDJPostRouting.h"
	
	@implementation BDJPostRouting

	// 组装模块
	XF_AutoAssemblyModule_Fast

	// 跳转组件
	- (void)transition2PostComment
	{
		// 由于是组件名，所以首字母要大写！！
	    XF_PUSH_Component_Fast(@"PostComment")
	}
	@end
```

* ##### 使用URL组件方式（推荐，教程也是基于这种方式）
	
	使用URL组件方式，要先注册：
	
```objc
	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    	// 这些注册的URL协议名可自定义(如：abc://),它的后面路径名为组件名（组件名是模块名和控制器名的统称）
	    	[XFURLRoute initURLGroup:@[
	                                 @"bdj://indexTab", // Tab主UI框架页
	                                 @"bdj://essence/post", // 帖子
	                                 @"bdj://essence/post/postComment", // 帖子评论
	                                 ]];
	    
	    // other code...
	    	return YES;
		}
```

然后在路由中跳转：
	
```objc
	#import "BDJPostRouting.h"
	
	@implementation BDJPostRouting

	// 组装模块
	XF_AutoAssemblyModule_Fast

	// 跳转模块
	- (void)transition2PostComment
	{
	// URL子路径的首字母大小写都可以
	    XF_PUSH_URLComponent_Fast(@"bdj://essence/post/postComment");
	}
	@end
```



#### 在主窗口上显示
乐高支持在主窗口显示一个根组件，根组件也要提前注册才能使用：

```objc
#import "XFLegoVIPER.h" // 1.导入头文件

// 在应用加载完成方法调用：
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Other Code
	// 2.注册组件...
	
	// 3.根据URL显示组件在主窗口
    XF_ShowURLComponent2Window_Fast(@"bdj://indexTab")
	return YES;
}
```

# 2. Module Assembly (模块组装)
In this section, We will talking about modular assembly. Using the modular assembly, the service is convenient. It's even better when those pieces aren't aware of each other, so that someone can assemble an application from the various independent parts.

## 自由组装方式
自由组装方式是一种高定制性的方式，可以在当前模块任意加不同类型的层。

### 组装简单模块

```objc
@implementation BDJLoginRouting

// 组装普通模块
XF_InjectModuleWith_Act([BDJLoginActivity class],
						[BJDLoginPresenter class],
						[BDJLoginInteractor class],
						[BDJLoginDataManager class])
@end
```
### 组装带自定义导航栏的模块

```objc
@implementation BDJLoginRouting

// 组装带导航控制器模块
XF_InjectModuleWith_Nav([BDJNavgationController class],
						[BDJLoginActivity class],
						[BJDLoginPresenter class],
						[BDJLoginInteractor class],
						[BDJLoginDataManager class])
@end
```

### 组装XIB或StoryBoard界面模块

```objc
@implementation BDJLoginRouting

// 使用字符串符号加载视图
// xib方式: x-xibName[-activityClass]
// Storyboard方式: s-storyboardName-controllerIdentifier
XF_InjectModuleWith_IB(@"x-BDJLoginActivity",
						[BDJLoginActivity class],
						[BJDLoginPresenter class],
						[BDJLoginInteractor class],
						[BDJLoginDataManager class])
@end
```
## 全自动组装方式
这是一个智能检测当前模块成份的方式，使用更简单、编码更快、更直观的方式，内部使用了框架模块解析引擎。

### 快速组装模块

使用这种方式时，要注意当前模块的所有层有一个统一的`组件名`。

```objc
@implementation BDJIndexTabRouting

XF_AutoAssemblyModule_Fast

@end
```

### 组装带自定义导航栏的模块

使用这种方式时，要注意项目里有自定义导航栏，并且类名以项目前辍+`NavigationController`，如：`BDJNavigationController`。

```objc
@implementation BDJIndexTabRouting

XF_AutoAssemblyModuleWithNav_Fast

@end
```
### 组装XIB或StoryBoard界面模块
	
这里的格式和自由组装方式一致。

```objc
@implementation BDJIndexTabRouting

XF_AutoAssemblyModuleFromIB(@"x-BDJIndexTabActivity")

@end
```

### 组装共享模块
为什么会有共享模块？什么是共享模块？由于乐高里的模块创建后添加到内部运行容器都是单例，为了能够创建多例模块功能，框架提供了共享模块解决方案。我们知道，在乐高世界里，一个路由Routing即一个模块，想要复用一个模块，可以通过创建一个不同名的路由Routing，然后组装进想要分享的模块子层，不过框架已经提供了方便使用的宏。
	
例如多种类型帖子子页面就需要共享模块，它们的业务逻辑都一样（除了需要一个类型的判断），正好就可以根据当前模块名来判断，获取当前模块名详见 [Module Manager](https://github.com/yizzuide/XFLegoVIPER/wiki/Module-Manager#%E8%8E%B7%E5%BE%97%E5%BD%93%E5%89%8D%E6%A8%A1%E5%9D%97%E5%90%8D) 章节。
	

* 帖子模块

```objc

// 通用帖子模块
@implementation BDJPostRouting

XF_AutoAssemblyModule_Fast
@end
```
* 视频帖子模块

```objc
@implementation BDJVideoPostRouting

// 使用其它模块组件成份，使当前路由只是这个模块的壳
XF_AutoAssemblyModuleFromShareModuleName(@"Post")
@end
```

* 音频帖子模块

```objc
@implementation BDJVoicePostRouting

// 使用其它模块组件成份，使当前路由只是这个模块的壳
XF_AutoAssemblyModuleFromShareModuleName(@"Post")
@end
```

# 3. Module Manager (模块管理)
What is Module? Module can include some layer in VIPER design Pattern which work interactively. Each of the modules is independent mutually, which is convenience to programming and debugging, focusing finish concrete function and operation. 

Then it has an a detailed needs analysis of each module, completing the division of system functionality which described from different aspects like data structure and algorithm process.

The class `XFRoutingLinkManager` manager the relationships between the modules.


## 模块关系链跟踪
随着模块的添加，跟踪模块的关系链变得困难，可以使用框架提供的模块的跟踪功能：

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 开启模块追踪log（注意：一定要在根模块加载之前开启）
    [XFRoutingLinkManager enableLog];
    // 使用自定义类封装注册APP的所有URL
    [BDJAppURLRegister urlRegister];
    // 显示URL根组件到主窗口
    XF_ShowURLComponent2Window_Fast(@"bdj://indexTab")
    return YES;
}
```

## 获得当前模块名
获得当前模块名在**共享模块**中可以用到，**共享模块**在 [Module Assembly](https://github.com/yizzuide/XFLegoVIPER/wiki/Module-Assembly#%E7%BB%84%E8%A3%85%E5%85%B1%E4%BA%AB%E6%A8%A1%E5%9D%97) 章节里会详细讲解。获得当前模块名只能在视图层<Activity>、事件层<Presenter>、路由层<Routing>才可以，但在事件层才是最常用的，例如：

```objc
#import "BDJPostPresenter.h"
#import "BDJPostInteractorPort.h"
	
// 定义访问真实相应层接口的宏
#define Interactor XFConvertInteractorToType(id<BDJPostInteractorPort>)
#define Routing XFConvertRoutingToType(id<BDJPostWireFramePort>)
	
@implementation BDJPostPresenter
	
#pragma mark - DoAction
- (void)didPostCellSelectedActionAtIndex:(NSInteger)index
{
	// 查找帖子ID（使用宏XF_ModuleName获得当前模块名，用以区别帖子类型）
    NSString *PostID = [Interactor fetchPostIDForIndex:index type:BDJ_Post_Str2Type(XF_ModuleName)];
    // 切换到评论
    [Routing transition2PostComment];
    // 发送选择帖子ID事件
    XF_SendEventForModule_(@"PostComment", BDJPostSelectedEvent, PostID)
}
@end
```

## 模块子视图获取事件层
模块视图层Activity往往会包含一些子View，子View又会包含自己的子View，当这些多重View发生控件事件时，就可以委托给事件层Presenter，为了不让View不要写业务相关代码，框架提供一个分类`UIView+XFLego`，无论有多少层子View都能获得事件层，使用如下：

```objc
#import "BDJPostPictureView.h"
#import "UIView+XFLego.h" // 导入分类头文件
#import "BDJPostEventHandlerPort.h" // 事件层接口

// 定义访问真实事件层接口的宏（注意：宏XFConvertPresenterToType是框架定义的，它会把self.eventHandler转成相应接口类型，这里是BDJPostEventHandlerPort）
#define EventHandler XFConvertPresenterToType(id<BDJPostEventHandlerPort>)

// 这个View相对于Activity的层级关系：BDJPostActivity->BDJPostCell->BDJPostPictureView,因此是Activity的子子View
@implementation BDJPostPictureView

- (void)didPictureViewClick
{
	// 使用self.eventHandler就能获取事件层，so easy!
	NSLog(@"%@",self.eventHandler);
  	[EventHandler didPictureViewClickActionWithExpressPiece:self.expressPiece];
}
@end
```

## 子模块管理
### 为当前模块添加子模块
我们知道，在苹果MVC开发模式里，控制器绑定着视图生命周期，控制器可以添加子控制器，再父视图添加子视图。在乐高里也有相似的概念，当有两个页面都是VIPER模块，又互为父子关系，就要使用添加子模块，使框架内部能更好地管理模块，如：

```objc
@implementation BDJEssenceActivity

// 给精华页面添加多种类型帖子页面
- (void)addChildActivity
{
	// 多个子模块
    NSArray *modules = @[@"AllPost",@"VideoPost",@"VoicePost",@"PicturePost",@"WordsPost"];
    NSUInteger count = modules.count;
    for (int i = 0; i < count; i++) {
    	// 使用宏`XF_SubUInterface_`获得一个模块的视图
        XFActivity *activity = XF_SubUInterface_(modules[i]);
        
        // 调用系统提供的API添加子控制器
        [self addChildViewController:activity];
    }
}
@end
```

### 控制器添加子模块
乐高框架有自己的模块编写方式，但也能与MVx模式旧项目代码融合在一起，同时支持在MVx控制器添加乐高子模块，如：

```objc
// 导入头文件
#import "XFLegoVIPER.h"

@implementation BDJEssenceViewController

- (void)addChildViewController
{
    NSArray *modules = @[@"AllPost",@"VideoPost",@"VoicePost",@"PicturePost",@"WordsPost"];
    NSUInteger count = modules.count;
    for (int i = 0; i < count; i++) {
    	// 使用宏`XF_SubUInterfaceForMVx_AddChild`获得一个模块的视图
        XFActivity *activity = XF_SubUInterfaceForMVx_AddChild(modules[i]);
        [self addChildViewController:activity];
    }
}
@end
```

# 4. Component (组件)
&emsp;&emsp;使用组件开发已经是软件开发的热门方式，就前端和移动端更以URL路由组件方式更为常见，为了追赶这股技术潮流，乐高在2.0版本开始就开始加入这个概念。但是在乐高中的URL路由组件方式和别的框架有两点不同之处：

* URL路由方式和网址相似（支持网址参数）
* 以组件名的注册方式
* 组件打开方来完成下一个组件切换功能

&emsp;&emsp;这样设计是为了完美整合进乐高的模块运行体系，因为乐高1.x版本的模块高度耦合在一在，使用这种简化版的URL路由方式，使模块各自独立，提高了可维护性，注意的是这种设计只为了处理组件（模块组件和控制器组件）切换，不针对URL路由作其它业务处理。简单来说就一句话：功能模块化，界面组件化。

&emsp;&emsp;引入组件开发方式，使VIPER模块与普通控制器统一对待，以组件通用API实现对VIPER模块与普通控制器的双向桥接，分为以下功能：

* 统一的URL路由跳转方法
* 强大的轻量级组件事件消息通信
* 内存安全的通知中心注册与接收方式

## 导出组件
VIPER模块和控制器要成为组件，必需使用导出宏来指定，使框架来识别它们具有这些功能：事件处理机制、URL路由跳转、组件参数传递、统一的组件生命周期等。那么怎样把它们导出为一个组件？
### 导出模块组件
VIPER模块各层通过继承框架提供的父类层后，会自动转为一个组件。具体点来说是VIPER模块的事件层 `XFPresenter` 层会充当一个组件类型，因为它实现了 `XFModuleComponentRunnable` 接口，使当前模块成为可运行组件。
### 导出控制器组件
框架提供可使普通控制器导出为组件的能力，具有VIPER模块的一些功能。

* 使用继承方式

```objc
#import "XFLegoVIPER.h"

// 继承可运行组件控制器XFComponentViewController
@interface BDJPublishViewController : XFComponentViewController

@end
```

* 使用分类方式

```objc
#import "XFLegoVIPER.h"

// 如要当前控制器不是继承的UIViewController类，可实现XFControllerComponentRunnable接口使控制器成为可运行组件
@interface BDJPostPictureBrowseViewController : UIViewController <XFControllerComponentRunnable>

/* ---------------- 可选实现 ---------------- */
// 上一个URL组件传递过来的URL参数
@property (nonatomic, copy) NSDictionary *URLParams;

// 上一个URL组件传递过来的自定义数据对象
@property (nonatomic, copy) id componentData;

// 预设要传递给其它组件的意图数据
@property (nonatomic, copy) id intentData;
@end

@implementation BDJPostPictureBrowseViewController

// 把控制器导出为组件
XF_EXPORT_COMPONENT

@end
```

## 组件生命周期
任何一个可运行组件，都有获取焦点方法和失去焦点方法可以覆盖实现，模块组件可以在事件层`Presenter`，控制器组件在相应控制器中：

```objc
/**
 *  组件将获得焦点
 */
- (void)componentWillBecomeFocus;

/**
 *  组件将失去焦点
 */
- (void)componentWillResignFocus;
```


## 组件注册
### 底层方法
这种方式是：`URL + 组件名`, 即一个组件名对应一个访问的URL。

```objc
// 注意组件名首字母要大写
[XFURLRoute register:@"bdj://indexTab" forComponent:@"IndexTab"];
[XFURLRoute register:@"bdj://indexTab/publish" forComponent:@"Publish"];
```

### 简单封装的方法
由于URL路径的最后一个路径就是组件名，所有可以使用快速初始化方式：

```objc
[XFURLRoute register:@"bdj://indexTab"];
[XFURLRoute register:@"bdj://indexTab/publish"];
```

更快的初始化URL列表：

```objc

// 使用自定义类封装起来
@implementation BDJAppURLRegister

+ (void)urlRegister
{
    [XFURLRoute initURLGroup:@[
                                 @"bdj://indexTab", // Tab主UI框架页
                                 @"bdj://indexTab/publish", // 发布作品
                                 @"bdj://friendTrends/friendsRecomment", // 推荐朋友
                                 @"bdj://userCenter/signIn", // 登录
                                 @"bdj://essence/recommendTag", // 推荐标签
                                 @"bdj://essence/post/postPictureBrowse", // 浏览大图
                                 @"bdj://essence/post/postComment", // 帖子评论
                                 ]];
}
@end
```

## 组件跳转
### 模块组件跳转
这种情况适用于乐高模块间的跳转，也适用于模块到控制器的跳转，下面Push方式：

```objc
@implementation BDJPostRouting

// 组装模块
XF_AutoAssemblyModule_Fast

// 跳转组件
- (void)transition2PostComment
{
    XF_PUSH_URLComponent_Fast(@"bdj://essence/post/postComment")
}
@end
```

使用Present方式：

```objc
@implementation BDJPostRouting

// 组装模块
XF_AutoAssemblyModule_Fast

// 跳转组件
- (void)transition2PostPictureBrowse
{
    XF_Present_URLComponent_Fast(@"bdj://essence/post/postPictureBrowse")
}
@end
```

自定义跳转方式：

```objc
@implementation BDJIndexTabRouting

// 组装模块
XF_AutoAssemblyModule_Fast

// 跳转组件
- (void)transition2Publish
{
    // 自定义跳转 （Publish组件为控制器）
   [self.uiBus openURL:@"bdj://indexTab/publish" withTransitionBlock:^(__kindof UIViewController *thisInterface, __kindof UIViewController *nextInterface, TransitionCompletionBlock completionBlock) {
       // 使用不带动画的方式
       [thisInterface presentViewController:nextInterface animated:NO completion:completionBlock];
   } customCode:nil];
}
@end
```

### 控制器组件跳转
可用于跳转到模块组件或控制器组件，使用的API宏和模块使用的相同：

```objc
#import "XFComponentViewController.h" // 导入头文件

// 继承可运行组件控制器XFComponentViewController
@interface BDJPublishViewController : XFComponentViewController

@end

@implementation BDJPublishViewController
- (void)doFunAction:(UIButton *)target
{
    // 先显示退出动画
    [self cancelWithCompletionBlock:^{
        switch (target.tag) {
            case BDJPublishTypeWords:
                self.intentData = @"控制器到模块的数据";
                XF_Present_URLComponent_Fast(@"bdj://indexTab/publish/publishContent")
                break;
            default:
                break;
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
@end
```

## URL组件路径跟踪
乐高可以通过组件跟踪引擎，实时检测每一个打开或闭的组件，标识当前正显示的组件，可通过以下方式打开：

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 开启组件追踪log（可选）
    [XFComponentManager enableLog];
    // 注册APP的所有URL组件
    [BDJAppURLRegister urlRegister];
    // 根据URL显示组件
    XF_ShowURLComponent2Window_Fast(@"bdj://indexTab")
    return YES;
}
```

## URL模块路径检测
&emsp;&emsp;当项目完全以乐高VIPER方式编写时，可以启用URL路径检测功能，内部会对乐高模块关系路径检测，用于检测路径名的正确性及路径层级的正确性：

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 可选开启URL路径验证
    [XFURLRoute enableVerifyURLRoute];
    // 注册APP的所有URL组件
    [BDJAppURLRegister urlRegister];
    // 根据URL显示组件
    XF_ShowURLComponent2Window_Fast(@"bdj://indexTab")
    return YES;
}
```

# 5. Component Communication (组件通信)
&emsp;&emsp;由于每一个组件（包括模块组件和控制器组件）之间是独立存在，没有任何的耦合关系，对于组件间的数据传递问题，乐高提供了组件通信机制。下面是使用组件通信的条件：

* 成为一个组件（[如何成为一个组件？](https://github.com/yizzuide/XFLegoVIPER/wiki/4.-Component-(%E7%BB%84%E4%BB%B6%E5%BC%8F%E5%BC%80%E5%8F%91)#%E5%AF%BC%E5%87%BA%E7%BB%84%E4%BB%B6)）
* 实现组件接收数据属性 （下面详细讲解）
* 实现接收数据的相关的方法（下面详细讲解）

&emsp;&emsp;组件通信分为直接参数传递和间接事件消息，直接参数传递用于当前组件对前一个组件或下一个组件的通信，作用于有关系的组件；间接事件消息用于不直接关联的组件间，可以远程地发起事件消息来通信。

## 组件数据传递
组件数据传递方式，只适用于相邻的两个组件通信，也就是通过POP或Present出的来的组件。[想要在不关联的两个或多个组件之间通信？](https://github.com/yizzuide/XFLegoVIPER/wiki/5.-Component-Communication-(%E7%BB%84%E4%BB%B6%E9%80%9A%E4%BF%A1)#%E8%B7%A8%E7%BB%84%E4%BB%B6%E9%80%9A%E4%BF%A1)
### 传递数据
* 传递URL参数

```objc
/* ---------------- VIPER模块组件 ---------------- */
// 在路由层中
@implementation BDJIndexTabRouting
// 跳转组件
- (void)transition2Publish
{
    XF_Present_URLComponent_Fast(@"bdj://indexTab/publish/publishContent?usrId=123&usrname=aa")
}
@end

/* ---------------- 控制器组件 ---------------- */
@implementation BDJPublishViewController

- (void)doFunAction:(UIButton *)target
{
    XF_Present_URLComponent_Fast(@"bdj://indexTab/publish/publishContent?usrId=123&usrname=aa")
}
@end
```
* 传递自定义对象数据

```objc
/* ---------------- VIPER模块组件 ---------------- */
// 在模块事件层中
@implementation BDJPostPresenter
- (void)didPostCellSelectedActionAtIndex:(NSInteger)index
{
    // 设置意图数据：拷贝一份行数据片段作为下一个组件接收的意图数据
    self.intentData = self.expressPack.expressPieces[index];
    // 去除最热评论显示
    BDJPostRenderItem *renderItem = [self.intentData renderItem];
    if (renderItem.hotCmtContent) {
        renderItem.hotCmtContent = nil;
        // 重新计算高度
        [self.expressPack reMeasureFrameForExpressPiece:self.intentData];
    }
    // 切换到评论组件
    [Routing transition2PostComment];
}
@end

/* ---------------- 控制器组件 ---------------- */
@implementation BDJPublishViewController

- (void)doFunAction:(UIButton *)target
{
	// 设置传递的意图数据
	self.intentData = @"控制器到模块的数据";
	XF_Present_URLComponent_Fast(@"bdj://indexTab/publish/publishContent")
}
@end
```

* 传递回传数据

```objc
/* ---------------- VIPER模块组件 ---------------- */
@implementation BDJPublishContentPresenter

- (void)componentWillResignFocus
{
    self.intentData = @"模块给控制器返回的数据";
}
@end


/* ---------------- 控制器组件 ---------------- */
@implementation BDJPublishViewController

- (IBAction)cancel {
    [self cancelWithCompletionBlock:^{
        // 回传组件意图数据
        self.intentData = @"控制器的返回数据";
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
@end
```

### 接收组件数据
#### 组件URL参数和自定义对象
从上一个组件获得传递参数对象或自定义对象，上一个组件和当前组件可以是控制器组件或模块组件，基于一个父级接口`XFComponentRoutable`。

* 控制器组件要先实现接口的属性，如：

```objc
#import "XFControllerComponentRunnable.h"

// 如要当前控制器不是继承的UIViewController类，可实现XFControllerComponentRunnable接口使控制器成为可运行组件
@interface BDJPostPictureBrowseViewController : UIViewController <XFControllerComponentRunnable>

/* ---------------- 可选实现 ---------------- */
/**
 *  上一个URL组件传递过来的URL参数
 */
@property (nonatomic, copy) NSDictionary *URLParams;

/**
 *  上一个URL组件传递过来的自定义数据对象
 */
@property (nonatomic, copy) id componentData;

/**
 *  预设要传递给其它组件的意图数据
 */
@property (nonatomic, copy) id intentData;

@end

@implementation BDJPostPictureBrowseViewController

// 把控制器导出为组件
XF_EXPORT_COMPONENT

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获得传递过来的URL参数
    NSDictionary *params = self.URLParams;
    // 获得传递过来的自定义对象数据
    BDJPicturePostRenderItem *renderItem = self.componentData;
}
@end
```
* VIPER模块组件在Presenter事件层，由于框架父类`XFPresenter`实现了接收组件数据属性，所以直接调用对应接受属性即可：

```objc
#import "BDJPostCommentPresenter.h"
#import "BDJPostCommentUserInterfacePort.h"

#define Interface XFConvertUserInterfaceToType(id<BDJPostCommentUserInterfacePort>)

@implementation BDJPostCommentPresenter
	
- (void)initRenderView
{
    // 填充传递过来的组件对象
    [Interface fillPostExpressPiece:self.componentData];
}
@end

```


#### 回传的组件数据
当下一个组件被POP或Dismiss时，通过下面方法来接收传递过来的数据：

```objc
// 组件回传数据
- (void)onNewIntent:(id)intentData
{
    NSLog(@"%@",intentData);
}
```

## 跨组件通信
框架内部实现不同组件间通信机制，解决无法跨组件通信问题，这种实现基于框架运行容器上。跨组件通信分为两类：

* 组件事件通信
* 轻量级通知

### 发送组件数据
#### 组件事件通信
一种基于指定组件的通信方式，具有速度快、内存安全、易于管理特点。

```objc
// 向单个组件发送事件,参数分别为：组件名,事件名,消息数据(id)
XF_SendEventForComponent_(@"PostComment", @"BDJPostSelectedEvent", @"123")

// 向多个组件发送事件,参数分别为：组件名数组,事件名,消息数据(id)
NSArray *compNames = @[@"PostComment"];
XF_SendEventForComponents_(compNames, @"BDJPostSelectedEvent", @"123")
```

#### 轻量级通知
一种基于系统通知API的实现，无需手动移除通知对象，具有内存安全、轻量特点。

```objc
	// 发送通知,参数分别为：通知名,消息数据
 XF_SendMVxNoti_(@"BDJTabBarSelectAgainNotification", nil)
```

### 接收组件数据
框架把对通知的接收转化成组件数据的接收方法，统一了接收方法API：

```objc
- (void)viewDidLoad
{
	 [super viewDidLoad];
	 
    // 注册键盘通知（注意：无需查找手动移除通知对象方法，框架会自动管理）
    XF_RegisterMVxNotis_(@[UIKeyboardWillChangeFrameNotification])
}

// 接收跨组件数据方法
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
	// 如果键盘通知
    XF_EventIs_(UIKeyboardWillChangeFrameNotification, {
        NSDictionary *dict = intentData;
        CGFloat y = ScreenSize.height - [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        [Interface needUpdateInputBarY:y durationTime:[dict[UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    })
    
    // 如果组件数据
    XF_EventIs_(@"BDJPostSelectedEvent", {
        // 叫业务层缓存这个帖子ID
        [Interactor cachePostID:intentData];
    })
}
```







