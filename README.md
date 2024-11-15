# Movesic

Movesic is a very simple SwiftUI iOS app that uses HealthKit to retrieve step count data and suggests a music playlist based on the user's recent activity levels.

---

## Features

- **HealthKit Integration**: Fetches step count data for the past week using HealthKit.
- **Playlist Suggestions**: Maps activity levels to predefined playlists:
  - Relaxing Playlist for low activity.
  - Focused Playlist for moderate activity.
  - Energizing Playlist for high activity.
- **Dynamic UI**: Displays different UI states based on HealthKit authorization status:
  - Authorized: Shows playlist suggestions.
  - Denied: Notifies the user about missing permissions.
  - Not Determined: Prompts the user for HealthKit access.
- **Testable Code**: Code is tested with unit tests.

## Tools and frameworks used

- **Swift**: Written in Swift with modern Swift Concurrency usage.
- **SwiftUI** and **Observation Framework**: Used @Observable macro.
- **HealthKit**: For retrieving step count data.

## Installation

1. Clone the repo
2. Open `Movesic.xcodeproj` in Xcode 16.0+

## Thought process
1. `StepCountPlaylistMapper`: The idea is to have an one object to handle the mapping from a step count integer value to a `Playlist`. This needs to be swappable so that it is possible to write tests.
2. Something is needed to query the step count but not neccessary be tighly coupled with HealthKit. `StepCountProviding` is a created to hide the dependency on HealthKit. Although it is using `HKAuthorizationStatus` but it is easy to replace with a custom type.
3. One week period logic should not reside in `StepCountProviding`. Therefore, stepCount has two parameters: `startDate` and `endDate`.
4. This makes everything decoupled and makes the codebase organized and testable.

## Tradeoffs
Due to time limitation (3 hours) it was not possible to implement a complete app with nice UI, animations and error handling.

One this was discovered while testing the app: HealthKit does not let the app know whether user has granted or denied the Read permissions. This is a serious limitation which could lead to wrong suggestions. Therefore, one disclaimer text is added to the bottom of the app's screen reminding the users to allow the Read request.
When the authorizationStatus is `sharingDenied` app still needs to fetch the step because this status could mean user has allowed the Read permission.
