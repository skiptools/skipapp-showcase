package showcase.module

import skip.ui.*
import skip.foundation.*

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class NotificationReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        
        val title = intent.getStringExtra("title") ?: ""
        val body = intent.getStringExtra("body") ?: ""
        
        val content = UNNotificationContent(title = title, body = body)
        val request = UNNotificationRequest(identifier = UUID().uuidString, content = content)
        
        val pendingResult = goAsync()
        val scope = CoroutineScope(Dispatchers.Main)
        scope.launch {
            try {
                UNUserNotificationCenter.current().add(request)
            } catch (e: Exception) {
                e.printStackTrace()
            } finally {
                pendingResult.finish()
            }
        }
    }
}
