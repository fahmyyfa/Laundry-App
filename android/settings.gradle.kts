// android/settings.gradle.kts

pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }

    // ⭐ Penting: supaya Gradle bisa menemukan plugin Flutter
    includeBuild("../..")
}

plugins {
    // ⭐ Plugin loader Flutter (wajib, biarkan seperti ini)
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"

    // Plugin Android & Kotlin (versi bisa sedikit berbeda, tapi aman)
    id("com.android.application") version "8.2.1" apply false
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false

    // ⭐ Plugin Google Services untuk Firebase (apply false di sini)
    id("com.google.gms.google-services") version "4.4.2" apply false
}

include(":app")
