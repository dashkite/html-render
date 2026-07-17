# Testing

This document outlines the testing strategy and execution commands for the Domo library.

## Testing Strategy

The Domo library relies on an automated testing suite to verify the accurate construction of DOM trees and the proper sanitization of content. The tests exercise the various polymorphic signatures of the tag builders, ensuring that attributes are applied correctly and that child elements—whether text, arrays, or existing nodes—are appended flawlessly.

## Executing Tests

To run the test suite, you should use the standard task manager command:

```bash
npx genie test
```

If the task manager is unavailable, you may invoke the fallback script directly:

```bash
./scripts/test
```
