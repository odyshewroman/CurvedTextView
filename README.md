Shield: [![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg

# CurvedTextView

CurvedTextView it is UIKit based UI element for drawing curved text. This realisztio based on this [stackowerflow comment](https://stackoverflow.com/a/32785652) 


<p align="center">
  <img src="/assets/example.png">
</p>

## Compatibility

The CurvedTextView is supported on iOS version 10 or later and Swift 4 and above.

## Installation


### [Swift Package Manager](https://github.com/apple/swift-package-manager)

In Xcode go to: ```File -> Swift Packages -> Add Package Dependency...```

Enter the CurvedTextView GitHub repository - ```https://github.com/odyshewroman/CurvedTextView```

Select the version

Import CurvedTextView module and start to use CurvedTextView

### Cocoapods
To install CurvedTextView with CocoaPods, add the following lines to your `Podfile`:

```ruby
pod "CurvedTextView"
```

## Ussage

<img src="/assets/usages_example.png">

If set circle position to 270 degrees, the text will be flipped.

<img src="/assets/flippedText.png">

To avoid this, set the negative radius and circle position to 90 degrees. 

<img src="/assets/rightText.png">
