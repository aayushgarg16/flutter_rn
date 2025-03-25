import React, { useState } from 'react';
import { View, ScrollView, StyleSheet, Text, TextInput, Button } from 'react-native';
import { useDispatch, useSelector } from 'react-redux';
import { StackScreenProps } from '@react-navigation/stack';
import { useNavigation } from '@react-navigation/native';
import { setUserInput } from '../Store';

// Define navigation stack params
type RootStackParamList = {
  Home: undefined;
  Details: undefined;
};

type HomeScreenProps = StackScreenProps<RootStackParamList, 'Home'>;

const HomeScreen: React.FC = ({ navigation }: HomeScreenProps) => {
  const [inputText, setInputText] = useState('');
  const dispatch = useDispatch();
//   const navigation = useNavigation<HomeScreenProps>();

  const handleSaveAndNavigate = () => {
    dispatch(setUserInput(inputText));
    navigation.navigate('Details');
  };

  return (
    <ScrollView style={styles.container}>
      <TextInput
        placeholder="Enter something to save in Redux"
        style={styles.input}
        value={inputText}
        onChangeText={setInputText}
      />

      <Button title="Save and Go to Details" onPress={handleSaveAndNavigate} />
    </ScrollView>
  );
};

const styles = StyleSheet.create({
    container: {
      padding: 16,
      backgroundColor: '#fff',
    },
    input: {
      backgroundColor: '#f0f0f0',
      padding: 12,
      borderRadius: 12,
      marginBottom: 16,
    },
  });

export default HomeScreen;


// // HomeScreen.tsx
// import React from 'react';
// import { View, Text, Button } from 'react-native';
// import { useSelector, useDispatch } from 'react-redux';
// import { StackScreenProps } from '@react-navigation/stack';
// import { increment, RootState } from '../Store';

// export type RootStackParamList = {
//   Home: undefined;
//   Details: undefined;
// };

// type HomeScreenProps = StackScreenProps<RootStackParamList, 'Home'>;

// export default function HomeScreen({ navigation }: HomeScreenProps) {
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
