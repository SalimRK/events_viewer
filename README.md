# Event Viewer

Event Viewer is a Flutter-based mobile application that allows users to view public holidays for different countries and add them to their calendar. The app fetches data from an external API, displays available countries, and shows upcoming holidays for the selected country.

# Features
- View Available Countries: The app displays a list of countries where public holidays can be accessed.
- View Public Holidays: For a selected country, the app shows a list of public holidays for the current year.
- Add Events to Calendar: Users can long-press on a holiday to add it to their device's calendar.
- Highlight Next Holiday: The next upcoming holiday is highlighted in red for better visibility.

# Requirements
- Flutter SDK 3.x or higher
- Dart 2.12 or higher
- An internet connection to fetch country and holiday data
- Android/iOS device or emulator for testing

# Release
You can directly download the latest APK file from the releases section of this repository.
Download APK

- Download the latest APK

# How It Works
- Fetching Available Countries: The app uses the API endpoint https://date.nager.at/api/v3/AvailableCountries to fetch a list of countries where public holiday data is available.
- Fetching Public Holidays: Once a country is selected, the app queries https://date.nager.at/api/v3/PublicHolidays/{year}/{countryCode} for that country's public holidays.
- Adding Events to Calendar: The app uses the add_2_calendar package to add selected holidays as calendar events.

# Packages Used

- http: For making network requests to fetch country and holiday data.
- add_2_calendar: To add events to the calendar.
- flutter: The framework for building the mobile app.

# Contributing
Contributions are welcome! Feel free to fork this repository, submit issues, and send pull requests.