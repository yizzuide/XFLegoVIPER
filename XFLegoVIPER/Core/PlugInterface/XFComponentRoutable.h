//
//  XFComponentRoutable.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFComponentReflect.h"
#import "XFComponentUI.h"
#import "XFUIBus.h"
#import "XFEventReceivable.h"

// 注册键盘弹出通知
#define XF_RegisterKeyboardNotifaction \
XF_RegisterMVxNotis_(UIKeyboardWillChangeFrameNotification)

// 处理键盘弹出通知
#define XF_HandleKeyboardNotifaction \
XF_EventIs_(UIKeyboardWillChangeFrameNotification, { \
    NSDictionary *dict = intentData; \
    CGFloat y = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y; \
    UIViewController<XFComponentUI> *ui = (id)[XFComponentReflect uInterfaceForComponent:self]; \
    if ([ui respondsToSelector:@selector(needUpdateInputUInterfaceY:durationTime:)]) { \
        [ui needUpdateInputUInterfaceY:y durationTime:[dict[UIKeyboardAnimationDurationUserInfoKey] floatValue]]; \
    } \
}) \

// 自动处理通用键盘弹出通知
#define XF_AutoHandleKeyboardNotifaction \
- (void)registerMVxNotifactions \
{ \
    XF_RegisterKeyboardNotifaction \
} \
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData \
{ \
    XF_HandleKeyboardNotifaction \
}

/**
 *  一个组件可运行接口
 */
NS_ASSUME_NONNULL_BEGIN
@protocol XFComponentRoutable <XFEventReceivable>

@optional

/**
 *  上一个组件（来源组件）
 */
@property (nonatomic, weak, readonly) __kindof id<XFComponentRoutable> fromComponentRoutable;

/**
 *  下一个组件
 */
@property (nonatomic, weak, readonly) __kindof id<XFComponentRoutable> nextComponentRoutable;

/**
 *  上一个URL组件传递过来的URL参数
 */
@property (nonatomic, copy, nullable) NSDictionary *URLParams;

/**
 *  上一个URL组件传递过来的自定义数据对象
 */
@property (nonatomic, copy, nullable) id componentData;

/**
 *  预设要传递给其它组件的意图数据
 */
@property (nonatomic, copy, nullable) id intentData;

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
 * 定时器循环运行方法
 */
- (void)run;

@end
NS_ASSUME_NONNULL_END
