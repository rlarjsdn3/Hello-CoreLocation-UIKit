package com.example.twice

import android.content.Intent
import android.os.Bundle
import android.widget.ImageView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val image1 = findViewById<ImageView>(R.id.member_1)
        val image2 = findViewById<ImageView>(R.id.member_2)
        val image3 = findViewById<ImageView>(R.id.member_3)
        val image4 = findViewById<ImageView>(R.id.member_4)
        val image5 = findViewById<ImageView>(R.id.member_5)
        val image6 = findViewById<ImageView>(R.id.member_6)
        val image7 = findViewById<ImageView>(R.id.member_7)
        val image8 = findViewById<ImageView>(R.id.member_8)
        val image9 = findViewById<ImageView>(R.id.member_9)

        image1.setOnClickListener {
            val intent = Intent(this, ImageActivity::class.java)
            intent.putExtra("data", "1")
            startActivity(intent)
        }
        image2.setOnClickListener {
            val intent = Intent(this, ImageActivity::class.java)
            intent.putExtra("data", "2")
            startActivity(intent)
        }
        image3.setOnClickListener {
            val intent = Intent(this, ImageActivity::class.java)
            intent.putExtra("data", "3")
            startActivity(intent)
        }
        image4.setOnClickListener {
            val intent = Intent(this, ImageActivity::class.java)
            intent.putExtra("data", "4")
            startActivity(intent)
        }
        image5.setOnClickListener {
            val intent = Intent(this, ImageActivity::class.java)
            intent.putExtra("data", "5")
            startActivity(intent)
        }
        image6.setOnClickListener {
            val intent = Intent(this, ImageActivity::class.java)
            intent.putExtra("data", "6")
            startActivity(intent)
        }
        image7.setOnClickListener {
            val intent = Intent(this, ImageActivity::class.java)
            intent.putExtra("data", "7")
            startActivity(intent)
        }
        image8.setOnClickListener {
            val intent = Intent(this, ImageActivity::class.java)
            intent.putExtra("data", "8")
            startActivity(intent)
        }
        image9.setOnClickListener {
            val intent = Intent(this, ImageActivity::class.java)
            intent.putExtra("data", "9")
            startActivity(intent)
        }
    }
}