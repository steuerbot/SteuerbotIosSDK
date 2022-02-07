# Steuerbot iOS SDK

This Swift Package allows you to add the Steuerbot SDK to your iOS App.

## Installation

### Add the Swift Package to your Project
Add the package by selecting `File` → `Add Packages…` in Xcode’s menu bar. Search for the Steuerbot SDK using the repo's URL:

```console
https://github.com/steuerbot/ios-sdk.git
```

Then, select `Add Package`.

### Embed the Framework

Make sure `Steuerbot` is added to `Frameworks, Libraries and Embedded Content` in your apps target.


## Usage

### Basic Initialization:
```swift
import Steuerbot
...
let user = User(email: "hello@steuerbot.com", forename: "John", surname: "Doe")
let framework = SteuerbotSDK(partnerId: "your-partner-id", token: "your-user-token", user: user)

let controller = UIViewController()
controller.view = framework.getView()
self.present(controller, animated: true, completion: nil)
```

### Advanced Initialization Parameters:

#### SteuerbotSDK:

| Property  | Value | Required | Notes |
|:---|:---|:---|:---|
| debug  | Bool | false | `false` is default |
| partnerID  | String | true | Your personal ID, provided by [Steuerbot](mailto:marc@steuerbot.com) |
| partnerName  | String | true | The Name of your Company/App |
| token | String | true | TODO |
| user | [User](#User) | true | If the provided mail address is already in use, error will be thrown.|
| [paymentLink](#payment) | String | true | Will be opened/called, when the user triggers payment. Should initiate the payment process in your app. |
| backButtonLink | String | false | Link will be opened/called, when the user presses the back button on the SDKs home screen.|
| apiUrl | String | false |  |
| language | .german, .english | false | `.german` is the default |
| [lightTheme](#Theming) | String | false | If only one theme is provided, the provided theme will be used in dark and in light mode. |
| [darkTheme](#Theming) | String | false | If only one theme is provided, the provided theme will be used in dark and in light mode. |
| [action](#Actions) | .vast, .support, .taxYear(Int) | false | Provided actions will trigger a (navigation) action when the SDK is initialized. Additionally actions can be triggered at [runtime](#Actions). |
| [deeplink](#Deeplinks) | String | false | Provided deeplinks will trigger a (navigation) action when the SDK is initialized. Additionally deeploinks can be triggered at [runtime](#Deeplinks). Using `actions` is the prefered way to trigger actions. |
#### <a name="User"></a>User

| Property  | Value | Required | Notes |
|:---|:---|:---|:---|
| email | String | true |  |
| forename | String | true | |
| surname | String | false |  |
| taxId | String | false |  |
| iban | String | false |  |
| birthdate | String | false | ISO 8601: YYYY-MM-DD |
| gender | .male, .female, .other | false |  |
| address | [Address](#Address) | false |  |
| phoneNumber | String | false |  |

#### <a name="Address"></a>Address

| Property  | Value | Required | Notes |
|:---|:---|:---|:---|
| street | String | true |  |
| number | Int | true | leading number-part/digits only; rest goes into `numberAddition` |
| zip | String | true |  |
| city | String | true |  |
| state | String | true | usually short-form of state, for example BW, BY, NRW, |
| country | String | true | Country code, "DE" for Germany |
| countryLong | String | true | Full Country name |
| latitude | Double | false |  |
| longitude | Double | false |  |
| numberAddition | String | false | for example "/1", "a", "-2" |
| supplement | String | false | for example apartment, building, floor |


#### <a name="Actions"></a>Actions

Actions can be triggered while initializing the SDK, or at runtime by calling following function:

```swift
framework.triggerAction(action: .taxYear(2018))
```

Supported Actions are:

##### PaymentSuccessAction

Completes the [payment](#payment) process:
```swift
.paymentSuccess(price: 999, submitId: "98765", offerId: "61f29833a137d993740cc610", botId: "237f6193-f4e9-4258-b0f5-1f428e63013a")
```
You are getting `submitId`, `offerId` and `botId` passed as parameters with the `paymentLink`. `price` is the price, the user payed to you for the service. `price` is in ct.

##### TaxYearAction

Jump to a specific tax year:

```swift
.taxYear(2021)
```

##### SupportAction

Jump to support screen:

```swift
.supportAction
```

##### VastAction

Jump to screen with prefilled tax declaration feature:

```swift
.vast
```

#### <a name="Deeplinks"></a>Deeplinks

Deeplinks can be triggered while initializing the SDK, or at runtime by calling following function:

```swift
framework.triggerDeeplink(url: "https://app.steuerbot.com/steuerjahr-2020")
```

Supported Deeplinks are:

##### TaxYearDeeplink

Jump to a specific tax year:

```
https://app.steuerbot.com/steuerjahr-XXXX
```
```
/steuerjahr-XXXX
```

##### SupportDeeplink

Jump to support screen:

```
https://app.steuerbot.com/support
```
```
/support
```

##### VastDeeplink

Jump to screen with prefilled tax declaration feature:

```
https://app.steuerbot.com/vorausgefuellte-steuererklaerung
```
```
/vorausgefuellte-steuererklaerung
```

#### <a name="payment"></a>Payment

First, the `paymentLink` gets triggered by the SDK. `submitId`, `offerId`, `botId`, `purpose`, `iban` and `refund` will be appended as query-parameters to your provided URL. 

```
https://your-domain.com/your-link/?refund=105099&purpose=PV0711522324&iban=DE68210501700012345678&submitId=98765&offerId=61f29833a137d993740cc610&botId=237f6193-f4e9-4258-b0f5-1f428e63013a
```
**submitId**, **offerId**, **botId**: need to be passed back for referencing via the `paymentSuccess`-Action.

**purpose** is the unique OrderID for this transaction.

**iban** is the Iban, the user has to transfer the money for the Steuerbot-Service to.

**refund** is the calculated tax-refund, the user will receive.


Then, after the user has paid via your payment-gateway, you have to call the `paymentSuccess`-Action, passing back `submitId`, `offerId`, `botId` and the price, the user has paid. This will reopen the submission-process in the SteuerbotSDK and will guide the user to submit his declaration. 


#### <a name="Theming"></a>Theming

You can set your own custom dark and light theme. If only one theme is provided, the provided theme will be used in dark and in light mode. The Themes have to be provided as **JSON** strings.

This is the specification of a theme. All fields are optional. Customize as you want.

More details can be found on our [Wiki](https://github.com/steuerbot/ios-sdk/wiki/Styling)

```ts
{
  name: string;
  colors: {
    // gray colors
    gray100: string;
    gray90: string;
    gray80: string;
    gray70: string;
    gray60: string;
    gray50: string;
    gray40: string;
    gray30: string;
    gray20: string;
    gray10: string;
    gray0: string;
    // static gray colors
    staticGray100: string;
    staticGray90: string;
    staticGray80: string;
    staticGray70: string;
    staticGray60: string;
    staticGray50: string;
    staticGray40: string;
    staticGray30: string;
    staticGray20: string;
    staticGray10: string;
    staticGray0: string;
    // primary colors
    primary100: string;
    primary90: string;
    primary80: string;
    primary60: string;
    primary40: string;
    primary20: string;
    // accent colors
    accentCold100: string;
    accentCold90: string;
    accentCold80: string;
    accentCold60: string;
    accentCold40: string;
    accentCold30: string;
    accentCold20: string;
    // info colors
    info100: string;
    info90: string;
    info80: string;
    info60: string;
    info40: string;
    info20: string;
    // success colors
    success100: string;
    success90: string;
    success80: string;
    success60: string;
    success40: string;
    success20: string;
    // warning colors
    warning100: string;
    warning90: string;
    warning80: string;
    warning60: string;
    warning40: string;
    warning20: string;
    // danger colors
    danger100: string;
    danger90: string;
    danger80: string;
    danger60: string;
    danger40: string;
    danger20: string;
    // debug colors
    debug100: string;
    debug90: string;
    debug80: string;
    debug40: string;
    debug20: string;
    // highlight colors
    notice80: string;
    notice20: string;
    // transparent
    transparent: string;
  };
  fonts: {
    headline: string;
  };
  text: {
    fontSizes: {
      xsmall: number;
      small: number;
      medium: number;
      large: number;
      xlarge: number;
    };
  };
  headline: {
    level1: {
      fontSize: number;
      lineHeight: number;
      marginTop: number;
      marginBottom: number;
      fontWeight: 'light' | 'regular' | 'medium' | 'bold' | 'black';
    };
    level2: {
      fontSize: number;
      lineHeight: number;
      marginTop: number;
      marginBottom: number;
      fontWeight: 'light' | 'regular' | 'medium' | 'bold' | 'black';
    };
    level3: {
      fontSize: number;
      lineHeight: number;
      marginTop: number;
      marginBottom: number;
      fontWeight: 'light' | 'regular' | 'medium' | 'bold' | 'black';
    };
    level4: {
      fontSize: number;
      lineHeight: number;
      marginTop: number;
      marginBottom: number;
    };
    level5: {
      fontSize: number;
      lineHeight: number;
      marginTop: number;
      marginBottom: number;
    };
  };
}
```




## License
[TODO](https://todo.de)
