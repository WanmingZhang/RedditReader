#  TTI Coding Challenge.txt

* Given a 'listing' endpoint to the reddit API (https://www.reddit.com/dev/api), display a list of reddit listings with the thumbnail and title. This list should be able to be paginated. Clicking on one of the rows should take the user to a view with the comments for that listing.



* Possible endpoints can be [hot, new, random, top] anything you like. An example URL would be http://www.reddit.com/r/all/new.json



* The UI should be kept simple, taking advantage of the UIKit framework. We are looking for clean, organized, and testable code. 



* The whole project should take less than a day to complete, but let us know if you'll need longer or have any clarification questions. Note this does not mean you have to return the project in <1 day. We know that your time is valuable and want to set proper expectations.


The project contains following modules:

* Data model: This module contains "Listing" structures needed to decode the Json data retrieved from listing service

* Generics: This module contains a "Observable" generic class used for binding views and view models for MVVM architecture. This is a closure based method for binding, which can be replaced with the Apple "Combine" framework if desired.

*  Network: This module contains network related funtionalities and helper methods.

*  Services: This module contains a "ListService" for fetching Json data from remote services, and a "ImageFetcher" to fetch and cache images from remote services.

*  Views: This module contains views/view controllers, etc. and corresponding view models for UI display.

*  "signInReddit" in SceneDelegate provides a login page for user, comment out the method if user doesn't wish to login.

*  OAuth is done using a third party framework "OAuthSwift": https://github.com/OAuthSwift/OAuthSwift

