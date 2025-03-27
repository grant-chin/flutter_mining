plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    signingConfigs {
        create("keystore") {
            keyAlias = "key_mining"
            keyPassword = "112233"
            storeFile = file("key_mining.jks")
            storePassword = "112233"
        }
    }
    buildTypes {
        val signConfig = signingConfigs.getByName("keystore")
        getByName("release") {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rule.pro"
            )
            signingConfig = signConfig
        }
    }

    namespace = "com.SimuPool.SimuPool"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.SimuPool.SimuPool"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    android {
        ndkVersion = "27.0.12077973"
    }
}

flutter {
    source = "../.."
}
