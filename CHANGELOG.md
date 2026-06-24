## 0.0.2 - 2026-06-24

- Live skin updates.

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
