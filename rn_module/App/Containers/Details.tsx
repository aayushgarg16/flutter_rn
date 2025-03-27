// DetailsScreen.tsx
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { useSelector } from 'react-redux';
import { RootState } from '../Store';

const DetailsScreen = () => {
    const savedInput = useSelector((state: RootState) => state.counter.input);

    return (
        <View style={styles.detailsContainer}>
            <Text style={styles.label}>Saved Input from Reduxing:</Text>
            <Text style={styles.savedText}>{savedInput || 'Nothing saved yet.'}</Text>
        </View>
    );
}

const styles = StyleSheet.create({
    detailsContainer: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: '#fff',
      padding: 24,
    },
    label: {
      fontSize: 18,
      fontWeight: 'bold',
    },
    savedText: {
      fontSize: 16,
      marginTop: 12,
      color: 'green',
    },
});

export default DetailsScreen;