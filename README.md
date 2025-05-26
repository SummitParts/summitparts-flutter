# Summit Parts

Summit Parts Mobile Application

## Flutter Version Manager

This project is built using Flutter. To manage different versions of Flutter, we use the `fvm` ([Flutter Version
Management](https://fvm.app/documentation/getting-started)) tool. This allows us to easily switch between different
versions of Flutter for different projects.

## Running the Project

1. **Change directory**:
   ```bash
   cd summit_parts
   ```
2. **Install Dependencies**:
   ```bash
   fvm flutter pub get
   ```
3. **Run the App**:
   ```bash
   fvm flutter run
   ```

## Melos

This project uses [Melos](https://melos.invertase.dev/) as a task runner to simplify common development tasks. Melos is
configured directly in the `pubspec.yaml` file.

### Getting Started with Melos

1. Ensure Melos is activated globally:
   ```bash
   dart pub global activate melos
   ```

2. Run Melos scripts using:
   ```bash
   melos [script-name]
   ```

### Available Scripts

- **generate**: Generates code for the project using build_runner
  ```bash
  melos generate
  ```
- **generate-assets**: Generates code for the assets in `assets/` folder
  ```bash
  melos generate-assets
  ```
