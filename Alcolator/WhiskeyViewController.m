//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Ira Auerbach on 3/5/15.
//  Copyright (c) 2015 Ira Auerbach. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

-(instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Whiskey", nil);
    }
    
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    //set title for navigation
    //self.title = NSLocalizedString(@"Whiskey", @"Whiskey");
    self.title = [NSString stringWithFormat:@"Whiskey (%.1f beers)",self.beerCountSlider.value];
    self.view.backgroundColor = [UIColor colorWithRed:.992 green:.992 blue:.588 alpha:1];
}

- (void)sliderValueDidChange:(UISlider *)sender {
    
    //Display beerCountSlider value in sliderValueLabel in realtime
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
    
    self.title = [NSString stringWithFormat:@"Whiskey (%.1f beers)",sender.value];
    NSLog(@"Slider value changed to %f0", sender.value);
    [self.beerPecentTextField resignFirstResponder];
}

-(void)buttonPressed:(UIButton *)sender;
{
    [self.beerPecentTextField resignFirstResponder];
    
    float numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    float alcoholPercentageOfBeer = [self.beerPecentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1;
    float alcoholPercentageOfWhiskey = 0.4;
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    NSString *beerText;
    
    if (numberOfBeers ==1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    }
    else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount ==1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    }
    else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shots");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%.1f %@ contains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    self.resultLabel.text = resultText;
}

@end
