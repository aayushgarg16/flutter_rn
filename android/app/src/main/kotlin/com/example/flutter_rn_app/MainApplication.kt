package com.example.flutter_rn_app

import android.app.Application
import com.facebook.react.PackageList
import com.facebook.react.ReactInstanceManager
import com.facebook.react.ReactNativeHost
import com.facebook.react.ReactPackage
import com.facebook.soloader.SoLoader

class MainApplication : Application() {

    private val mReactNativeHost: ReactNativeHost = object : ReactNativeHost(this) {
        override fun getPackages(): List<ReactPackage> =
            PackageList(this@MainApplication).packages

        override fun getJSMainModuleName(): String = "index"
        override fun getUseDeveloperSupport(): Boolean = true
        override fun getBundleAssetName(): String = "index.android.bundle"
    }

    fun getReactNativeHost(): ReactNativeHost = mReactNativeHost

    override fun onCreate() {
        super.onCreate()
        SoLoader.init(this, /* native exopackage */ false)
        // Preload React Native JS context right away.
        mReactNativeHost.reactInstanceManager.createReactContextInBackground()
    }
}
