// android/settings.gradle.kts

pluginManagement {
    // Ambil lokasi Flutter SDK dari local.properties
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    // Gradle akan menemukan plugin Flutter dari sini
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    // Wajib: plugin loader Flutter
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"

    // Android Gradle Plugin (AGP) – versi baru yang cocok dengan core-ktx 1.17.0, dll
    id("com.android.application") version "8.9.1" apply false

    // Kotlin untuk Android (versi 2.x, sesuai rekomendasi Flutter terbaru)
    id("org.jetbrains.kotlin.android") version "2.0.0" apply false

    // Plugin Google Services untuk Firebase
    id("com.google.gms.google-services") version "4.4.2" apply false
}

include(":app")
