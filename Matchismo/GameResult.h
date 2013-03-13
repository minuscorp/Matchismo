//
//  GameResult.h
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 13/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property(nonatomic) int score;

+(NSArray *)allGameResults;
@end
