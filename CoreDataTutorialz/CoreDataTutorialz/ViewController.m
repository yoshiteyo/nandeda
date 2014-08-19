//
//  ViewController.m
//  CoreDataTutorialz
//
//  Created by tsuyoshi niwa on 8/18/14.
//  Copyright (c) 2014 sopranomaster. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    NSManagedObjectContext *context;
}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.firstnameTextField.delegate = self;
    self.lastnameTextField.delegate = self;
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    context = [appdelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPersonButton:(id)sender {
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSManagedObject *newPerson = [[NSManagedObject alloc] initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newPerson setValue:self.firstnameTextField.text forKey:@"firstname"];
    [newPerson setValue:self.lastnameTextField.text forKey:@"lastname"];
    
    NSError *error;
    [context save:&error];
    
    self.displayLabel.text = @"Person added.";
}

- (IBAction)searchButton:(id)sender {
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and lastname like %@",self.firstnameTextField.text,self.lastnameTextField.text];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if (matchingData.count <= 0) {
        self.displayLabel.text = @"No person found.";
    } else {
        NSString *firstname;
        NSString *lastname;
        
        for (NSManagedObject *obj in matchingData) {
            firstname = [obj valueForKey:@"firstname"];
            lastname = [obj valueForKey:@"lastname"];
        }
        
        self.displayLabel.text = [NSString stringWithFormat:@"Firstname: %@, Lastname: %@",firstname,lastname];
    }
}

- (IBAction)deleteButton:(id)sender {
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@",self.firstnameTextField.text];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if (matchingData.count <= 0) {
        self.displayLabel.text = @"No person deleted";
    } else {
        int count = 0;
        for (NSManagedObject *obj in matchingData) {
            [context deleteObject:obj];
            ++count;
        }
        [context save:&error];
        self.displayLabel.text = [NSString stringWithFormat:@"%d persons deleted.",count];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}
@end
