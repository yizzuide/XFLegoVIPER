<p align="center">
    <img src="./ScreenShot/logo.jpg" alt="logo" />
</p>
<p align="center">
  <a href="http://cocoadocs.org/docsets/XFLegoVIPER"><img src="https://img.shields.io/badge/cocoapods-v1.0.0-brightgreen.svg" alt="cocoapods" /></a>
  <img src="https://img.shields.io/badge/language-ObjC-orange.svg" alt="language" />
  <img src="https://img.shields.io/npm/l/express.svg" alt="LICENSE" />
  <img src="https://img.shields.io/badge/platform-ios6%2B-green.svg" alt="version" />
</p>

一个以VIPER架构理念的项目驱动引擎，提倡使用模块化编程，适用于大型项目和业务逻辑复杂的项目。
<p align="center">
    <img src="./ScreenShot/usage.gif" alt="usage" />
</p>

##XFLegoVIPER特点
1、快速建立模块与模块之间的关联，提供简化路由API在界面与界面间跳转。

2、视图自动绑定事件处理者，无需再手动绑定。

3、能很好地结合MVVM设计模式，使用ReactiveCocoa进行层与层之间通信。

4、层与层通过接口通信，方便多人在同一模块开发，避免重复业务逻辑代码的发生。

5、方便编写单元测试代码，让应用程序更健壮。

6、可以与旧项目MVC、MVP、MVVM架构并存，并快速从这些架构过渡到VIPER架构代码。

##安装
1、使用Cocoapods
> pod 'XFLegoVIPER','1.0.0'

2、使用手动添加

把XFLegoVIPER整个库拖入到工程即可


##什么是VIPER？
VIPER 是一个创建 iOS 应用简明构架的程序。VIPER 可以是视图 (View)，交互器 (Interactor)，展示器 (Presenter)，实体 (Entity) 以及路由 (Routing) 的首字母缩写。简明架构将一个应用程序的逻辑结构划分为不同的责任层。这使得它更容易隔离依赖项 (如数据库)，也更容易测试各层间的边界处的交互。

作用：VIPER不属于MV*架构系列，但它是所有这些架构中单一责任分得最细的一个，有利于大型项目的构建和多人对同一个模块开发，好处有易维护、易迁移、代码多模块共用。VIPER架构结构就像搭积木一个，且很容易从传统MVC架构迁移过来，MVC的代码和VIPER架构可以很容易相互关联与调用，所以可以在一个项目里即有MVC架构的模块，又有VIPER架构的模块。

<p align="center">
    <img src="https://www.objc.io/images/issue-13/2014-06-07-viper-intro-0a53d9f8.jpg" alt="VIPER 理念图" />
</p>

