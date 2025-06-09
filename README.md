# allowme-capacitor

Plugin Capacitor para integrar o SDK nativo da AllowMe em apps Ionic/Capacitor.

## Install

```bash
npm install allowme-capacitor
npx cap sync
```

## IOS/APP

```bash
source 'https://git-codecommit.us-east-1.amazonaws.com/v1/repos/allowme_Spec'
source 'https://github.com/CocoaPods/Specs.git'
```

## ANDROID/APP

in build.gradle

```bash
repositories {
    google()
    mavenCentral()
    jcenter()
    maven {
        url "https://android.allowmecloud.com/sdk"
        authentication {
            basic(BasicAuthentication)
        }
        credentials {
            username 'SEU_USERNAME_AQUI'
            password 'SEU_PASSWORD_AQUI'
        }
    }
}
```

## API

<docgen-index>

* [`initialize(...)`](#initialize)
* [`collect()`](#collect)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### initialize(...)

```typescript
initialize(options: { apiKey: string; }) => Promise<void>
```

| Param         | Type                             |
| ------------- | -------------------------------- |
| **`options`** | <code>{ apiKey: string; }</code> |

--------------------


### collect()

```typescript
collect() => Promise<{ data: string; }>
```

**Returns:** <code>Promise&lt;{ data: string; }&gt;</code>

--------------------

</docgen-api>
