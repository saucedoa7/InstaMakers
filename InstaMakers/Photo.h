//
//  Photo.h
//  InstaMakers
//
//  Created by John Blanchard on 8/19/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSData
@property NSData* picture;
@property int count;
@property NSMutableArray* comments;
@end
