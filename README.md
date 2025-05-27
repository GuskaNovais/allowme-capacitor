# allowme-capacitor

Plugin Capacitor para integrar o SDK nativo da AllowMe em apps Ionic/Capacitor.

## Install

```bash
npm install allowme-capacitor
npx cap sync
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
