// android/app/build.gradle.kts

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")

    // Plugin Flutter
    id("dev.flutter.flutter-gradle-plugin")

    // Plugin Firebase Google Services
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.joyspin_laundry"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.joyspin_laundry"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"

        multiDexEnabled = true
    }

    buildTypes {
        debug {
            isMinifyEnabled = false
        }
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}

dependencies {
    // ⭐ Firebase Messaging (Push Notifications)
    implementation("com.google.firebase:firebase-messaging-ktx:23.4.1")

    // ⭐ Firebase Core
    implementation("com.google.firebase:firebase-analytics-ktx")

    // Fix multidex
    implementation("androidx.multidex:multidex:2.0.1")
}

// ⭐ Required: Apply Google Services to load google-services.json
apply(plugin = "com.google.gms.google-services")
