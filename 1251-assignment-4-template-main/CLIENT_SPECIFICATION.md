# Movie Tracker App - Client Specification

## Overview
The Movie Tracker app is a personal utility for film enthusiasts to maintain a catalog of movies they've watched or want to watch. The application should be straightforward to use while providing a complete set of features for managing a movie collection.

## Core Functionality

### User Experience
- Upon first launch, the app should prompt the user to enter their name
- User preferences (including name and theme choice) should persist between app launches
- The app should support both light and dark themes that the user can toggle between
- The app should maintain its state appropriately during navigation

### Movie Management
- Users should be able to view a list of all their movies
- Each movie in the list should display:
  - Title
  - Release year
  - Director
  - Star rating (1-5 stars)
  - Watched status (indicator if the movie has been watched)
- Users should be able to add new movies to their collection
- Users should be able to edit existing movie entries
- Users should be able to delete movies from their collection
- The movie list should update immediately after any changes (add/edit/delete)

### Movie Data Model
Each movie entry must include:
- Title (text, required)
- Release year (4-digit number between 1888-present year, required)
- Director (text, optional)
- Watched status (boolean, required)
- Rating (integer from 1-5, required if watched)

### Data Entry & Validation
- The add/edit movie form should validate all inputs according to the data model
- Invalid inputs should show appropriate error messages
- The form should prevent submission until all required fields have valid values
- Star rating should be selectable using a visual star interface (tap to select rating)

### Data Persistence
- All movie data should be stored in a local SQLite database
- The database should correctly handle all data types specified (text, integers, booleans)
- User preferences should be stored using SharedPreferences

## Technical Requirements

### Database Requirements
- The application should use a single table named "movies" with appropriate columns
- Column types should match their intended data (e.g., INTEGER for year and rating)
- Database operations should be encapsulated in a dedicated helper class
- All CRUD operations (Create, Read, Update, Delete) should be supported

### UI Requirements
- The app should follow Material Design guidelines
- List items should have adequate spacing and typography
- Add/Edit form should be clearly laid out with labeled fields
- Rating should be displayed visually using star icons
- Watched status should be clearly indicated checkmark icon
- The theme toggle should be easily accessible

### Performance & Error Handling
- Database operations should be non-blocking (avoid UI freezes)
- The app should handle edge cases gracefully
- Error states should be handled appropriately without crashing
- Form validation should prevent database corruption

## Development Notes
- The app should follow Flutter/Dart best practices
- Code should be well-structured and commented where appropriate
- Variable and function names should be descriptive and consistent
- UI state management should follow appropriate patterns
- Database helper methods should be reusable and robust