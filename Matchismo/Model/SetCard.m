//
//  SetCard.m
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 13/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


+(NSArray *)validColors{
    static NSArray *validColors = nil;
    if (!validColors) {
        validColors = @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor]];
    }
    return validColors;
}

+(NSArray *)validTranparency{
    static NSArray *validTransparency = nil;
    if (!validTransparency) {
        validTransparency = @[@(1.0), @(0.5), @(0.1)];
    }
    return validTransparency;
}

+(NSArray *)validFigures{
    static NSArray *validFigures = nil;
    if(!validFigures){
        validFigures = @[@"▲", @"▲\n▲", @"▲\n▲\n▲", @"⚫", @"⚫\n⚫", @"⚫\n⚫\n⚫", @"◼", @"◼\n◼", @"◼\n◼\n◼"];
    }
    return validFigures;
}

-(int)match:(NSArray *)otherCards andGameMode:(NSUInteger)mode{
    int score = 0;
    if(mode == 2 && [otherCards count]==2){
        SetCard *firstOtherCard = [otherCards objectAtIndex:0];
        SetCard *secondOtherCard = [otherCards objectAtIndex:1];
        if([firstOtherCard.color isEqual:self.color] && [secondOtherCard isEqual:self.color] ){
            score = 3;
        }else if((firstOtherCard.transparency == self.transparency) && (secondOtherCard.transparency == self.transparency)){
            score = 3;
        }else if ((firstOtherCard.figure == self.figure) && (secondOtherCard.figure == self.figure)){
            score = 3;
        }
    }
    return score;
}

-(NSAttributedString *)description{
    NSMutableAttributedString *description = [[SetCard validFigures][self.figure] mutableCopy];
    [description addAttributes:@{NSForegroundColorAttributeName: [self.color colorWithAlphaComponent:self.transparency]} range:[[SetCard validFigures][self.figure] range]];
    return description;
}

@end
