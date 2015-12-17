# belly_codechallenge
This is a simple application that uses your current location to pull information about places around you using the foursquare API. It uses NSUserDefaults to store the most recent JSON object, in the case that a user tries to use the application while not connected to the internet.

###Dependencies
* CocoaPods
* SwiftyJSON
* Alamofire

Before running application, make sure that you run
```
Pod Install
```
before trying to run the application.

###Running the application
Before the API will return any values, you must enter your foursquare API keys in belly_cc/FSClientDetails.swift. Application will run by navigating to the directory via the command line, and then running the
```
belly_cc.xcworkspace
```

###License
See LICENSE

###Issues
When running on the iOS simulator packaged with XCode, if no location is set, no locaitons will appear. Sometimes the simulator doesn't feed the location info into the application, and the application will get stuck on the splash screen. You will have to close and re run the application to have it recognize the location info.

###Code from
The 'Reachabilty' file was written by Isuru Nanayakkara and used under the MIT license.
