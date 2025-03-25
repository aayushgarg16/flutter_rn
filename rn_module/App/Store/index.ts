// store.ts
import { configureStore, createSlice } from '@reduxjs/toolkit';

export interface CounterState {
  value: number;
  input: string;
}

const initialState: CounterState = { value: 0, input: '' };

const counterSlice = createSlice({
  name: 'counter',
  initialState,
  reducers: {
    increment: (state) => { state.value++; },
    decrement: (state) => { state.value--; },
    setUserInput: (state, action) => { state.input = action.payload; },
    reset: (state) => { state.value = 0; },
  },
});

export const { increment, decrement, setUserInput, reset } = counterSlice.actions;

const store = configureStore({
  reducer: {
    counter: counterSlice.reducer,
  },
});

// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

export default store;
