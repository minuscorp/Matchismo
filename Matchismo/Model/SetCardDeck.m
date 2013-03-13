//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 13/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(id)init{
    self = [super init];
    
    if(self){
        for(int j = 0; j<[[SetCard validFigures] count]; j++){
            for(int i=0; i<[[SetCard validTransparency] count]; i++){
                for(UIColor *color in [SetCard validColors]){
                    SetCard *card = [[SetCard alloc]init];
                    card.figure = j;
                    card.color = color;
                    card.transparency = [[SetCard validTransparency][i] floatValue];
                }
            }
        }
    }
    return self;
}
@end
