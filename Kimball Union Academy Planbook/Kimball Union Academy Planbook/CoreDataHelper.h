//
//  CoreDataHelper.h
//  Kimball Union Academy Planbook
//
//  Created by Nathaniel Lang on 8/9/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

@property (nonatomic, strong) UIManagedDocument *document;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end
