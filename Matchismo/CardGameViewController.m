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
#import "ThreeCardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
//@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) ThreeCardMatchingGame *threeGame;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (strong, nonatomic) GameResult *gameResult;

@end

@implementation CardGameViewController

-(GameResult *)gameResult{
    if(!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

-(CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count ] usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}
-(ThreeCardMatchingGame *)threeGame{
    if(!_threeGame) _threeGame = [[ThreeCardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc]init]];
    return _threeGame;
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
    for (UIButton *button in cardButtons) {
        button.imageEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
    }
    [self updateUI];
}

-(void)updateUI{
    UIImage *cardBackImage = [UIImage imageNamed:@"back.jpg"];
    UIImage *cardFrontImage = [UIImage alloc];
    if(_gameMode.selectedSegmentIndex==0){
        for(UIButton *cardButton in self.cardButtons){
            Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
            [cardButton setImage:cardFrontImage forState:UIControlStateSelected];
            [cardButton setImage:cardFrontImage forState:UIControlStateDisabled|UIControlStateSelected];
            [cardButton setTitle:card.contents forState:UIControlStateSelected];
            [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];

            cardButton.selected = card.isFaceUp;
            cardButton.enabled = !card.isUnplayable;
            cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        }
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", _game.score];
        self.resultLabel.text = _game.result;
    }else{
        for(UIButton *cardButton in self.cardButtons){
            Card *card = [self.threeGame cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
            [cardButton setImage:cardFrontImage forState:UIControlStateSelected];
            [cardButton setImage:cardFrontImage forState:UIControlStateDisabled|UIControlStateSelected];
            [cardButton setTitle:card.contents forState:UIControlStateSelected];
            [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
            
            cardButton.selected = card.isFaceUp;
            cardButton.enabled = !card.isUnplayable;
            cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        }
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", _threeGame.score];
        self.resultLabel.text = _threeGame.result;
    }
}

-(void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    //sender.selected = !sender.isSelected;
    if(_gameMode.selectedSegmentIndex==0){
        [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
        
    }else{
        [self.threeGame flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    }
    self.flipCount++;
    [self updateUI];
    if(_gameMode.selectedSegmentIndex == 0){
        self.gameResult.score = self.game.score;
    }else{
        self.gameResult.score = self.threeGame.score;
    }
    
}
- (IBAction)deal:(id)sender {
    /*if (_gameMode.selectedSegmentIndex ==0) {
        CardMatchingGame *newGame = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
        self.game = newGame;
        self.flipCount = 0;
        self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    }else{
        ThreeCardMatchingGame *newGame = [[ThreeCardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
        self.threeGame = newGame;
        self.flipCount = 0;
        self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    }*/
    if (_gameMode.selectedSegmentIndex == 0) {
        self.game = nil;
        
    }else{
        self.threeGame = nil;
    }
    self.gameResult = nil;
    self.flipCount = 0;
    [self updateUI];
}
- (IBAction)changeGameMode:(id)sender {
    CardMatchingGame *TwoNewGame;
    ThreeCardMatchingGame *ThreeNewGame;
    switch (_gameMode.selectedSegmentIndex) {
        case 0:
            TwoNewGame = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
            self.game = TwoNewGame;
            self.flipCount = 0;
            self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
            [self updateUI];
            break;
        case 1:
            ThreeNewGame = [[ThreeCardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
            self.threeGame = ThreeNewGame;
            self.flipCount = 0;
            self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
            [self updateUI];
            break;
        default:
            break;
    }
}

@end
