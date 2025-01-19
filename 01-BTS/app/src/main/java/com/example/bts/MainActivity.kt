package com.example.bts

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.ImageView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MainActivity : AppCompatActivity() {

    @SuppressLint("MissingInflatedId")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val image1 = findViewById<ImageView>(R.id.image_1)
        val image2 = findViewById<ImageView>(R.id.image_2)
        val image3 = findViewById<ImageView>(R.id.image_3)
        val image4 = findViewById<ImageView>(R.id.image_4)
        val image5 = findViewById<ImageView>(R.id.image_5)
        val image6 = findViewById<ImageView>(R.id.image_6)
        val image7 = findViewById<ImageView>(R.id.image_7)

        image1.setOnClickListener {
            showToast("1번 클릭 완료")
            startActivty(this, BTS1Activity::class.java)
        }

        image2.setOnClickListener {
            showToast("2번 클릭 완료")
            startActivty(this, BTS2Activity::class.java)
        }

        image3.setOnClickListener {
            showToast("3번 클릭 완료")
            startActivty(this, BTS3Activity::class.java)
        }

        image4.setOnClickListener {
            showToast("4번 클릭 완료")
            startActivty(this, BTS4Activity::class.java)
        }

        image5.setOnClickListener {
            showToast("5번 클릭 완료")
            startActivty(this, BTS5Activity::class.java)
        }

        image6.setOnClickListener {
            showToast("6번 클릭 완료")
            startActivty(this, BTS6Activity::class.java)
        }

        image7.setOnClickListener {
            showToast("7번 클릭 완료")
            startActivty(this, BTS7Activity::class.java)

        }
    }

    private fun startActivty(packageContext: Context, cls: Class<*>): Unit {
        val intent = Intent(packageContext, cls)
        startActivity(intent)
    }

    private fun showToast(text: String): Unit {
        Toast.makeText(this, text, Toast.LENGTH_SHORT).show()
    }
}