# Install Resend Package

## Error
```
Module not found: Can't resolve 'resend'
```

## Solution

You need to install the `resend` package. Run one of these commands in your terminal:

### Using npm:
```bash
npm install resend
```

### Using pnpm (if you're using pnpm):
```bash
pnpm add resend
```

### Using yarn:
```bash
yarn add resend
```

## After Installation

1. The package is already listed in `package.json` as `"resend": "^4.0.0"`
2. After running the install command, the package will be added to `node_modules`
3. The build error should be resolved
4. Restart your development server if it's running

## Verify Installation

After installing, you can verify it's installed by running:
```bash
npm list resend
```

Or check if the folder exists:
```bash
ls node_modules/resend
```

## Note

The code has been updated to handle missing Resend gracefully, but you still need to install it for the build to succeed. The application will work in development mode (showing codes in console) even without Resend configured, but you need the package installed for the build to complete.

