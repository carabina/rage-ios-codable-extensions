Rage codable extensions for iOS
=============================
[![Travis CI](https://api.travis-ci.org/gspd-mobi/rage-ios-codable-extensions.svg?branch=master)](https://travis-ci.org/gspd-mobi/rage-ios-codable-extensions)
[![Version](https://img.shields.io/cocoapods/v/RageCodableExtenstions.svg?style=flat)](https://cocoapods.org/pods/RageCodableExtenstions)
[![License](https://img.shields.io/cocoapods/l/RageCodableExtenstions.svg?style=flat)](LICENSE.txt)
[![Platform](https://img.shields.io/cocoapods/p/RageCodableExtenstions.svg?style=flat)](https://cocoapods.org/pods/RageCodableExtenstions)

## Assuming we have Codable object `GithubUser` ##
```swift
let user = GithubUser(name: "ArtemCherkasov")
```
## Request Body ##
```swift
request.withBody().bodyJson(user) // Adds body data to request as JSON string
```

## Stub ##
```swift
request.stub(user) // Adds stub data as JSON string
```

## Execution ##
### Sync ###
```swift
let userResult: Result<GithubUser, RageError> = request.executeObject() // Parse response from JSON string to GithubUser model
let usersResult: Result<[GithubUser], RageError> = request.executeArray() // Works for arrays too
```

### Async ###
Same for async request using `enqueue(_:)` functions
```swift
request.enqueueObject { (userResult: Result<GithubUser, RageError>) in
    // Handle result in main thread
}

request.enqueueArray { (usersResult: Result<[GithubUser], RageError>) in
    // Handle result in main thread
}
```

### RxSwift ###
```swift
let userObjectObservable: Observable<GithubUser, RageError> = request.executeObjectObservable() // Where GithubUser is Codable
let usersObjectObservable: Observable<[GithubUser], RageError> = request.executeArrayObservable() // Works for arrays too
```

### Create Multipart TypedObjects JSON data ###
TypedObject can be created from any Codable object using `Encodable.makeTypedObject()` function
```swift
let typedObject = user.makeTypedObject() // Creates typed object with mimeType application/json and Data of JSON string
```
## JSONDecoder and JSONEncoder ##
### JSONDecoder ###
You can customize codable serilization in  `execute()` and `enqueue()` functions with JSONDecoder object
```swift
let jsonDecoder = JSONDecoder()

let formatter = DateFormatter()
formatter.dateFormat = "dd.MM.YYYY"

jsonDecoder.dateDecodingStrategy = .formatted(formatter)
jsonDecoder.dataDecodingStrategy = .base64

let userResult: Result<GithubUser, RageError> = request.executeObject(decoder: jsonDecoder)
let usersResult: Result<[GithubUser], RageError> = request.executeArray(decoder: jsonDecoder)

request.enqueueObject(decoder: jsonDecoder) { (userResult: Result<GithubUser, RageError>) in
    // Handle result in main thread
}

request.enqueueArray(decoder: jsonDecoder) { (usersResult: Result<[GithubUser], RageError>) in
    // Handle result in main thread
}
```
### JSONEncoder ###
You can customize codable deserialization in `stub()` and `bodyJson()` functions with JSONEncoder object
```swift
let jsonEncoder = JSONEncoder()

let formatter = DateFormatter()
formatter.dateFormat = "dd.MM.YYYY"

jsonEncoder.dateEncodingStrategy = .formatted(formatter)
jsonEncoder.dataEncodingStrategy = .base64

request.withBody().bodyJson(user, encoder: jsonEncoder)
request.stub(user, encoder: jsonEncoder)
```
## Installation (CocoaPods) ##
Add this dependency to Podfile and `pod install`
```ruby
# Core subspec of RageCodableExtensions
pod 'RageCodableExtensions', '~> 0.2.0'
```
Or if you want to use RxSwift feature you should use these RageCodableExtensions subspec
```ruby
pod 'RageCodableExtensions/RxSwift', '~> 0.2.0'
```

License
-------
The MIT License (MIT)

Copyright (c) 2018 gspd.mobi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

