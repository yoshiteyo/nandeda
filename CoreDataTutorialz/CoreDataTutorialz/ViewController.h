//
//  ViewController.h
//  CoreDataTutorialz
//
//  Created by tsuyoshi niwa on 8/18/14.
//  Copyright (c) 2014 sopranomaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
- (IBAction)addPersonButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

@end
