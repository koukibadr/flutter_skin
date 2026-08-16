# Changelog

## 0.0.4 - 2026-08-16

> Caching and offline support is now available!

### Added

- Caching and offline support for the last fetched skin. The package will use the cached skin if the user is offline or the server is unreachable. 
- Cache TTL is set to 3 days by default. 

## 0.0.3 - 2026-08-12

> Fonts and Typography tokens are now supported! The `flutter_skin` package can now dynamically update fonts and typography styles.

### Added

- Support typography tokens and google font updates based on SSE updates
- Setup fallback font when the font is not available on the device or the google font fails to load
- Add logging for SSE connection events and errors to help with debugging [PR #6](https://github.com/koukibadr/flutter_skin/pull/6)
- Update Example app to demonstrate typography token usage and font updates
- Update Example app to use new Material Design new tokens tertiary color, onTertiary color

## 0.0.2 - 2026-06-24

> Live skin updates is here! The `flutter_skin` package now supports real-time skin changes via Server-Sent Events (SSE) from the FSkin backend.

### Added

- Implement `FlutterSkin.onSkinChanged` — a broadcast stream that emits the new Skin Tokens whenever the active skin or the project skin changes.
- `FlutterSkin.init()` now opens a persistent Server-Sent Events connection to the FSkin backend alongside the initial skin fetch.
- The SSE connection is automatically paused when the app is backgrounded and resumed when it returns to the foreground.

### Changed

- `FlutterSkin.init()` is now the complete setup — it handles the initial fetch, SSE connection, and lifecycle observer in a single call. No additional configuration required.


## 0.0.1 - 2026-06-21

> 🎉 First alpha release of `flutter_skin` — the remote skin engine for Flutter.

### Added

- Core skin engine — fetch and apply a remotely published color skin on app startup.
- `FlutterSkin.init()` — single entry point to initialize the package with an FSkin API key.
- `FlutterSkin.toThemeData()` — converts the active skin into a Flutter `ThemeData` for seamless Material integration, pass it directly to `MaterialApp.theme`.
- Color token set — full Material-compatible color scheme.
- Light and dark mode support — skins define a `brightness` value and map to the correct Flutter `Brightness`.
- Offline fallback — last successfully fetched skin is cached locally and used when the network is unavailable.
- Cross-platform support — works on Android, iOS, Web, macOS, Windows, and Linux.

### Notes

- This is an **alpha release**. APIs may change before the stable `1.0.0` release.
- Currently only **color tokens** are supported. Typography, spacing, border radii, and elevation tokens are planned for upcoming releases.
