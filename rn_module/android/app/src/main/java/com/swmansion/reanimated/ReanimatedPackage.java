package com.swmansion.reanimated;

import static com.facebook.react.bridge.ReactMarkerConstants.CREATE_UI_MANAGER_MODULE_END;
import static com.facebook.react.bridge.ReactMarkerConstants.CREATE_UI_MANAGER_MODULE_START;

import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactPackage;
import com.facebook.react.TurboReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMarker;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.module.annotations.ReactModuleList;
import com.facebook.react.module.model.ReactModuleInfo;
import com.facebook.react.module.model.ReactModuleInfoProvider;
import com.facebook.react.uimanager.ReanimatedUIManager;
import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.ViewManager;
import com.facebook.systrace.Systrace;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ReactModuleList(
    nativeModules = {
      ReanimatedModule.class,
      ReanimatedUIManager.class,
    })
public class ReanimatedPackage extends TurboReactPackage implements ReactPackage {

  // 💡 Static instance to be set from outside (in MainActivity or wherever RN is bootstrapped)
  private static ReactInstanceManager reactInstanceManager;

  public static void setReactInstanceManager(ReactInstanceManager instance) {
    reactInstanceManager = instance;
  }

  @Override
  public NativeModule getModule(String name, ReactApplicationContext reactContext) {
    if (name.equals(ReanimatedModule.NAME)) {
      return new ReanimatedModule(reactContext);
    }
    if (name.equals(ReanimatedUIManager.NAME)) {
      return createUIManager(reactContext);
    }
    return null;
  }

  @Override
  public ReactModuleInfoProvider getReactModuleInfoProvider() {
    Class<? extends NativeModule>[] moduleList =
        new Class[] {
          ReanimatedModule.class, ReanimatedUIManager.class,
        };

    final Map<String, ReactModuleInfo> reactModuleInfoMap = new HashMap<>();
    for (Class<? extends NativeModule> moduleClass : moduleList) {
      ReactModule reactModule = moduleClass.getAnnotation(ReactModule.class);

      reactModuleInfoMap.put(
          reactModule.name(),
          new ReactModuleInfo(
              reactModule.name(),
              moduleClass.getName(),
              true,
              reactModule.needsEagerInit(),
              reactModule.hasConstants(),
              reactModule.isCxxModule(),
              BuildConfig.IS_NEW_ARCHITECTURE_ENABLED));
    }

    return () -> reactModuleInfoMap;
  }

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
      throw new IllegalStateException(
          "ReactInstanceManager not set. Call ReanimatedPackage.setReactInstanceManager(...) first.");
    }
    return reactInstanceManager;
  }
}