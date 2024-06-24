package com.example.task2
import android.os.Bundle
import android.app.AlarmManager
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestExactAlarmPermission()
    }
    private fun requestExactAlarmPermission() {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.S) {
            val alarmManager = getSystemService(AlarmManager::class.java)
            if (!alarmManager.canScheduleExactAlarms()) {
                ActivityCompat.requestPermissions(this, arrayOf("android.permission.SCHEDULE_EXACT_ALARM"), 0)
            }
        }
    }
}
