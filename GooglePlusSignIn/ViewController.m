//
//  ViewController.m
//  GooglePlusSignIn
//
//  Created by Abhishek Banthia on 15/06/15.
//  Copyright (c) 2015 Abhishek Banthia. All rights reserved.
//

#import "ViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

static NSString * const kClientId = @"874430053766-f6vg1hnc0n8ask20matt9e4l66fu59n1.apps.googleusercontent.com";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender
{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    signIn.clientID = kClientId;
    signIn.scopes = @[ kGTLAuthScopePlusLogin, kGTLAuthScopePlusUserinfoEmail];
    signIn.delegate = self;
    [signIn signOut];
    
    [signIn authenticate];
    
     [self.loginButton setTitle:@"Getting Information" forState:UIControlStateNormal];
    
}

#pragma mark -
#pragma mark GPlus Delegate: Not being used as we have upgraded SDK. More here: https://code.google.com/p/google-plus-platform/issues/detail?id=900
#pragma mark -

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error
{
    [self.loginButton setTitle:@"Authentication Finished" forState:UIControlStateNormal];
    
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
    plusService.retryEnabled = YES;
    [plusService setAuthorizer:auth];
    
    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    
    [plusService executeQuery:query
            completionHandler:^(GTLServiceTicket *ticket,
                                GTLPlusPerson *person,
                                NSError *error)
     {
         if (error)
         {
             GTMLoggerError(@"Error: %@", error);
             
            [self.loginButton setTitle:@"Authentication Error. Check console." forState:UIControlStateNormal];
             
         }
         else
         {
             NSString *description = [NSString stringWithFormat:
                                      @"%@\n%@\n%@\n%@\n%@\n%@", person.displayName,
                                      person.birthday,
                                      [(GTLPlusPersonEmailsItem *)person.emails[0] value],
                                      person.gender,
                                      person.image.url,
                                      person.identifier];
             
             NSLog(@"Description:%@", description);
             
              [self.loginButton setTitle:[NSString stringWithFormat:@"Logged in as : %@", person.displayName] forState:UIControlStateNormal];
             
             /*
              Commenting because of change in flow
              [self performSegueWithIdentifier:@"signUpSegue" sender:self.userDetails];
              */
         }
         
         [self.view setUserInteractionEnabled:YES];
     }];
}
@end
