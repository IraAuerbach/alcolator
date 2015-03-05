//
//  ViewController.m
//  Alcolator
//
//  Created by Ira Auerbach on 3/5/15.
//  Copyright (c) 2015 Ira Auerbach. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *beerPecentTextField;
@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderValueLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //set sliderValueLabel to initial beerCountSlider setting
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.1f",self.beerCountSlider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textFieldDidChange:(UITextField *)sender {
    //Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber ==0) {
        //The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}
- (IBAction)sliderValueDidChange:(UISlider *)sender {
    
    //Display beerCountSlider value in sliderValueLabel in realtime
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
    
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPecentTextField resignFirstResponder];
}
- (IBAction)buttonPressed:(UIButton *)sender {
    [self.beerPecentTextField resignFirstResponder];
    
    //first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    float alcoholPercentageOfBeer = [self.beerPecentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    //now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    //decide whether to use "beer"/"beers" or "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers ==1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    }
    else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount ==1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    }
    else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    //generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    
}
- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPecentTextField resignFirstResponder];
}


@end
