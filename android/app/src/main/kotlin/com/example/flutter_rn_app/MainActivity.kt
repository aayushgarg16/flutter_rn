package com.example.flutter_rn_app

import android.app.Activity
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
import com.facebook.soloader.SoLoader


// Extension function to extract FlutterActivity from any Context
fun Context.getFlutterActivity(): FlutterActivity {
  var ctx = this
  while (ctx is ContextWrapper) {
    if (ctx is FlutterActivity) return ctx
    ctx = ctx.baseContext
  }
  throw IllegalStateException("FlutterActivity not found in context hierarchy.")
}

// Singleton to hold and preload the ReactInstanceManager
object RNInstanceManagerHolder {
  private var instance: ReactInstanceManager? = null

  fun getInstance(context: Context): ReactInstanceManager {
    if (instance == null) {
      // Get the FlutterActivity from the context
      val activity = context.getFlutterActivity()
      instance = ReactInstanceManager.builder()
        .setApplication(activity.application)
        .setCurrentActivity(activity)
        .setBundleAssetName("index.android.bundle")
        .setJSMainModulePath("index")
        .addPackage(MainReactPackage())
        .setUseDeveloperSupport(true) // true for debugging; set to false in release
        .setInitialLifecycleState(LifecycleState.RESUMED)
        .build()
      // Preload the JS context in background to reduce startup delay.
      instance!!.createReactContextInBackground()
    }
    return instance!!
  }
}

class MainActivity : FlutterActivity() {
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    
    // Initialize SoLoader for React Native native libraries.
    SoLoader.init(this, false)
    
    // Preload the React Native instance so that when we show RN pages the delay is reduced.
    RNInstanceManagerHolder.getInstance(this)
    
    // Register a PlatformView for React Native screens.
    flutterEngine.platformViewsController.registry.registerViewFactory(
      "ReactNativeView",
      ReactNativeViewFactory(RNInstanceManagerHolder.getInstance(this))
    )
  }
}

class ReactNativeViewFactory(private val reactInstanceManager: ReactInstanceManager) : 
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  override fun create(context: Context, id: Int, args: Any?): PlatformView {
    return ReactNativePlatformView(context, reactInstanceManager)
  }
}

class ReactNativePlatformView(
    context: Context,
    reactInstanceManager: ReactInstanceManager
) : PlatformView {
  private val reactRootView: ReactRootView = ReactRootView(context)

  init {
    // Start the React Native application inside the ReactRootView.
    // "MyRNModule" must exactly match the name used in your RN registration:
    // AppRegistry.registerComponent('MyRNModule', () => YourApp);
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
