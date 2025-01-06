<h1 style="text-align: center;">
  VOU - VOUCHER APP
</h1>

## :file_folder: Folder Structure

### Assets Folder
`assets` folder is located above the lib folder. The assets that is used in the application, environmental settings, fonts, images, translations and more are found here.
```
.
└── assets
    ├── animations                          -> put your animated files here eg. lottie
    ├── configs                             -> put your env files here
    │   ├── dev.json                           -> env that is used for dev
    │   ├── prod.json                          -> env that is used for prod
    │   └── test.json                          -> env that is used for tes
    ├── fonts                               -> put your custom font files here
    ├── images                              -> put your image files here
    └── translations                        -> put your translation files here
        ├── en.json
        └── tr.json
```

### Features Folder
The `features` folder, which is the backbone of the application, was designed using the ***feature-first structure*** instead of layer-first because it doesn't scale very well as the app grows and ***repository design pattern***. The feature-first approach demands that we create a new folder for every new feature that we add to our app. And inside that folder, we can add the repository pattern layers themselves as sub-folders.
```
.
└── lib
    └── features                            -> stands for FEATURE FIRST STRUCTURE
        └── feature_x                          -> seperate and put your features here
            ├── blocs                          -> stands for APPLICATION LAYER
            │   ├── x_cubit.dart                  -> seperate and put your logics here
            │   └── x_state.dart
            ├── models                         -> stands for DOMAIN LAYER
            │   └── x_model.dart                  -> seperate and put your models here
            ├── networking                     -> stands for DATA LAYER
            │   └── x_repository.dart             -> seperate and put your repos here
            └── presentation                   -> stands for PRESENTATION LAYER
                ├── widgets                       -> seperate and put your widgets here
                │   └── x_header_widget.dart
                └── x_screen.dart
```

### Modules Folder
In the `modules` folder, there are dependency injection registration and initialization processes of third-party modules to ensure that they can be easily accessed and used from within the application.
```
.
└── lib
    └── modules
        ├── dependency_injection               -> add your modules injection here
        │   ├── di.dart                           -> must initialize di first
        │   └── x_module_di.dart                  -> example module injection
        └── x_module                           -> create folder for your modules
            └── init_x.dart                       -> create initialization files here
```
### Theme Folder
The `theme` folder contains the necessary theme configuration and settings.
```
.
└── lib
    └── theme
        ├── color
        │   └── app_color_scheme.dart
        ├── text
        │   └── app_typography.dart
        └── app_theme_creator.dart             -> theme creation configuration here
```
### Utils Folder
Apart from the above, constants, helper classes, and methods, shortcuts and many more used throughout the application are located in the `utils` folder.
```
.
└── lib
    └── utils
        ├── helpers                            -> put your helpers here
        │   ├── bar_helper.dart                   -> bar helper to show alert
        │   ├── logging_helper.dart               -> logging helper to show fancy log in console
        │   └── permission_helper.dart            -> permission helper to handle permission requests
        ├── methods                            -> put your methods here
        │   └── aliases.dart                      -> create alias variables here
        │   └── shorcuts.dart                     -> add shortcut methods here
        ├── constants.dart                     -> configure app constants here
        ├── navigation.dart                    -> add navigation destinations here
        ├── r.dart                             -> generated type-safe asset classes here (don't modify)
        └── router.dart                        -> add new screens here
```