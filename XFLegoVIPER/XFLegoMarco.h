//
//  XFLegoMarco.h
//  VIPERGem
//
//  Created by yizzuide on 15/12/27.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFLegoMarco_h
#define XFLegoMarco_h

// 转到XFActivity类型
#define LEGORealInterface(interface) (XFActivity *)(interface)
// 转到新的子接口类型或子对象
#define LEGORealProt(nowProt,oldProt) ((nowProt)(oldProt))


#endif /* XFLegoMarco_h */
