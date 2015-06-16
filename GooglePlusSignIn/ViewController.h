//
//  ViewController.h
//  GooglePlusSignIn
//
//  Created by Abhishek Banthia on 15/06/15.
//  Copyright (c) 2015 Abhishek Banthia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface ViewController : UIViewController <GPPSignInDelegate, GIDSignInDelegate, GIDSignInUIDelegate>


@end

