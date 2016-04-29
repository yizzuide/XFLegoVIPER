//
//  XFUIOperatorProt.h
//  VIPERGem
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFUIOperatorProt_h
#define XFUIOperatorProt_h

#import <UIKit/UIKit.h>
#import "XFUserInterfaceProt.h"
@protocol XFUIOperatorProt <NSObject>

/**
 *  当前UI交互者的视图给Routing
 */
@property (nonatomic, weak, readonly) id<XFUserInterfaceProt> currentInterface;

/**
 *  传回的意图数据
 */
@property (nonatomic, strong) id intentData;

/**
 *  视图将重获焦点
 */
- (void)viewWillBecomeFoucsWithIntentData:(id)intentData;

/**
 *  视图将失去焦点
 */
- (void)viewWillResignFoucs;

@end


#endif /* XFUIOperatorProt_h */
