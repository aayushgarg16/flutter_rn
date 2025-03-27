// App.js
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { Provider } from 'react-redux';
import store from './Store';
import KYC from './Containers/KYC';
import DetailsScreen from './Containers/Details';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'react-native';

const Stack = createStackNavigator();

export default function App(props?: { screen: string, name: string, userId: string }) {
    const screenParams = props || {};
    console.log('props in App', props);
    
    return (
        <Provider store={store}>
            <SafeAreaView
                style={{
                    flex: 1,
                    backgroundColor: '#000000'
                }}>
                <StatusBar backgroundColor={'#000'} barStyle="light-content" />
                <NavigationContainer>
                    <Stack.Navigator initialRouteName="KYC" id={undefined} screenOptions={{ headerShown: false }}>
                        <Stack.Screen
                            name="KYC"
                            component={KYC}
                            initialParams={screenParams}
                        />
                        <Stack.Screen
                            name="Details"
                            component={DetailsScreen}
                        />
                    </Stack.Navigator>
                </NavigationContainer>
            </SafeAreaView>
        </Provider>
    );
}
