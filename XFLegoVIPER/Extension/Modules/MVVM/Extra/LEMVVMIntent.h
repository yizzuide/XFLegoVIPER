//
//  LEMVVMComponetName.h
//  TZEducation
//
//  Created by Yizzuide on 2017/10/28.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#ifndef LEMVVMIntent_h
#define LEMVVMIntent_h

@protocol LEMVVMIntent

@optional
/*
 * 组件名
 */
@property (copy, nonatomic) NSString *compName;

/*
 * 意图数据
 */
@property (copy, nonatomic) id intentData;
@end

#endif /* LEMVVMComponetName_h */
