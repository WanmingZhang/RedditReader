#  Reddit Reader

* Consume reddit 'listing' endpoint to the reddit API (https://www.reddit.com/dev/api), display a list of reddit listings with the thumbnail and title. This list should be able to be paginated. 

* Possible endpoints can be [hot, new, random, top] anything you like. An example URL would be http://www.reddit.com/r/all/new.json


The project contains following modules:

* Data model: This module contains "Listing" structures needed to decode the Json data retrieved from listing service

* Generics: This module contains a "Observable" generic class used for binding views and view models for MVVM architecture. This is a closure based method for binding, which can be replaced with the Apple "Combine" framework if desired.

*  Network: This module contains network related funtionalities and helper methods.

*  Services: This module contains a "ListService" for fetching Json data from remote services, and a "ImageFetcher" to fetch and cache images from remote services.

*  Views: This module contains views/view controllers, etc. and corresponding view models for UI display.

*  "signInReddit" in SceneDelegate provides a login page for user, comment out the method if user doesn't wish to login.

*  OAuth is done using "OAuthSwift": https://github.com/OAuthSwift/OAuthSwift

