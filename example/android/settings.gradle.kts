pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.0.1" apply false
    // Legacy KGP while android.builtInKotlin=false (Flutter 3.44+ AGP 9 support).
    // Flutter 3.47+ can enable built-in Kotlin once its KGP min-version check allows AGP's bundle.
    id("org.jetbrains.kotlin.android") version "2.3.20" apply false
}

include(":app")
