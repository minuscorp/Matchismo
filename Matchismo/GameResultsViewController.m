//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by Jorge Revuelta Herrero on 13/03/13.
//  Copyright (c) 2013 Jorge Revuelta Herrero. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultsViewController

-(void)updateUI{
    NSString *displayText = @"";
    for(GameResult *result in [GameResult allGameResults]){
        displayText = [displayText stringByAppendingFormat:@"Score %d (%@, %g)\n", result.score, result.end, round(result.duration)];
    }
    self.display.text = displayText;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}
-(void)setup{
    
}

-(void)awakeFromNib{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}


@end
