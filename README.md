# College Carpool 

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Uber made for college students where students with cars post when and where they are going so that other students can join along

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Travel
- **Mobile:** Requires mobile phone for best experience
- **Story:** Save money for students who do not have a car
- **Market:** College students
- **Habit:** As transportation needs require
- **Scope:** The required stories have similar functionality as the twitter assignment. If we have time, we could add additional features like maps.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] User can create an account
- [X] User can log in
- [ ] User can post a message saying when, where and cost of ride
- [X] User can respond to a posted message

**Optional Nice-to-have Stories**

- [ ] User can pay for the ride through the app
- [ ] User can view and interact with a map


### 2. Screen Archetypes

* log in screen
   * user can log in
   * user can create a new account
* Choose a ride
   * User can see available rides
   * User can choose which ride they want
* Publish a ride
    * User can post a ride so that other users see their message
* Request a ride
    * User can request a ride that other users may be able to provide

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Log in/sigh up screen
* Choose a ride
* Publish a ride
* Request a ride

**Flow Navigation** (Screen to Screen)

* Log in/sign up screen
   * Need a ride
   * Publish a ride
* Need a ride
   * Choose a ride
   * Request a ride

## Wireframes

<img src="https://i.ibb.co/ckXrbSq/wireframe.jpg" width=600>

## Schema 
[This section will be completed in Unit 9]
### Models



| Property | Type     |Description                     |
| -------- | -------- | --------                       |
| **User** class|
| userId   | String   | Unique ID for every user       | 
| carModel | String   | the car the user will drive for offered rides                       |
| Image     | File     | Image of driver       |
| **RideOffers** and **RideRequests** classes|
| cost | Number   | amount willing to pay / wanted for a ride                       |
| time | DateTime   | time the desired or offered ride will depart                       |
| destination | String   | the desired or offered destination of a ride                       |
| author     | Pointer to user     | Post author       |
| createdAt     | DateTime     | Date when post is created (default field)|
| updatedAt     | DateTime     | Date when post is updated (default field)|
|**RideOffers** class|
| numberOfAvailableSeats     | Number     | How many more people can join the ride|
| rideReservers	| Arrray<PFUser>	| an array of the users who reserved a ride |
| numSeatsTaken	| Array<Int>	| number of seats each user reserved (corresponds to rideReservers array) |
|**RideRequests** class|
| numberOfRequestedSeats     | Number     | How many people need the ride|

### Networking
* Provide a ride screen
    * (Read/GET) Query all posts
    * (Delete) Delete post if correct currentUser posted it
* Publish a ride screen
    * (Create/POST) create a new ride
* Need a ride screen
    * (Read/GET) choice of choose ride screen/ request a ride screen
* Choose a ride screen
    * (Read/GET) Query all posts
    * (Delete) Delete post if correct currentUser posted it
* Request a ride screen
    * (Create/POST) make a new ride request
* Destination screen
    * (Create/POST) chooses a point on map

### Progress

<img src="sprint2.gif"/>
