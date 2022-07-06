package dev.flutter.map_draw;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.yandex.mapkit.MapKitFactory;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    // MapKitFactory.setLocale("YOUR_LOCALE"); 
    MapKitFactory.setApiKey("6043f1df-0164-4e65-9529-eccc4eebc3e2");
    super.configureFlutterEngine(flutterEngine);
  }
}