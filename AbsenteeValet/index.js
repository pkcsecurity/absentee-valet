/**
 * @format
 */

import { AppRegistry, NativeModules } from 'react-native';
import App from './App';
import { name as appName } from './app.json';

const Geofence = NativeModules.Geofence;
Geofence.setup();
AppRegistry.registerComponent(appName, () => App);
