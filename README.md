Original App Design Project - README Template
===

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

* User can create an account
* User can log in
* User can post a message saying when, where and cost of ride
* User can respond to a posted message

**Optional Nice-to-have Stories**

* User can pay for the ride through the app
* User can view and interact with a map


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


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models



| Property | Type     |Description                     |
| -------- | -------- | --------                       |
| userId   | String   | Unique ID for every user       | 
| ridePost | String   | Describes where / when a ride is/type of car                       |
| requestPost| String     | Describe where / when a ride is needed            |
| Author     | Pointer to user     | Post author       |
| Image     | File     | Image of driver       |
| createdAt     | DateTime     | Date when post is created (default field)|
| updatedAt     | DateTime     | Date when post is updated (default field)|
| numberOfAvailableSeats     | Number     | How many more people can join the ride|
| numberOfSeatsRequested     | Number     | How many people need the ride|

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
