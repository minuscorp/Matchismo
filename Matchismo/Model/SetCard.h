//
//  SetCard.h
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 13/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic) NSAttributedString *frontFace;
@property (nonatomic) NSUInteger figure;
@property (nonatomic) CGFloat transparency;
@property (strong, nonatomic) UIColor *color;

+(NSArray *)validColors;
+(NSArray *)validTransparency;
+(NSArray *)validFigures;
@end
