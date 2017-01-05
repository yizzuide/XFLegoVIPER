//
//  XFComponentRoutable.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

/**
 *  一个组件可运行接口
 */
@protocol XFComponentRoutable <NSObject>

@optional
/* ---------------- 这两个组件关联属性内部已经实现，外部不用再实现 ---------------- */
/**
 *  上一个组件（来源组件）
 */
@property (nonatomic, weak, readonly) __kindof id<XFComponentRoutable> fromComponentRoutable;

/**
 *  下一个组件
 */
@property (nonatomic, weak, readonly) __kindof id<XFComponentRoutable> nextComponentRoutable;
/* ------------------------------------------------------------------------ */

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

/**
 *  接收到上一个组件的回传意图数据
 *
 *  @param intentData 消息数据
 */
- (void)onNewIntent:(id)intentData;

/**
 *  组件将获得焦点
 */
- (void)componentWillBecomeFocus;

/**
 *  组件将失去焦点
 */
- (void)componentWillResignFocus;

/**
 *  接收到组件的消息事件
 *
 *  @param eventName  消息名
 *  @param intentData 消息数据
 */
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData;
@end
