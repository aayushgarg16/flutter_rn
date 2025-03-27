import React, { useState } from 'react';
import { View, ScrollView, StyleSheet, Text, TextInput, Button, NativeModules } from 'react-native';
import { useDispatch, useSelector } from 'react-redux';
import { StackScreenProps } from '@react-navigation/stack';
import { setUserInput } from '../Store';

// Define navigation stack params
type RootStackParamList = {
    KYC: undefined;
    Details: undefined;
};

type KYCProps = StackScreenProps<RootStackParamList, 'KYC'>;

const KYC: React.FC = ({ navigation, route }: KYCProps) => {
    const initialParams: { name?: string, userId?: string, screen?: string } = route.params || {};
    const [inputText, setInputText] = useState('');
    const dispatch = useDispatch();
    const handleSaveAndNavigate = () => {
        dispatch(setUserInput(inputText));
        // navigation.navigate('Details');
        NativeModules.DetailsModule.openDetailsPage(inputText);
    };

    return (
        <ScrollView style={styles.container}>
            <Text style={{ color: 'white', fontSize: 18, fontWeight: 800, marginBottom: 16 }}>I Am KYC in React Native</Text>
            <TextInput
                placeholder="Enter something to save in Redux"
                autoFocus
                placeholderTextColor={'#fff'}
                style={styles.input}
                value={inputText}
                onChangeText={setInputText}
            />

            <Button color="green" title="Save and Go to Details" onPress={handleSaveAndNavigate} />
            <Text style={{ color: 'white', fontWeight: 600, fontSize: 16, marginTop: 16 }}>Data From Flutter</Text>
            <Text style={{ color: 'white' }}>{initialParams?.name || 'Name not able to fetch'}</Text>
            <Text style={{ color: 'white' }}>{initialParams?.userId || 'UserId not able to fetch'}</Text>
            <Text style={{ color: 'white' }}>{`Navigating from: ${initialParams?.screen}` || 'Screen not able to fetch'}</Text>
        </ScrollView>
    );
};

const styles = StyleSheet.create({
    container: {
        padding: 16,
        backgroundColor: '#000',
    },
    input: {
        backgroundColor: 'grey',
        padding: 12,
        borderRadius: 12,
        marginBottom: 16,
    },
});

export default KYC;


// // KYC.tsx
// import React from 'react';
// import { View, Text, Button } from 'react-native';
// import { useSelector, useDispatch } from 'react-redux';
// import { StackScreenProps } from '@react-navigation/stack';
// import { increment, RootState } from '../Store';

// export type RootStackParamList = {
//   Home: undefined;
//   Details: undefined;
// };

// type KYCProps = StackScreenProps<RootStackParamList, 'Home'>;

// export default function KYC({ navigation }: KYCProps) {
//   const value = useSelector((state: RootState) => state.counter.value);
//   const dispatch = useDispatch();

//   return (
//     <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
//       <Text style={{ fontSize: 20 }}>Home Screen</Text>
//       <Text style={{ marginVertical: 8 }}>Counter: {value}</Text>
//       <Button title="Increment" onPress={() => dispatch(increment())} />
//       <Button title="Go to Details" onPress={() => navigation.navigate('Details')} />
//     </View>
//   );
// }
