# Rolling Bottom Bar

This packages, based on this [demo](https://codepen.io/kaboc/pen/eYJbbop) by [Kabo](https://codepen.io/kaboc) showing a bottom bar with a dynamic ball indicator.

## Demo

<img src="https://github.com/ajomuch92/rolling-bottom-bar-flutter/blob/master/assets/demo.gif" width="300" />

## Instalation
Include `rolling_bottom_bar` in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  rolling_bottom_bar: version
```

## Usage

To use this package, just import it into your file, build your bottom bar together with a PageView and enjoy it.

```dart
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

...

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rolling Bottom Bar'),
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          ColoredBox(color: Colors.blueGrey.shade100),
          ColoredBox(color: Colors.redAccent),
          ColoredBox(color: Colors.greenAccent),
          ColoredBox(color: Colors.yellowAccent),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        controller: _controller,
        items: [
          RollingBottomBarItem(Icons.home, label: 'Page 1'),
          RollingBottomBarItem(Icons.star, label: 'Page 2'),
          RollingBottomBarItem(Icons.person, label: 'Page 3'),
          RollingBottomBarItem(Icons.access_alarm, label: 'Page 4'),
        ],
        activeItemColor: Colors.green.shade700,
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}

...
```

## Options for Rolling Bottom Bar Item use

|  Name | Description   | Required   |
| ------------ | ------------ | ------------ |
| iconData  | IconData to use as item icon | True   |
| label  | String to use as label item |  False  |

## Options for Rolling Bottom Bar use

|  Name | Description   | Required   | Default   |
| ------------ | ------------ | ------------ | ------------ |
| controller  | PageView controller to use to move between pages | True   |   |
| items  | List of RollingBottomBarItem to render into bottom bar |  True  |   |
| onTap  | Function triggered when an item is tapped | True   |   |
| color  | Color value to use as background | False   |  Colors.white |
| itemColor  | Color value to use with inactive items | False   |  Colors.grey[700] |
| activeItemColor  | Color value to use with active items | False   |  Colors.grey[700]  |
| enableIconRotation  | Boolean value to indicate when rotation effect is triggered | False   | false  |

