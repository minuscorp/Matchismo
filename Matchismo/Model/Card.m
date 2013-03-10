//
//  Card.m
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 08/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int) match:(NSArray *)otherCards andGameMode:(NSUInteger)mode{
    int score = 0;
    for(Card * card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    return score;
}

-(NSString * )description{
    return self.contents;
}

@end
