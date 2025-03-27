package com.example.flutter_rn_app

import android.content.Intent
import com.facebook.react.bridge.*
import com.example.flutter_rn_app.DetailsActivity

class DetailsModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    override fun getName() = "DetailsModule"

    @ReactMethod
    fun openDetailsPage(data: String) {
        val intent = Intent(reactContext, DetailsActivity::class.java)
        intent.putExtra("data", data)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        reactContext.startActivity(intent)
    }
}
