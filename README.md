### Pre-Requirements
###### Android
* For downloading the _staging_ application we need access to the (Internal Early Access version) from Google Play _(provided by your friendly Android developer)_
* For downloading the _production_ application we need access to the (Early Access version) from Google Play _(provided by your friendly Android developer)_
* For building any version of the application locally, we need access to the Bitbucket repository [android-client](https://bitbucket.org/evgo/android-client/src/master/)
###### iOS
* For downloading the BETA/PROD version of the application we need invitation code for TestFlight
* For building the (_staging_) application locally, we need access to the Bitbucket repository [ios-client](https://bitbucket.org/evgo/ios-client/src/master/)
* *In order to be able to build the application we need a [developer account](https://developer.apple.com/account) (provided by your friendly iOS developer)*


### Installation

Download [Python](https://www.python.org/downloads/) and install it (as of now, the latest version is Python 3.10)

Install all required packets using: `pip3 install -r requirements.txt` or `python -m pip install -r requirements.txt`

Download and install [Appium-desktop](https://github.com/appium/appium-desktop/releases/) and [Appium-inspector](https://github.com/appium/appium-inspector/releases/)

_Alternatively, you can install latest appium version using: `npm install -g appium` or `npm install -g appium@next` for the latest beta. Run it by typing `appium` in terminal._


###### Optional

Install [PyCharm Community](https://www.jetbrains.com/pycharm/download/) edition (free) for editing test cases 


##### Docker

Download and install [Docker](https://www.docker.com/products/docker-desktop)

In the same location of the _Dockerfile_ (_root folder_ - **here**) open terminal window and build the dockerfile using: `docker build -t <docker name> .` (for example: evgo/robot)

For running the machine, type: `docker run -ti evgo/robot bash`

* *The docker image installs everything needed to run the tests and copies the **src** folder into **tests** folder of the docker container*


### Configuration


##### Android

Download [Android Studio](https://developer.android.com/studio)

Install following the wizard and start it.

On the Welcome screen click on the **Configure** and select **SDK Manager**. Select the versions of Android you need (9.0+)


###### Virtual device

From the same **Configure** menu, select **AVD Manager** and _Create Virtual Device_ from a list of available devices and (download) Android versions, or select _New Hardware Profile_ to create a custom device.

You can then start the virtual device from the _Actions_ cell in _Virtual Device Manager_

or start it from command line, using: `emulator -list-avds` to list available virtual devices and then `emulator -avd name_of_the_device`


###### Physical device

Device: Go to _Settings_ > _About Phone_ and tap the _Build Number_ 10 times to enable _Developer Mode_. Select _Developer options_ and enable _USB debugging_.
Plug the device (and have it unlocked)


##### iOS

Install [Xcode](https://apps.apple.com/us/app/xcode/id497799835) from App Store (10+ GB)


###### Virtual device

Launch Xcode once. Run ios simulator. Drag the ios simulator icon to dock it. Right click to start a specific device.

You can also run it using a command line: `open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app`


###### Physical device

Follow the instructions in [EVgo iOS application project setup](https://bitbucket.org/evgo/ios-client/src/master/README.md)

Continue following [this Appium tutorial](https://github.com/appium/appium/blob/master/docs/en/drivers/ios-xcuitest-real-devices.md)


###### Inspector Session Settings

``` json
{
  "platformName": "iOS",
  "automationName": "XCUITest",
  "deviceName": "iPhone X",
  "platformVersion": "14.4",
  "udid": "d0cb25d46a465238740b1758b3a57c89a2b64b9e",
  "xcodeOrgId": "346B5PHBV5",
  "xcodeSigningId": "EVgo Services, LLC",
  "app": "com.driivz.mobile.EVgo.beta"
}
```


### Running

* Appium server needs to be started and running in the background.

* If macOS doesn't allow Appium to run, you'll need to allow it in _System Preferences_ > _Security & Privacy (click the lock to make changes)_

* If iOS doesn't allow this, you need to: _Settings_ > _General_ > _Device Management_. Also enable UI Automation: _Settings_ > _Developer_ > _Enable UI Automation_

The right way to run an Android local test suite on QA environment would be: 
`robot -d src\results -v ENVIRONMENT:qa -v PLATFORM:Android -v LOCATION:local -v DEVICE_NAME:Samsung S9 -v PLATFORM_VERSION:10 --RemoveKeywords WUKS src\tests\Login.robot`

`-d src\results` is the reports folder

The 3 **required** variables we send `-v ENVIRONMENT:qa -v PLATFORM:android -v LOCATION:local`

We don't need to send these values, there are defaults set in `src/resources/TestConfiguration.robot` file

We need to send 2 additional values for correct TestRail results `-v DEVICE_NAME:"Samsung S9" -v PLATFORM_VERSION:10` or `-v DEVICE_NAME:"iPhone X" -v PLATFORM_VERSION:14.4`

`ENVIRONMENT:  dev    qa    stg    beta    prod`    environment (default set to beta, for now)

`PLATFORM:     Android    iOS`                      platform (default iOS)

`LOCATION:     local    cloud`                      location (default local)

`--RemoveKeywords WUKS` - is for removing the excessive log lines in the report files

`src\tests\Login.robot` is the test suite

The right way to run a single iOS local test on beta environment would be: 
`robot -d src/results -v ENVIRONMENT:beta -v PLATFORM:iOS -v LOCATION:local -t 131602 src/tests/AndroidSmokeTests.robot`

Where `-t 131602` is the specific test case (same as in TestRail) ID we want to run

