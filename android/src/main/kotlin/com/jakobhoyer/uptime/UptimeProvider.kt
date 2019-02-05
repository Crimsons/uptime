import android.os.SystemClock

object UptimeProvider {
    val uptime
        get() = SystemClock.elapsedRealtime()
}
