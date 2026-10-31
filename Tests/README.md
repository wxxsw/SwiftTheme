# Simulator regression checks

Boot an iOS 15+ simulator, then run from the repository root:

```sh
Tests/run-simulator-tests.sh <simulator-UDID>
```

The script needs Xcode and Python 3. It compiles the actual library sources into a small UIKit app and returns a nonzero status if any check fails. `booted` can be used when exactly one simulator is running.

Checks cover RGBA parsing, attributed-string array selection, attributed text mapped from a theme dictionary, gradient color mapping, navigation/tab bar appearance updates, and title attributes bound to a real tab item. These property checks do not replace visual testing of the demos, transitions, or Liquid Glass.

The optional `proxy` argument in the regression app is for manually investigating issue #147: it configures `UITabBarItem.appearance()` with the custom theme method and can crash inside UIKit. The regular script uses real instances and does not run that probe.
