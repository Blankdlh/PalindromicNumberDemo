//
//  PNViewController.m
//  PalindromicNumberDemo
//
//  Created by 戴 立慧 on 13-3-16.
//
//

#import "PNViewController.h"
#import "PNResultTableViewController.h"

#define MAX_NUM 1000000000
@interface PNViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputNumText; //数字输入框

@end

@implementation PNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CalculateResult"]) {
        PNResultTableViewController * resultTableViewController = segue.destinationViewController;
        resultTableViewController.inputNum = [self.inputNumText.text integerValue];
    }
}

#pragma mark - actions
- (IBAction)submitButtonTouched:(id)sender
{
    if (self.inputNumText.text ==nil || [self.inputNumText.text isEqualToString:@""]) {//不能为空
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"输入不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }
    else if ([self.inputNumText.text integerValue] > MAX_NUM || [self.inputNumText.text integerValue] < 0){//验证数字范围
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"数字范围不正确" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }
    else
    {
        [self performSegueWithIdentifier:@"CalculateResult" sender:self];
    }
    
    
}
- (void)viewDidUnload
{
    [self setInputNumText:nil];
    [super viewDidUnload];
}
@end
