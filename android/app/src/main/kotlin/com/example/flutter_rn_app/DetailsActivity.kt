package com.example.flutter_rn_app

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class DetailsActivity : AppCompatActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    val customText = intent.getStringExtra("data") ?: "No data passed"
    val textView = TextView(this).apply {
      textSize = 24f
      text = "Native Kotlin Screen:\n$customText"
    }
    setContentView(textView)
  }
}