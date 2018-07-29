# Playarena android application

## Problem Statement & Scope Statement

###  Problem statement
The popular polish football league Playarena has no good support in form of mobile applications.

The current website is outdated and not easy to use on mobile devices.

We have built an application that tries to tackle this problem by creating a clear interface for players to see and be able to see football games, results and teams through their mobile devices.

Our goal is to provide Playarena users with an alternative source of information that scales well on non-desktop devices.

## Overall Description

### 2.1 Product Perspective

The current version of our application supports a number of chosen cities in Playarena including all their leagues, teams and players. The system can easily be extended to encompass further cities. Some of the features include viewing past games, seeing team members and live league standings as well as a simple predictor of future matches. An interesting extension to the project would be adding a pitch-trailing system to monitor taken and free venues on a map.
What things you need to install the software and how to install them

### 2.2 Product Features

The product is aimed at football players who are more than willing to see their results when going to a game, may also want to have a look at their opponents’ lineups.

The features that are available to the user are:


* A player can see different leagues with teams and their standings and current points

* Can view other players belonging to different teams

* Can predict the match result based on past games

* Can see upcoming and most recent games
  
* View cities in which playarena has its leagues
   

### 2.3 Operating Environment
 
The application operates on the Android platform from as early as version 4.0 KitKat. 

## 3. System Features 

The application is developed in Android Studio, programmed with the Java language. It uses Jsoup to download data from the online Playarena servers. It then parses given data and presents it in a user-friendly interface. 

## 4. Source code composition

The java classes are divided into three main groups: Activities, Extractors and Data storage.
 
### Activities 
Activities are classes that extend the AppCompatActivity class. Each Activity corresponds to a single view within the working program. Activities make use of Bundles to pass each other information
The activity classes are as follows:

- CityChooserActivity
- LeagueActivity
- LeagueChooserActivity
- LeagueNextMatchesActivity
- LeagueTableActivity
- TeamActivity
- TeamLastMatchesActivity
- TeamSquadActivity

### Extractors
The extractor classes make calls to different websites within the playarena.pl domain and download data in form of HTML documents. The extractors make use of Downloader classes to download tables and images. Downloaders extend the Asynctask class which is used to retrieve information in a background processes without creating delays.
The extractor classes are:

- MatchesExtractor
- NextMatchesExtractor
- PlayersExtractor
- TeamExtractor
- TableDownloader
- ImageDownloader.


### Data storage
Data classes are used to abstract different forms of information that the application processes.
The data classes are:

- Player
- Team
- Match
- League.

## 4. Design patterns
The application does not make extensive use of design patterns due to the relatively small size of the project. However, here are highlighted some design patterns that could be useful in the future in case of futher development.

* Factory: we store various sorts of data in different configurations: Player, Team, Match, League. These are used in most classes on a regular basis so implementing a system for creating these classes based on their properties can make the project more explicit. In the factory, we define all our complex data types. Later in the code, instead of calling constructors for each single object, we call the factory object instead which is an interface provided for our data.

* Singleton: we know that we will only require a single downloader at a time to fetch our HTML tables with up-to-date information. Because of that, we can declare our Downloader class as static, so as not to unnecessarily duplicate  the class. Then, we can globally access the class method without creating additional instances of the Downloader.

* Bridge: the bridge design pattern can be used to separate the abstraction of our data (displaying on Android devices) from the actual implementation (project-defined data structures). The interface for our displaying classes is the AppCompatActivity interface provided for Android projects. These classes make use of our Implementors (in this case classes containing data) to discern the display from the implementation.

## Authors

* **Dominik Hawryluk** [renon](https://github.com/renonpl)

* **Artur Derechowski** [kartoniks](https://github.com/kartoniks)
