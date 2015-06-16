# Google Plus SignIn Migration To Google Sign In

Migration to latest Google Sign In:

![Sample Animations](https://github.com/Abhishaker17/GooglePlusSignInMigration/blob/master/Images/SampleImage.jpeg)

More details here: [Google Plus Sign In Issue 900](https://code.google.com/p/google-plus-platform/issues/detail?id=900 "Google Plus Sign In Issue")

Steps to migrate:

1. Add 2 URL types in your Info.plist

	####1st URL Type
    	-- URL Identifier - Some Unique String
        -- URL Scheme - Reversed Client ID [First string in the array]
    ####2nd URL Type
    	-- URL Identifier - Some Unique String
		-- URL Scheme - Bundle identifier
        
2. import <GoogleSignIn/GoogleSignIn.h> in your AppDelegate

		- (BOOL)application: (UIApplication *)application openURL: (NSURL *)url
        sourceApplication: (NSString *)sourceApplication annotation:(id) annotation
        {
       			return [[GIDSignIn sharedInstance]
                handleURL:url 
                sourceApplication:sourceApplication
                annotation:annotation];
        }
        
3. Fetch details through WebView or through any Google App installed on device.
