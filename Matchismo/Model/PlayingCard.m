//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 08/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+(NSArray *)validSuits{
    static NSArray *validSuits = nil;
    if(!validSuits) validSuits = @[@"♥", @"♦", @"♠", @"♣"];
    return validSuits;
}
+(NSArray *)rankStrings{
    static NSArray *validRanks = nil;
    if(!validRanks) validRanks = @[@"?", @"A", @"2", @"3",@"4",
                                   @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return validRanks;
}

-(void)setSuit:(NSString *)suit{
    if([[PlayingCard validSuits]containsObject:suit]){
        _suit = suit;
    }
}
+(NSUInteger)maxRank{
    return [self rankStrings].count -1;
}

-(NSString * )suit{
    return _suit ? _suit : @"?";
}
-(void)setRank:(NSUInteger)rank{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}
/*-(NSString *)contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}*/
-(int) match:(NSArray *)otherCards{
    int score = 0;
    
    if ([otherCards count]==1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }else if(otherCard.rank == self.rank){
            score = 4;
        }
    }else if ([otherCards count]== 2){
        PlayingCard *firstOtherCard = [otherCards objectAtIndex:0];
        PlayingCard *secondOtherCard = [otherCards objectAtIndex:1];
        if ([firstOtherCard.suit isEqualToString:self.suit]) {
            score = 2;
        }else if ((firstOtherCard.rank == self.rank) && (secondOtherCard.rank == self.rank)){
            score = 8;
        }
    }
    return score;
}

@end
