// android/app/build.gradle.kts

plugins {
    id("com.android.application")
    // Plugin Google Services untuk Firebase
    id("com.google.gms.google-services")
    id("org.jetbrains.kotlin.android")
    // Plugin Flutter (harus terakhir)
    id("dev.flutter.flutter-gradle-plugin")
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
        // 🔹 Debug build: tidak perlu shrink / proguard
        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
        }

        // 🔹 Release build: shrink + minify keduanya ON (supaya AGP tidak protes)
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
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
    // Firebase Messaging (push notification)
    implementation("com.google.firebase:firebase-messaging-ktx:23.4.1")
    // Firebase Analytics (opsional, tapi aman)
    implementation("com.google.firebase:firebase-analytics-ktx")

    // Multidex untuk keamanan
    implementation("androidx.multidex:multidex:2.0.1")
}
