# flutter_skin

<p align="center">
  <img src="https://github.com/koukibadr/flutter_skin/blob/main/fskin_trans.png?raw=true" alt="FSkin Logo" width="120" />
</p>

<p align="center">
  <strong>Change what your users see.</strong>
</p>

<p align="center">
  <a href="https://pub.dev/packages/flutter_skin"><img src="https://img.shields.io/pub/v/flutter_skin.svg" alt="pub version"></a>
  <a href="https://pub.dev/packages/flutter_skin"><img src="https://img.shields.io/pub/likes/flutter_skin" alt="pub likes"></a>
  <a href="https://fskin.dev/docs"><img src="https://img.shields.io/badge/docs-fskin.dev-6C63FF" alt="documentation"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License"></a>
</p>

---

`flutter_skin` is a runtime skin engine for Flutter. It lets you define your app's theme (currently color scheme) remotely — in production, on real user devices, without shipping any updates.

You push a new skin from the [FSkin dashboard](https://app.fskin.dev). Every user running your app sees the change instantly — no rebuild, no review cycle, no restart required.

---

## Why flutter_skin ?

Theming system in mobile apps is super powerful but static. Once your app ships, its colors are locked in the binary. Changing a single button color means a full release cycle:

```
Code change → Build → Review → App Store approval → User update
```

`flutter_skin` cycle:
```
Dashboard publish → CDN update → Users see new colors  (~2 seconds)
```
You update the settings, your users see the change instantly.

Fully compliant with App Store and Google Play policies, since the app itself isn't changing, same codebase but different configuration. Perfect for:
- **White-label apps with multiple brands**
- **Seasonal themes (holidays, events)**
- **Emergency fixes**

---

## Getting Started

### 1. Create a project on FSkin

Sign up at [app.fskin.dev](https://app.fskin.dev), create a project, and copy your API key.

### 2. Add the package

```yaml
dependencies:
  flutter_skin: ^0.0.2
```

```bash
flutter pub get
```

### 3. Initialize before `runApp`

```dart
import 'package:flutter_skin/flutter_skin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterSkin.init(
    apiKey: 'fsk_your_api_key_here',
  );

  runApp(const MyApp());
}
```

### 4. Wrap your app with `SkinProvider`

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My App',
        theme: FlutterSkin.toThemeData(),
        home: const HomeScreen(),
      );
  }
}
```
That's it your app is FlutterSkin now.

**No wrapper needed nor additional setup, perfect for quick integration on built projects.**

---

## Available Color Tokens

The current skin model supports a full Material-compatible color scheme:

| Token | Description |
|---|---|
| `skin.colors.primary` | Main brand color |
| `skin.colors.secondary` | Accent / secondary color |
| `skin.colors.background` | Page background |
| `skin.colors.surface` | Card / container background |
| `skin.colors.error` | Error states |
| `skin.colors.onPrimary` | Text/icon on primary color |
| `skin.colors.onSecondary` | Text/icon on secondary color |
| `skin.colors.onBackground` | Text/icon on background |
| `skin.colors.onSurface` | Text/icon on surface |
| `skin.colors.onError` | Text/icon on error color |
| `skin.colors.brightness` | `Brightness.light` or `Brightness.dark` |

These map directly to Flutter's `ColorScheme` — `FlutterSkin.toThemeData()` converts them automatically.

**Upcoming versions: more tokens and more customization**

## Offline Fallback
You can also define a fallback skin that the package will use if fetching the remote skin fails (e.g., no internet, server error). This ensures your app always has a consistent appearance, even without connectivity:

```dart
return MaterialApp(
        title: 'My App',
        theme: FlutterSkin.toThemeData(
          fallbackTheme: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              secondary: Colors.green,
              background: Colors.white,
              surface: Colors.grey[200]!,
              error: Colors.red,
              onPrimary: Colors.white,
              onSecondary: Colors.black,
              onBackground: Colors.black87,
              onSurface: Colors.black54,
              onError: Colors.white,
            ),
          ),
        ),
        home: const HomeScreen(),
      );

```
---


## The Skin JSON Format

This is what the package fetches from the FSkin:

```json
{
  "name": "default",
  "version": 1,
  "colors": {
    "primary": "#6C63FF",
    "secondary": "#FF6584",
    "background": "#FFFFFF",
    "surface": "#F9F9FB",
    "error": "#EF4444",
    "onPrimary": "#FFFFFF",
    "onSecondary": "#000000",
    "onBackground": "#0D0D0D",
    "onSurface": "#1C1B1F",
    "onError": "#FFFFFF",
    "brightness": "light"
  }
}
```

---

## Managing Skins

Skins are created and published from the [FSkin dashboard](https://app.fskin.dev):

- Create multiple skins per project (currently just 2 since we're actively developing the dashboard, but more will come)
- Publish a skin with one click — all connected apps update within seconds
- Clone an existing skin as a starting point
---

## Requirements

- Flutter `>=3.0.0`
- Dart `>=3.0.0`

---

## Additional Information

- 📖 **Documentation:** [docs.fskin.dev](https://docs.fskin.dev)
- 🎛️ **Dashboard:** [app.fskin.dev](https://app.fskin.dev)
- 🐛 **Issues:** [github.com/badrkouki/flutter_skin/issues](https://github.com/koukibadr/flutter_skin/issues)

---

## Our Heroes (contributors)

<a href="https://github.com/koukibadr/flutter_skin/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=koukibadr/flutter_skin" />
</a>
