import UIKit

final class RegressionApp: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var failures = [String]()
    var passes = [String]()
    let args = ProcessInfo.processInfo.arguments
    func check(_ condition: Bool, _ name: String) {
        if condition { passes.append(name) } else { failures.append(name) }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ThemeManager.animationDuration = 0
        if args.contains("proxy") {
            UITabBarItem.appearance().theme_setTitleTextAttributes(ThemeStringAttributesPicker.pickerWithAttributes([[.foregroundColor: UIColor.red]]), forState: .normal)
        }
        let vc = UIViewController()
        vc.title = "Probe"
        vc.view.backgroundColor = .white
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let nav = UINavigationController(rootViewController: vc)
        let tabs = UITabBarController()
        tabs.viewControllers = [nav]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabs
        window?.makeKeyAndVisible()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.run(nav: nav, tabs: tabs)
        }
        return true
    }
    func run(nav: UINavigationController, tabs: UITabBarController) {
        let color = UIColor(hex8: 0xFF000080)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        check(r == 1 && g == 0 && b == 0 && abs(a - 128/255) < 0.001, "#172 RGBA channel order")
        check(UIColor(rgba: "#1234").hexString(true) == "#11223344", "#172 shorthand RGBA round trip")
        let first = NSAttributedString(string: "First")
        let second = NSAttributedString(string: "Second")
        let strings = ThemeAttributedStringPicker([first, second])
        ThemeManager.setTheme(index: 0)
        check((strings.value() as? NSAttributedString)?.string == "First", "attributed strings initializer selects first string")
        ThemeManager.setTheme(index: 1)
        check((strings.value() as? NSAttributedString)?.string == "Second", "attributed strings initializer selects second string")
        let label = UILabel()
        let gradient = CAGradientLayer()
        label.theme_attributedText = ThemeAttributedStringPicker(keyPath: "Label") { value in
            guard let dict = value as? [String: String], let text = dict["text"], let hex = dict["color"] else { return nil }
            return NSAttributedString(string: text, attributes: [.foregroundColor: UIColor(rgba: hex)])
        }
        gradient.theme_colors = ThemeAnyPicker(keyPath: "Gradient.colors") { value in
            guard let hexes = value as? [String] else { return nil }
            return hexes.map { UIColor(rgba: $0).cgColor }
        }
        let navPicker = ThemeNavigationBarAppearancePicker(v: {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = ThemeManager.color(for: "Global.barTintColor")
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            return appearance
        })
        let tabPicker = ThemeTabBarAppearancePicker(v: {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = ThemeManager.color(for: "Global.barTintColor")
            return appearance
        })
        nav.navigationBar.theme_standardAppearance = navPicker
        nav.navigationBar.theme_scrollEdgeAppearance = navPicker
        nav.navigationBar.theme_compactAppearance = navPicker
        nav.navigationBar.theme_compactScrollEdgeAppearance = navPicker
        tabs.tabBar.theme_standardAppearance = tabPicker
        tabs.tabBar.theme_scrollEdgeAppearance = tabPicker
        let tabItem = nav.tabBarItem!
        tabItem.theme_setTitleTextAttributes(ThemeStringAttributesPicker.pickerWithAttributes([[.foregroundColor: UIColor.red], [.foregroundColor: UIColor.blue]]), forState: .normal)
        for (hex, text) in [("#FF0000", "First"), ("#0000FF", "Second")] {
            ThemeManager.setTheme(dict: ["Global": ["barTintColor": hex], "Label": ["text": text, "color": hex], "Gradient": ["colors": [hex, "#FFFFFF"]]], path: .mainBundle)
            let expected = UIColor(rgba: hex)
            check(label.attributedText?.string == text, "#171 mapped attributed text updates: \(text)")
            check((label.attributedText?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor) == expected, "#171 mapped attributed text color: \(text)")
            check((gradient.colors as? [CGColor])?.first == expected.cgColor, "#159/#157 mapped gradient: \(text)")
            check(nav.navigationBar.standardAppearance.backgroundColor == expected && nav.navigationBar.scrollEdgeAppearance?.backgroundColor == expected, "#176/#152 nav standard+scrollEdge: \(text)")
            check(nav.navigationBar.compactAppearance?.backgroundColor == expected && nav.navigationBar.compactScrollEdgeAppearance?.backgroundColor == expected, "nav compact appearances: \(text)")
            check(tabs.tabBar.standardAppearance.backgroundColor == expected && tabs.tabBar.scrollEdgeAppearance?.backgroundColor == expected, "#176/#152 tab standard+scrollEdge: \(text)")
        }
        ThemeManager.setTheme(index: 0)
        check((tabItem.titleTextAttributes(for: .normal)?[.foregroundColor] as? UIColor) == .red, "#147 instance title attributes initial")
        ThemeManager.setTheme(index: 1)
        check((tabItem.titleTextAttributes(for: .normal)?[.foregroundColor] as? UIColor) == .blue, "#147 instance title attributes update")
        let result = (passes.map { "PASS \($0)" } + failures.map { "FAIL \($0)" }).joined(separator: "\n")
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("result.txt")
        try! result.write(to: url, atomically: true, encoding: .utf8)
        print(result)
    }
}
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(RegressionApp.self))
