 # React Native Android Configuration Guide

This guide outlines steps to configure React Native (RN) packages for Android, resolve module visibility issues, and run the application.

---

## 🛠️ Build Configuration

### 1. Update `build.gradle`
Ensure Java 17 compatibility in **all RN package** `build.gradle` files:

```groovy
android {
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }
    
    kotlinOptions {
        jvmTarget = "17"
    }
}
```

### 2. Kotlin Visibility Fixes
Remove `internal` modifiers from classes in third-party packages (e.g., `react-native-safe-area-context`):

1. Find affected files:
   ```bash
   grep -r 'internal class' node_modules/react-native-safe-area-context/android/src/
   ```

2. Modify classes like:
   - `InsetsChangeEvent`
   - `Insets`
   - `InsetsChangeEventEmitter`

**Before:**
```kotlin
internal class InsetsChangeEvent(...)
```

**After:**
```kotlin
class InsetsChangeEvent(...)  // Remove 'internal' modifier
```

---

## 🚀 Run the Application

### Switch to Application Build
1. **Uncomment** in your Android project:
   - `MainApplication.java`
   - `MainActivity.java`
   - `AndroidManifest.xml`

2. Update `android/app/build.gradle`:
   ```groovy
   // Before
   apply plugin: "com.android.library"
   
   // After
   apply plugin: "com.android.application"
   ```

3. Run the app:
   ```bash
   npx react-native run-android
   ```

---

## 🔄 React Native Reanimated Setup

### Modify `ReanimatedPackage.java`
```java
package com.swmansion.reanimated;

// ... [Other imports]

@ReactModuleList(nativeModules = {ReanimatedModule.class, ReanimatedUIManager.class})
public class ReanimatedPackage extends TurboReactPackage implements ReactPackage {
    private static ReactInstanceManager reactInstanceManager;

    // Set from MainActivity during React Native initialization
    public static void setReactInstanceManager(ReactInstanceManager instance) {
        reactInstanceManager = instance;
    }

    // 💡 Critical fix for UIManager access
    private UIManagerModule createUIManager(final ReactApplicationContext reactContext) {
        ReactMarker.logMarker(CREATE_UI_MANAGER_MODULE_START);
        Systrace.beginSection(Systrace.TRACE_TAG_REACT_JAVA_BRIDGE, "createUIManagerModule");

        try {
            List<ViewManager> viewManagers = getReactInstanceManager()
                .getOrCreateViewManagers(reactContext);
            return ReanimatedUIManagerFactory.create(reactContext, viewManagers, -1);
        } finally {
            Systrace.endSection(Systrace.TRACE_TAG_REACT_JAVA_BRIDGE);
            ReactMarker.logMarker(CREATE_UI_MANAGER_MODULE_END);
        }
    }

    private ReactInstanceManager getReactInstanceManager() {
        if (reactInstanceManager == null) {
            throw new IllegalStateException("ReactInstanceManager not set!");
        }
        return reactInstanceManager;
    }
}
```

---

## 📂 Source Code Management

### Copy RN Package Sources
Copy files from `node_modules` to your app’s module:
```
android/app/src/main/java/com/
```

**Why?**  
This ensures classes from packages like `react-native-safe-area-context` are accessible in your app’s `:app` module.

---

## ⚠️ Critical Notes

1. **Java 17 Requirement**
   - Install JDK 17
   - Set `JAVA_HOME` in your environment variables

2. **Version Compatibility**
   ```json
   "dependencies": {
     "react": "^18.2.0",
     "react-native": "^0.73.0",
     "react-native-reanimated": "^3.6.0",
     "react-native-safe-area-context": "^4.7.0"
   }
   ```

3. **Temporary Fix Warning**  
   Modifying `node_modules` directly is **not persistent**. For production:
   - Use [`patch-package`](https://www.npmjs.com/package/patch-package)
   - Fork and patch the original repositories

4. **Clean Builds**  
   After configuration changes:
   ```bash
   cd android && ./gradlew clean && cd ..
   ```