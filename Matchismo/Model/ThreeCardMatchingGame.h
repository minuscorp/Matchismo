//
//  ThreeCardMatchingGame.h
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 10/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "PlayingCard.h"


@interface ThreeCardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(PlayingCard *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString *result;
@end
