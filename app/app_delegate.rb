class MyController < UIViewController
  def viewDidLoad
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle('Start', forState:UIControlStateNormal)
    button.addTarget(self, action:'actionTapped', forControlEvents:UIControlEventTouchUpInside)
    button.frame = [[100, 260], [view.frame.size.width - 200, 40]]
    view.addSubview(button)
  end

  def actionTapped
    10000.times do
      ["foo", nil, "foo"].compact # this leaks
      #["foo", "foo", nil].compact # this does not leak
    end
  end
end

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = MyController.alloc.init
    rootViewController.title = 'compact_leak'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    true
  end
end
