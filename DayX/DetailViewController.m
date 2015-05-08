//
//  DetailViewController.m
//  DayX
//
//  Created by Michael Sacks on 5/4/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateWithEntry:self.entry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearButton:(id)sender {
    self.textField.text = @"";
    self.textView.text = @"";
}

- (IBAction)saveButtonTapped:(id)sender {
    if (![self.textField.text isEqualToString:@"" ] || ![self.textView.text isEqualToString: @""]){
        if (self.entry) {
            self.entry.title = self.textField.text;
            self.entry.bodyText = self.textView.text;
            self.entry.timestamp = [NSDate date];
            [[EntryController sharedInstance] save];
        }
        //if there is no existing entry, make a new one
        else{
            self.entry = [[EntryController sharedInstance] createEntryWithTitle:self.textField.text withBodyText:self.textView.text];
            if ([self.entry.title isEqualToString: @""]){
                self.entry.title = @"Untitled";
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)updateWithEntry:(Entry *)entry{
    self.textField.text = entry.title;
    self.textView.text = entry.bodyText;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
