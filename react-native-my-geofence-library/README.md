# react-native-my-geofence-library

## Getting started

`$ npm install react-native-my-geofence-library --save`

### Mostly automatic installation

`$ react-native link react-native-my-geofence-library`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-my-geofence-library` and add `MyGeofenceLibrary.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libMyGeofenceLibrary.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.reactlibrary.MyGeofenceLibraryPackage;` to the imports at the top of the file
  - Add `new MyGeofenceLibraryPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-my-geofence-library'
  	project(':react-native-my-geofence-library').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-my-geofence-library/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-my-geofence-library')
  	```


## Usage
```javascript
import MyGeofenceLibrary from 'react-native-my-geofence-library';

// TODO: What to do with the module?
MyGeofenceLibrary;
```
