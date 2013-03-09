//
//  Deck.h
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 08/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(int)numRemainingCards;
-(Card *)drawRandomCard;

@end
