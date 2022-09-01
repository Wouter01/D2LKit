# D2LKit

Calling the D2L [API](https://docs.valence.desire2learn.com/reference.html), made easy.

## Obtaining User ID and User Key
```swift
D2LManager.buildLoginURL(
  appID: "myAppID",
  appKey: "myAppKey",
  baseURL: "example.com",
  callbackURL: "http://linkbackaddress.com")
```
This will create an URL, where you can log in to your account as usual and obtain an User ID and User Key

## Calling the API
Set the values in D2LUserRequest

```swift
D2LManager.shared.builder = D2LUserRequest(
  appId: "myAppID", 
  appKey: "myAppKey", 
  userId: "myUserID",
  userKey: "myUserKey", 
  baseURL: "example.com")
```

Call the API
```swift
let courses = APIRoutes.Courses.courses.fetch()
```
