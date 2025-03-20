plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.flutter_rn_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.flutter_rn_app"
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // Ensure native libraries are extracted properly
    packagingOptions {
        jniLibs {
            useLegacyPackaging = true
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.appcompat:appcompat:1.6.1")
        // Explicit RN dependencies:
    implementation("com.facebook.react:react-android:0.74.3")
    implementation("com.facebook.react:hermes-android:0.74.3")
    implementation(fileTree("libs") { include("*.aar") })

    // React Native Android dependencies from Maven Central (essential)
    // implementation("com.facebook.react:react-android:+")
    // implementation("com.facebook.react:hermes-android:+")
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}