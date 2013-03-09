//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 08/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import "Card.h"


@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSArray *)rankStrings;
+(NSUInteger)maxRank;

@end
