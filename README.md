<p align="center">
    <img src="./ScreenShot/logo.jpg" alt="logo" />
</p>
<p align="center">
  <a href="http://cocoadocs.org/docsets/XFLegoVIPER"><img src="https://img.shields.io/badge/cocoapods-v1.0.0-brightgreen.svg" alt="cocoapods" /></a>
  <img src="https://img.shields.io/badge/language-ObjC-orange.svg" alt="language" />
  <img src="https://img.shields.io/npm/l/express.svg" alt="LICENSE" />
  <img src="https://img.shields.io/badge/platform-ios6%2B-green.svg" alt="version" />
</p>

##什么是VIPER？
VIPER 是一个创建 iOS 应用简明构架的程序。VIPER 可以是视图 (View)，交互器 (Interactor)，展示器 (Presenter)，实体 (Entity) 以及路由 (Routing) 的首字母缩写。简明架构将一个应用程序的逻辑结构划分为不同的责任层。这使得它更容易隔离依赖项 (如数据库)，也更容易测试各层间的边界处的交互。

作用：VIPER不属于MV*架构系列，但它是所有这些架构中单一责任分得最细的一个，有利于大型项目的构建和多人对同一个模块开发，好处有易维护、易迁移、代码多模块共用。VIPER架构结构就像搭积木一个，且很容易从传统MVC架构迁移过来，MVC的代码和VIPER架构可以很容易相互关联与调用，所以可以在一个项目里即有MVC架构的模块，又有VIPER架构的模块。

<p align="center">
    <img src="https://www.objc.io/images/issue-13/2014-06-07-viper-intro-0a53d9f8.jpg" alt="VIPER 理念图" />
</p>

##VIPER组成结构图
![XFLegoVIPER construct](https://www.objc.io/images/issue-13/2014-06-07-viper-wireframe-76305b6d.png)

##相关文章
[iOS Architecture Patterns](http://www.tuicool.com/articles/rI7ZNn)

[Architecting iOS Apps with VIPER](https://objccn.io/issue-13-5/)

