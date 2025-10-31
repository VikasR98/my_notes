
## Points to remember
 - Use try-catch for all async initialization (e.g., DB, Firebase, shared prefs).
 - don't mark initState() method async
- always check "mounted" before calling setState() or navigation or any other statement which used 'context'
- Rethrow keyword
Pass exceptions up the chain
Use for layered error handling


 ## Add these features
 - Learn how to run some code only for the first time or once in app lifecycle - like a tutorial
 - Fire Store to sync notes to cloud
 - Firebase push notification/ local notification for daily reminder


# BUGS
- On entry edit, date changes to 1970
