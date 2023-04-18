setup for android

android/gradle.properties
replace it by:

            org.gradle.jvmargs=-Xmx1536M
            android.enableR8=true//add this line
            android.useAndroidX=true
            android.enableJetifier=true

for docs : https://pub.dev/packages/twilio_flutter
