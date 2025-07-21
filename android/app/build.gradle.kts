plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

flutter {
    source = "../.."
}

android {
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "26.3.11579264" // ✅ Aapka installed NDK version

    namespace = "com.example.disease_tracker_app"

    defaultConfig {
        applicationId = "com.example.disease_tracker_app"
        minSdk = 21
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
}
dependencies {
    implementation("com.google.android.gms:play-services-auth:20.7.0") // ✅ Correct Kotlin DSL
}

