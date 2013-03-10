//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 09/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSString *result;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(void) flipCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    BOOL mismatchPair;
    
    if (card && !card.isUnplayable) {
        if(!card.isFaceUp){
            for(Card *otherCard in self.cards){
                mismatchPair = YES;
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.result = [NSString stringWithFormat:@"Matched %@ and %@ for %d points", otherCard.contents, card.contents, matchScore*MATCH_BONUS];
                        mismatchPair = NO;
                    }else{
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.result = [NSString stringWithFormat:@"%@ and %@ dont' match! %d points penalty!", otherCard.contents, card.contents, MISMATCH_PENALTY];
                        mismatchPair = NO;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
            if(!card.isUnplayable && mismatchPair==YES) self.result = [NSString stringWithFormat:@"Flipped up %@", card.contents];
        }
        card.faceUp = !card.isFaceUp;
    }
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    
    self = [super init];
    
    if(self){
        for(int i=0; i<count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                self.cards[i] =  card;
            }else{
                self = nil;
                break;
            }
        }
    }
    
    return self;
}
@end
