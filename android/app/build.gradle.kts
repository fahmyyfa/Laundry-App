// android/app/build.gradle.kts

plugins {
    id("com.android.application")
    // Plugin Google Services (wajib untuk google-services.json / Firebase)
    id("com.google.gms.google-services")
    id("org.jetbrains.kotlin.android")
    // Plugin Flutter (harus terakhir)
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.joyspin_laundry"

    // Kompilasi pakai Android SDK 36 (sesuai requirement plugin-plugin baru)
    compileSdk = 36

    defaultConfig {
        applicationId = "com.example.joyspin_laundry"
        minSdk = flutter.minSdkVersion       // bisa dinaikkan jika nanti ada plugin yang butuh lebih tinggi
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"

        multiDexEnabled = true
    }

    buildTypes {
        // Debug: tidak perlu shrink
        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
        }

        // Release: shrink + proguard diaktifkan agar tidak bentrok dengan AGP baru
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
        // Java 17 yang didukung Flutter & AGP 8.9.1
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17

        // Desugaring wajib untuk flutter_local_notifications
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}

dependencies {
    // Desugaring (syarat dari flutter_local_notifications)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")

    // Firebase Messaging & Analytics
    implementation("com.google.firebase:firebase-messaging-ktx:23.4.1")
    implementation("com.google.firebase:firebase-analytics-ktx")

    // Multidex (jaga-jaga jika method count besar)
    implementation("androidx.multidex:multidex:2.0.1")
}
