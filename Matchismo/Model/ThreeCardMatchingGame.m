//
//  ThreeCardMatchingGame.m
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 10/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import "ThreeCardMatchingGame.h"

@interface ThreeCardMatchingGame ()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSString *result;
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation ThreeCardMatchingGame

-(NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

#define MATCH_THREE_BONUS 9
#define MISMATCH_THREE_PENALTY 3
#define FLIP_COST 1

-(void) flipCardAtIndex:(NSUInteger)index{
    PlayingCard *card = [self cardAtIndex:index];
    BOOL mismatchThree;
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            for(Card *secondCard in self.cards){
                for(Card *firstCard in self.cards){
                    if(secondCard.isFaceUp && !secondCard.isUnplayable && firstCard.isFaceUp && !firstCard.isUnplayable && (secondCard != firstCard)){
                        int matchScore = [card match:@[secondCard, firstCard] andGameMode:1];
                        if(matchScore){
                            card.unplayable = YES;
                            secondCard.unplayable = YES;
                            firstCard.unplayable = YES;
                            self.score += matchScore * MATCH_THREE_BONUS;
                            self.result = [NSString stringWithFormat:@"Matched %@, %@ and %@ for %d points", secondCard.contents, firstCard.contents , card.contents, matchScore*MATCH_THREE_BONUS];
                            mismatchThree = NO;
                        }else{
                            secondCard.faceUp = NO;
                            firstCard.faceUp = NO;
                            self.score -= MISMATCH_THREE_PENALTY;
                            self.result = [NSString stringWithFormat:@"%@, %@ and %@ don't match! %d points penalty!", secondCard.contents, firstCard.contents, card.contents, MISMATCH_THREE_PENALTY];
                            mismatchThree = NO;
                        }
                        break;
                    }
                }
            }
            self.score -= FLIP_COST;
            if(!card.isUnplayable && mismatchThree == YES) self.result = [NSString stringWithFormat:@"Flipped up %@", card.contents];
        }
        card.faceUp = !card.isFaceUp;
    }
}

-(PlayingCard *)cardAtIndex:(NSUInteger)index{
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
