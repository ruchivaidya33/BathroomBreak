Group Project
===

# Bathroom Break

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Yelp for public restrooms in NYC

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Utility
- **Mobile:** iOS
- **Story:** Developed to facilitate everyday life.
- **Market:** Everyone in NYC
- **Habit:** N/A
- **Scope:** Anywhere supported by our map API.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] Users can create an account
- [X] Users can login and logout



<img src='http://g.recordit.co/LtknFMVkPS.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />



- [ ] Users can stay logged in
- [ ]  Users can set their current location
- [ ]  Users will be shown closest public restrooms based on their current location
- [ ]  Users have a profile that shows their previous ratings
- [ ]  Users add new locations and can rate existing entries based on their experience at the restroom out of 5 stars, disability accessibility, purchase needed to use?, toilet paper ply, hand dryers, etc.
- [ ]  Ability to add and delete reviews



**Optional Nice-to-have Stories**

* TBD


### 2. Screen Archetypes

* Sign up screen
    * Users can sign up
* Login
   * Users can log in
   * Users can create an account
* Map View
   * Users can set their current location
   * Users will be shown closest public restrooms based on their current location
* New Bathroom
    * Users can add a new bathroom location into the database
* Edit Bathroom
    * Users can update the bathroom listing
* New Bathroom Rating
    * Users can submit a rating for the bathroom and add photos to it
* Bathroom List View
    * Users can see a list of results based on the search location
* Bathroom Details
    * Users can view additional details, ratings and photos of the bathroom
* Settings
    * User defaults
* Profile
    * Users can see a list of their past ratings

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Profile
* Map
* Settings

**Flow Navigation** (Screen to Screen)
* Sign up
    * Map View
* Login
    * Sign up
    * Map View
* Mapview
   * Bathroom List View
   * Bathroom Details
   * New Bathroom
* New Bathroom
    * Bathroom Details
    * Map View
* Edit Bathroom
    * Bathroom Details
* New Bathroom Rating
    * Bathroom Details
* Bathroom List View
    * Bathroom Details
    * Map View
* Bathroom Details
    * Map View
    * Bathroom List View
    * New Bathroom Rating
* Settings
* Profile
    * Login

## Wireframes

<img src="https://i.imgur.com/vVtNbTl.jpg" width=600>

## Schema 

### Models


#### User
| Property | Type | Description |
| -------- | -------- | -------- |
| userID | Int     | unique identifier   |
| username     | string     | username to log in     |
| password     | string     | password to secure log in     |
| profilePic     | File     | profile picture     |
| email     | string     | user's email     |
| createdAt     | datetime     | time in which user was created     |
|lastUpdated| datetime | time in which the user was last edited |

#### Bathroom
|Property | Type | Description |
| -------- | -------- | -------- |
| bathroomID     | Int     | unique identifier     |
| address     | string     | location of bathroom   |
| addressLat   | string    | latitude of bathroom address|
| addressLong   | string    | longitude of bathroom address| 
| name | string | name of the bathroom location |
|image | File|image of the bathroom |
|overallRating | float |overall rating of the bathroom from 1-5|
|cleanRating | float |cleanliness rating of the bathroom from 1-5|
|handicapAccess | boolean | if there is handicap access|
|unisex|boolean | whether bathroom is unisex|
|multistalled |boolean | whether the bathroom has more than 1 toilet |
|handryer|boolean |has a handryer|
|public |boolean | whether the bathroom is public or privately owned|
|needPurchase | boolean | whether a purchase is necessary to use the bathroom |
|createdBy | Pointer to User| ID of the user that created the listing |
|createdAt | datetime | time in which the bathroom listing was created |
|lastUpdated | datetime | time in which the bathroom listing was last edited |
|updatedBy| Pointer to User | user who last edited the post |



#### Review
|Property | Type | Description |
| -------- | -------- | -------- |
| reviewID | Int | unique identifier of the review |
|image | File|image of the bathroom |
|userID | Pointer to User|ID of the User that created the review|
|bathroomID | Pointer to Bathroom | ID of the bathroom tied to the review|
| experienceRating | float | experience rating for particular review from 1-5|
|cleanRating | float |cleanliness rating of the bathroom from 1-5|
|createdAt| datetime| when review was made|
|description| string| actual review|


### Networking
* Sign up screen
    * (Create/POST) Create a new user in database
* Login
    * (Read/GET) Query to see if user exists in database
* Map View
    * (Read/GET) Get users location
    * (Read/GET) Query for nearby bathroom locations
* New Bathroom
    * (Create/POST) Create a new bathroom listing in database
* Edit Bathroom
    * (Update/PUT) Update bathroom listing
* New Bathroom Rating
    * (Create/POST) Create a rating for an existing bathroom in database
* Bathroom List View
    * (Read/GET) Query for bathroom listings
* Bathroom Details
    * (Read/GET) Query for reviews of particular bathroom
    * (Read/GET) Query for details of current bathroom
* Settings
    * N/A settings saved to NSDefaults
* Profile
    * (Update/PUT) Update user profile
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
