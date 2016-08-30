//
//  RWTableViewBindingHelper.h
//  RWTwitterSearch
//
//  Created by Colin Eberhardt on 24/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

@import Foundation;
#import <ReactiveCocoa/ReactiveCocoa.h>

/// A helper class for binding view models with NSArray properties to a UITableView.
@interface CETableViewBindingHelper : NSObject

// forwards the UITableViewDelegate methods
@property (weak, nonatomic) id<UITableViewDelegate> delegate;

- (instancetype) initWithTableView:(UITableView *)tableView
                      sourceSignal:(RACSignal *)source
                  selectionCommand:(RACCommand *)selection
                      templateCell:(UINib *)templateCellNib;

/**
 *   that allows you to define the View used for each child ViewModel, with the helper taking care of implementing the datasource protocol.
 *
 *  @param tableView       The table view which renders the array of ViewModels
 *  @param source          A source signal that relays changes to the array
 *  @param selection       An optional command to execute when a row is selected
 *  @param templateCellNib The nib for the cell Views.The cell that the given nib file defines within must implement the CEReactiveView protocol.
 *
 *  @return <#return value description#>
 */
+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)selection
                              templateCell:(UINib *)templateCellNib;

@end
