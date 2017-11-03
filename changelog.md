# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](	)

## - 2017-11-03 - Stephen Cheng
### Added
- Raycasting algorithm

## - 2017-10-29 - Yudhvir Raj
- Added help me button
- Added demo functionality to button, displaying alert

## - 2017-10-29 - Yudhvir Raj
- Added Directions feature to app, making use of the right accessory callout button

## - 2017-10-28 - Brayden Traas
- Fixed Location permissions bug
- Centralized location permissions for better user feedback

## - 2017-10-28 - Brayden Traas
- Added PreventanylAnnotation protocol to make it easy for multiple annotation types & images
- Added dummy overdose

## - 2017-10-28 - Brayden Traas
- Updated local Statickit class to include City
- Made a map of map markers (lol) to map static kit id => marker. 
    - Adds/Removes with the Change listener, but doesn't update location on update (because it's static & a constant Marker object). If we really want this functionality, we can make them some other Annotation type other than Marker.


## - 2017-10-28 - Kent Huang
- Added local Statickit class
-Added FireBase StaticKits-Change listener in FirstViewController
- Fetched and Stored the FireBaseDatabase's StaticKits in an array of Statickit type

## -2017-10-27 - Brayden Traas
- Added in-app, background, and OS-triggered location tracking switched by a switch.
- Fixed Profile image
- Removed unnecessary tab items
- Minor styling and map updates

## - 2017-10-17 - Kent Huang
- Moved the profile tab into a separate folder
- Implemented the basic profile tab navgation(segue)
## - 2017-09-30 - Yudhvir, Stephen
- Zoom on user position on Launch, implemented location manager in app delegate using stephen's git repo

## 8b3121ac810fbcef7e433a35cc6bd63cd86a68c7 - 2017-09-30 - Yudhvir
- Fixed SigAbrt Error caused by not finding Google Services Plist file, simply changed the membership

## ff7c99d1db0649fb5d8736e721e546f5246442e1 - 2017-09-30 - Yudhvir
- Initiliased pod and created podfile
- Added firebase to pods and project

## 96bc4346faf5cfe7c3e87cdba0a31da248221d2d - 2017-09-29 - Brayden
- Added login buttons, testing UI etc

## 96bc4346faf5cfe7c3e87cdba0a31da248221d2d 
## [0.0.1] - 2017-09-29 - Yudhvir
- Added Marker class swift file (delegate), and able to zoom and make pin on launch on map 

## 96bc4346faf5cfe7c3e87cdba0a31da248221d2d - 2017-09-28 - Yudhvir
### Added
- Added multiple new scenes for tab layout
- Added MapKit to Storyboard Page One and change deployment target to iOS 9.2
- Initialized project


## 97bc4346faf5cfe7c3e87cdba0a31da248221d2d - 2017-09-28 - Stephen
### Added
- Changelog
