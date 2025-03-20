package com.example.flutter_rn_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import android.content.Context
import android.content.ContextWrapper
import android.view.View
import com.facebook.react.ReactInstanceManager
import com.facebook.react.ReactRootView
import com.facebook.react.common.LifecycleState
import com.facebook.react.shell.MainReactPackage

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("ReactNativeView", ReactNativeViewFactory())
    }
}

class ReactNativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        return ReactNativePlatformView(context)
    }
}

class ReactNativePlatformView(context: Context) : PlatformView {
    private val reactRootView: ReactRootView = ReactRootView(context)

    val activity = (context as ContextWrapper).baseContext as FlutterActivity

    init {
        val reactInstanceManager = ReactInstanceManager.builder()
            .setApplication(activity.application)
            .setCurrentActivity(activity)
            .setBundleAssetName("index.android.bundle")
            .setJSMainModulePath("index")
            .addPackage(MainReactPackage())
            .setUseDeveloperSupport(false)
            .setInitialLifecycleState(LifecycleState.RESUMED)
            .build()

        reactRootView.startReactApplication(
            reactInstanceManager,
            "MyRNModule",
            null
        )
    }

    override fun getView(): View = reactRootView

    override fun dispose() {
        reactRootView.unmountReactApplication()
    }
}
