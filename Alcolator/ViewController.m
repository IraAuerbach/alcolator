//
//  ViewController.m
//  Alcolator
//
//  Created by Ira Auerbach on 3/5/15.
//  Copyright (c) 2015 Ira Auerbach. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) UILabel *sliderValueLabel; //added in my assignment, not part of code in lesson
@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

//property to autoresize the layouts
@property(nonatomic) BOOL autoresizesSubviews;

@end

@implementation ViewController

- (void)loadView {
    //allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    //allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    UILabel *label2 = [[UILabel alloc] init];
    
    //add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addSubview:label2];
    [self.view addGestureRecognizer:tap];
    
    //Assign the view and gesture recognizer to our properties
    self.beerPecentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
    self.sliderValueLabel = label2;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //set sliderValueLabel to initial beerCountSlider setting
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.1f",self.beerCountSlider.value];
    
    //set our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //tells the text field that 'self', this instance of 'ViewController' should be treated as the text field's delegate
    self.beerPecentTextField.delegate = self;
    self.beerPecentTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1f]; //assignment change
    
    //set the placeholder test
    self.beerPecentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    self.beerPecentTextField.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f]; //assignment change
    self.beerPecentTextField.textAlignment = UITextAlignmentCenter;
    
    //self.beerPecentTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter; //assignment change
    //self.beerPecentTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //assignment change
    
    //tells 'self.beerCountSlider' that when its value changes, it should call '[self -sliderValueDidChange:]'
    //this is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    self.beerCountSlider.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1f];
    
    //set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    self.beerCountSlider.value = 5;
    
    //tells 'self.calculateButton' that when a finger is lifted from the button while still inside its bounds, to call '[self -buttonPressed:]'
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    self.calculateButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30.0f]; //assignment change
    
    //set the resultsLabel text
    self.resultLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1f];
    self.resultLabel.textAlignment = UITextAlignmentCenter;
    self.resultLabel.font = [UIFont fontWithName:@"Helvetica"  size:17.0f];
    
    //set the sliderValueLabel
    self.sliderValueLabel.textAlignment = UITextAlignmentCenter;
    self.sliderValueLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
    self.sliderValueLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1f];
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.1f",self.beerCountSlider.value];
    
    //tells the tap gesture recognizer to call '[self -tapGestureDidFire:]' when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    //Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    //CGFloat viewWidth = 320;
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat padding = viewHeight / 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = viewHeight / 10;
    //CGFloat itemHeight = 44;
    
    self.beerPecentTextField.frame = CGRectMake(padding, padding*2, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPecentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.sliderValueLabel.frame = CGRectMake(padding, bottomOfSlider, itemWidth, itemHeight/2);
    
    CGFloat bottomOfSliderValueLabel = CGRectGetMaxY(self.sliderValueLabel.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSliderValueLabel + padding, itemWidth, itemHeight * 4);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidChange:(UITextField *)sender {
    //Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber ==0) {
        //The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}
- (void)sliderValueDidChange:(UISlider *)sender {
    
    //Display beerCountSlider value in sliderValueLabel in realtime
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
    
    NSLog(@"Slider value changed to %f0", sender.value);
    [self.beerPecentTextField resignFirstResponder];
}
- (void)buttonPressed:(UIButton *)sender {
    [self.beerPecentTextField resignFirstResponder];
    
    //first, calculate how much alcohol is in all those beers...
    
    float numberOfBeers = self.beerCountSlider.value;
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
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%.1f %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    
}
- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPecentTextField resignFirstResponder];
}


@end
