// App.js
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { Provider } from 'react-redux';
import store from './Store';
import KYC from './Containers/KYC';
import DetailsScreen from './Containers/Details';

const Stack = createStackNavigator();

export default function App() {
  return (
    <Provider store={store}>
      <NavigationContainer>
        <Stack.Navigator initialRouteName="KYC" id={undefined}>
          <Stack.Screen 
            name="KYC" 
            component={KYC} 
          />
          <Stack.Screen 
            name="Details" 
            component={DetailsScreen}
          />
        </Stack.Navigator>
      </NavigationContainer>
    </Provider>
  );
}
