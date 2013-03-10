//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 08/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
//@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation CardGameViewController

-(CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count ] usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}

/*-(Deck * )deck{
    if(!_deck) _deck = [[PlayingCardDeck alloc]init];
    return _deck;

}*/

-(void)setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    /*for (UIButton *cardButtons in self.cardButtons) {
        Card * card = [self.deck drawRandomCard];
        [cardButtons setTitle:card.contents forState:UIControlStateSelected];
    }*/
    [self updateUI];
}

-(void)updateUI{
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];

        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", _game.score];
    self.resultLabel.text = _game.result;
}

-(void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    //sender.selected = !sender.isSelected;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}
- (IBAction)deal:(id)sender {
    CardMatchingGame *newGame = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
    self.game = newGame;
    self.flipCount = 0;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    [self updateUI];
}

@end
