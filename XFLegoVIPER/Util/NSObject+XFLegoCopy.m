//
//  NSObject+XFLegoCopy.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/10/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "NSObject+XFLegoCopy.h"
#import <objc/runtime.h>

@implementation NSObject (XFLegoCopy)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithCoder:(NSCoder *)coder
{
    [self xfLego_enumeratePropertyWithValueBlock:^id(NSString *key) {
        return [coder decodeObjectForKey:key];
    } opreatorBlock:^(NSString *key, id value) {
        [self setValue:value forKey:key];
    }];
    return self;    
}
#pragma clang diagnostic pop

- (void)encodeWithCoder:(NSCoder *)coder
{
    [self xfLego_enumeratePropertyWithValueBlock:^id(NSString *key) {
        return [self valueForKey:key];
    } opreatorBlock:^(NSString *key, id value) {
        [coder encodeObject:value forKey:key];
    }];
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] allocWithZone:zone] init];
    [self xfLego_enumeratePropertyWithValueBlock:^id(NSString *key) {
        return [self valueForKey:key];
    } opreatorBlock:^(NSString *key, id value) {
        if ([value isKindOfClass:[NSMutableArray class]] || [value isKindOfClass:[NSMutableDictionary class]]) {
            [copy setValue:[value mutableCopy] forKey:key];
        } else if ([value isKindOfClass:[NSObject class]]) {
            [copy setValue:[value copy] forKey:key];
        }else{
            [copy setValue:value forKey:key];
        }
    }];
    return copy;    
}

- (void)xfLego_enumeratePropertyWithValueBlock:(id (^)(NSString *key))ValueBlock opreatorBlock:(void(^)(NSString *key,id value))OpreatorBlock
{
    Class cls = [self class];
    while (cls != [NSObject class]) {
        /*判断是自身类还是父类*/
        BOOL bIsSelfClass = (cls == [self class]);
        unsigned int iVarCount = 0;
        unsigned int propVarCount = 0;
        unsigned int sharedVarCount = 0;
        /*变量列表，含属性以及私有变量*/
        Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;
        /*属性列表*/
        objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);
        /*属性的个数*/
        sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;
        for (int i = 0; i < sharedVarCount; i++) {
            const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i));
            NSString *key = @(varName);
            /*valueForKey只能获取本类所有变量以及所有层级父类的属性，不包含任何父类的私有变量(会崩溃)*/
            id varValue = ValueBlock(key);
            NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"];
            if (varValue && [filters containsObject:key] == NO) {
                OpreatorBlock(key,varValue);
            }
        }
        free(ivarList);
        free(propList);
        cls = class_getSuperclass(cls);
    }
}
@end
