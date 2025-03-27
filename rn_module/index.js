/**
 * @format
 */

import 'react-native-gesture-handler';
import {AppRegistry} from 'react-native';
import App from './App/App';
import {name as appName} from './app.json';
import { GestureHandlerRootView } from 'react-native-gesture-handler';

const Root = (props) => (
    <GestureHandlerRootView style={{ flex: 1 }}>
        <App {...props} />
    </GestureHandlerRootView>
);

AppRegistry.registerComponent('MyRNModule', () => Root);
