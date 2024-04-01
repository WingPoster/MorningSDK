package com.morningsoft.morningsdksample

//
//  SplashActivity.kt
//  MorningSDKSample
//
//  Created by Kyojun.Kim on 18/07/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import android.annotation.SuppressLint
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.ImageView
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import com.bumptech.glide.Glide
import com.bumptech.glide.load.engine.DiskCacheStrategy
import java.util.*
import kotlin.concurrent.timerTask

@SuppressLint("CustomSplashScreen")
class SplashActivity : AppCompatActivity() {
    private lateinit var setupMain: ActivityResultLauncher<Intent>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        val imgGif : ImageView = findViewById<View>(R.id.img_gif) as ImageView
        Glide.with( this )
                .asGif()
                .load(R.raw.loading)
                .diskCacheStrategy( DiskCacheStrategy.RESOURCE )
                .into( imgGif )

        val timer = Timer()
        timer.schedule(timerTask
        {
            setupMain()
        }, 4000)

        setupMain = registerForActivityResult(
            ActivityResultContracts.StartActivityForResult()) { result ->
            if (result.resultCode == RESULT_OK) {
                Log.d(LOG_TAG, "MAIN_SETUP_SUCCESS")
            }
        }
    }

    private fun setupMain(){
        val mIntent = Intent(this@SplashActivity, MainActivity::class.java)
        mIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        setupMain.launch(mIntent)
        finish()
    }
    companion object {
        private val LOG_TAG = SplashActivity::class.java.simpleName
    }
}