##VIPER组成结构图
![XFLegoVIPER construct](https://www.objc.io/images/issue-13/2014-06-07-viper-wireframe-76305b6d.png)

##XFLegoVIPER使用文档
###模块入口类`XFRouting`
Routing<或称为WireFrame>是一个模块开始的入口，也是管理模块与模块之间的跳转（相当于界面之跳转），它初化始当前模块的的所有层级关系链，也保存着上一个和下一个模块的引用关系链，是整个架构的关键层。

1、初始化一个模块，建立一个`XFSearchRouting`并继承自`XFRouting`,在.m文件里覆盖`+ (instancetype)routing`方法（使用`Activity`而不使用`UIViewController`是为了和旧项目MVC等架构区别开来）：
```objc
+ (instancetype)routing
{
    /**
     *  如果没有UINavigationController这个嵌套，可以传nil，或使用不带navigatorClass参数的方法
     *  除了ActivityClass必传外，其它都可以传空，这种情况适用于对MVC等其它架构的过渡
     */
    return [[super routing] buildModulesAssemblyWithActivityClass:[XFSearchActivity class]
                                                   navigatorClass:[UINavigationController class]
                                                   presenterClass:[XFSearchPresenter class]
                                                  interactorClass:[XFSearchInteractor class]
                                                 dataManagerClass:[XFPictureDataManager class]];
}
```
2、在`UIWindow`上显示：
```objc
    XFSearchRouting *searchRouting = [XFSearchRouting routing];
    // 获得导航栏
    UINavigationController *navigation = searchRouting.realNavigator;
    // TODO: 配置导航栏
    // ...
    // 调用显示方法，之后不用再写[self.window makeKeyAndVisible];
    [searchRouting showRootActivityOnWindow:self.window isNavigationControllor:YES];
```
3、模块之间的跳转,这个方法是`XFSearchPresenter`发起对`XFSearchRouting`的请求：
```objc
- (void)transitionToShowResultsMoudle {
    XFPictureResultsRouting *routing = [XFPictureResultsRouting routing];
    // 使用intentData传递意图数据
    [self pushRouting:routing intent:self.uiOperator.intentData];
}
```

###显示视图层`XFActivity`
在MVP、MVVM、VIPER架构中`UIViewController`和`UIView`一样是View，所以不能再当控制器来使用，而只能做UI的渲染、布局、动画的工作，这也是用`Activity`来替换`ViewController`命名的原因之一。那么谁来充当控制器呢？那就是`XFPersenter`,这个在后面会讲到。 

1、把一个`UIViewController`转为VIPER里的View的两种方式：
第一种，导入分类`UIViewController+XFLego.h`头文件（如果当前继承的父类不是`UIViewController`的话，推荐使用这种）：
```objc
#import <UIKit/UIKit.h>
#import "UIViewController+XFLego.h"

@interface XFSearchActivity : UIViewController

@end
```
第二种，继承自类`XFActivity`（如果当前就是继承普通的`UIViewController`的话，推荐使用这种）：
```objc
#import <UIKit/UIKit.h>
#import "XFActivity"

@interface XFSearchActivity : XFActivity

@end
```

2、请求事件处理

上面的操作会自动绑定在`XFSearchRouting`设置的事件处理者`XFSearchPersenter`,请求事件处理者可以使用：
```objc
    // 转换为事件处理实现的接口
    id<XFSearchEventHandlerPort> presenter = XFConvertPresenterToType(id<XFSearchEventHandlerPort>);
    [persenter loginButtonClickWithName:name pwd:pwd];
```
如果采用MVVM的双向绑定思想，则可以结合ReactiveCocoa的信号传递：
```objc
    id<XFSearchEventHandlerPort> presenter = XFConvertPresenterToType(id<XFSearchEventHandlerPort>);
    RAC(self,title) = RACObserve(presenter, navigationTitle);
    RAC(presenter, mainCategory) = self.mainCategoryTextField.rac_textSignal;
    RAC(presenter, secondCategory) = self.secondCategoryTextFiled.rac_textSignal;
    // 绑定命令
    self.searchButton.rac_command = presenter.executeSearch;
    
    // 其它绑定...
```

###事件处理层`XFPersenter`
事件处理层负责界面上的按钮点击事件、页面数据推送填充，而不能对View的渲染、布局直接操作，只针对View行为做出响应。Persenter持有对内容提供者Provider转换过来的界面显示数据`***ExpressData`类的强引用，这个类与模型不同，它拥有界面所需显示的所有对象数据。另外View和Persenter是不能直接引用到模型数据的。

1、界面显示移除回调方法
```objc
// 视图的显示完成回调方法
- (void)viewDidLoad{} 
// 视图被移除的回调方法(这个回调在使用分类`UIViewController+XFLego.h`方式无效)
- (void)viewDidUnLoad{} 
```

2、界面切换回调方法
```objc
// 当前界面将获得焦点时（将要显示）
- (void)viewWillBecomeFocusWithIntentData:(id)intentData{}
// 当前界面将失去焦点时（将要被隐藏<push或present行为>或消失<pop行为>）
- (void)viewWillResignFocus{}
```

3、常用属性与方法
```objc
/**
 * 视图填充数据
 *
 */
@property (nonatomic, strong) id expressData;

/**
 *  错误消息
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 *  pop当前视图
 */
- (void)requirePopModule;
```

4、请求业务数据和界面切换
```objc
// 按钮响应信号方法
- (RACSignal *)executeSearchSignal {
    // 预加载数据
	return [[[XFConvertInteractorToType(id<XFSearchInteractorPort>) fetchPictureDataWithMainCategory:self.mainCategory secondCategory:self.secondCategory] doNext:^(id x) {
        // 设置意图数据
        self.intentData = x;
        // 请求Routing切换界面
        [XFConvertRoutingToType(id<XFSearchWireFramePort>) transitionToShowResultsMoudle];
    }] doError:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
}
```
###业务层`XFInteractor`
业务层负责当前模块的核心业务处理与数据转换工作，它完全不关心界面UI与响应事件如果处理，它对原始模型类`***Model`有强引用 ，管理最基层的数据交换。

1、响应事件处理层的业务数据请求
```objc
- (RACSignal *)fetchPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory
{
     return [XFConvertDataManagerToType(XFPictureDataManager *) grabPictureDataWithMainCategory:mainCategory secondCategory:secondCategory];
}
```

2、模型数据与界面显示数据的转换
```objc
- (RACSignal *)deconstructPreLoadData:(id)preLoadData {
    self.pictureListModel = preLoadData;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        XFPictureProvider *provider = [XFPictureProvider provider];
        [subscriber sendNext:[provider collectedPictureExpressDataFrom:preLoadData]];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}
```

###数据层`***DataManager`和服务层`***Service`
这两层是VIPER架构的补充，它们分别充当数据搬运管理者和本地/远程数据访问服务，这两层的特殊地方是可以在任意模块中使用，所以是无关于模块的，数据层和服务层也是可以分散使用。数据层会对所需的用服务对象`***Service`有强引用，它会调用相关服务对象获得所需的数据，服务层除了对本地/远程数据获取，还会进行必要的模型转换工作。

1、数据层整理返回给业务层数据
```objc
- (RACSignal *)grabPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory
{
    return [self.pictureService pullPictureDataWithMainCategory:mainCategory secondCategory:secondCategory];
}
```

2、服务层获得远程数据和模型转换
```objc
- (RACSignal *)pullPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory
{
    // 从服务器获取数据
    return [[XFRACHttpTool getWithURL:@"http://image.baidu.com/search/acjson"
                       params:@{
                                @"tn": @"resultjson_com",
                                @"ipn": @"rj",
                                @"word":mainCategory,
                                @"step_word":secondCategory,
                                @"pn": @1, // 第几条开始
                                @"rn": @5, // 返回多少条
                                }]
            map:^id(RACTuple *tuple) {
            // 模型转换
        return [XFPictureListModel mj_objectWithKeyValues:tuple.first];
    }];
}
```


##相关文章
[iOS Architecture Patterns](http://www.tuicool.com/articles/rI7ZNn)

[Architecting iOS Apps with VIPER](https://objccn.io/issue-13-5/)

