//
//  Person.h
//  InstaMakers
//
//  Created by John Blanchard on 8/19/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface Person : NSObject
@property NSString* firstName;
@property NSString* lastName;
@property NSString* userName;
@property NSString* password;
@property Photo* profilePicture;
@property NSMutableArray* arrayOfPhotos;
@end
