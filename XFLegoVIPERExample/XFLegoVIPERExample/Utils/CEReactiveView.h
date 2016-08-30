//
//  RWView.h
//  RWTwitterSearch
//
//  Created by Colin Eberhardt on 25/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

@import Foundation;

/// A protocol which is adopted by views which are backed by view models.
@protocol CEReactiveView <NSObject>

/// Binds the given ExpressData to the view
- (void)bindExpressData:(id)expressData;

@end
