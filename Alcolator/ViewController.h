//
//  ViewController.h
//  Alcolator
//
//  Created by Ira Auerbach on 3/5/15.
//  Copyright (c) 2015 Ira Auerbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPecentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *sliderValueLabel; //added in my assignment, not part of code in lesson

-(void)buttonPressed:(UIButton *)sender;


@end

