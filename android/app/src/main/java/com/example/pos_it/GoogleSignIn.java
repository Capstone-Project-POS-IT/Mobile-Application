package io.flutter.plugins.googlesigninexample;

import android.os.Bundle;
import io.flutter.plugins.googlesignin.GoogleSignInPlugin;
import io.flutter.view.FlutterMain;

@SuppressWarnings("deprecation")
public class GoogleSignIn extends io.flutter.app.FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        FlutterMain.startInitialization(this);
        super.onCreate(savedInstanceState);
        GoogleSignInPlugin.registerWith(registrarFor("io.flutter.plugins.googlesignin"));
    }
}