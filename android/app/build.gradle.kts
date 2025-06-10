plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android { // <-- C'est le bloc 'android' principal
    // Ces lignes doivent être directement dans ce bloc 'android' principal, pas dans un autre.
    compileSdk = flutter.compileSdkVersion // Utilisez flutter.compileSdkVersion par défaut
    // Ou si vous voulez spécifier une valeur fixe (comme 34), mettez-la ici:
    // compileSdk 34

    ndkVersion = "27.0.12077973" // Votre ajout pour le NDK
    // Ou si vous voulez utiliser celle de Flutter :
    // ndkVersion = flutter.ndkVersion

    namespace = "com.example.flutter_speech_to_text"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.flutter_speech_to_text"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}