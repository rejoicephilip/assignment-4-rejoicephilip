# DMIT2504 Assignment 04 - Movie Tracker App: Debug & Extend (2025)
Weight: 12.5% of final mark

## Overview
This assignment will assess your ability to debug existing code and implement missing features in a Flutter application. You will receive a partially implemented Movie Tracker app that has several bugs and missing features. Your task is to identify and fix the issues, then implement the remaining functionality to complete the application according to the provided client specification.

## The Movie Tracker App
The app allows users to track movies they've watched or want to watch. It uses:
- **SQLite** for storing movie data
- **SharedPreferences** for user settings
- **Form validation** for ensuring proper data entry

The app consists of the following core components:
- Movie list view showing movie details
- Add/Edit movie form
- User preference settings
- Movie database operations

Refer to the provided [`CLIENT_SPECIFICATION.md`](CLIENT_SPECIFICATION.md) document for detailed requirements of the completed application. This document outlines what the finished application should do, though some of these features may not be working correctly in the starter code.

## Requirements

### Bug Fixing (50% of grade)
The provided starter code contains several intentional bugs that prevent the app from functioning correctly. These issues span different components of the application including:

- Database operations
- SharedPreferences implementation
- UI state management
- Form handling

For each bug you identify and fix, you must:
- Document the bug in your report
- Explain why it was problematic
- Show the before and after code
- Describe your solution approach

### Feature Implementation (30% of grade)
You need to implement several missing features to complete the application according to the client specification. To determine which features are missing you will need to carefully go through the client spec and compare that against the existing functionality. You will need to validate whether something is missing entirely or simply has a bug.

### Code Quality & Documentation (20% of grade)
Your submission will be evaluated on:
- Consistent code style and organization
- Appropriate comments
- Comprehensive bug report documentation
- Brief project summary explaining your approach

## Debugging Hints

As you work through the assignment, keep in mind that the app may contain a variety of issues, including but not limited to:

- Incorrect data types in the database schema
- Issues with database CRUD operations
- Inconsistencies in key names or variable references
- Missing or incomplete form validation
- UI elements that don't reflect the actual data state
- State management issues causing UI not to update properly
- Features described in the client specification that are completely missing
- Incorrect logic in conditionals or comparison operations
- Problems with data persistence across app sessions
- Improper handling of user preferences

**The unit tests provided in this assignment validate all functionality and can be used to help guide your debugging**


## Submission Requirements
On or before the deadline, push your final solution to the GitHub repository. You must commit and push to the classroom assignment repository supplied for the assignment; do not create your own repository. It is your responsibility to ensure that your work is in the correct repository. Work not in the repository will not be graded.

Your submission must include:
1. The complete working application code
2. A separate markdown document titled `BUGS.md` that lists all bugs you found and fixed
3. A brief `README.md` describing your approach to the assignment

Follow Dart programming conventions [Effective Dart](https://dart.dev/guides/language/effective-dart). Your code must compile and not throw unexpected runtime exceptions. Code that does not compile will not be graded.

**NOTE: You must demonstrate incremental development of your solution. This means that you must begin work on your solution as soon as possible and commit often to the assignment repository. Each commit must demonstrate functional improvements to the solution. Failure to show incremental work during the assignment period will result in loss of marks of up to 20%.**
 
**Additionally, you are encouraged to use external resources to help you learn what is needed for the assignment. However, if you submit code that differs greatly from what was demonstrated in class it must be documented (e.g. comments, citations, etc.) and you may be asked to provide a verbal explanation of how the code works to your instructor. Failure to explain any code you submitted will be considered as potential evidence of academic misconduct and may trigger an investigation, potentially resulting in further consequences.**

## Marking Rubrics [Assignment total 10 marks]

### Bug Fixing [5 marks]
| Mark | Description |
| ---- | ----------- |
| 5 | **Excellent** – All bugs identified and fixed correctly. Solutions are elegant and demonstrate deep understanding of Flutter/Dart concepts. Detailed documentation of each bug and solution. |
| 4 | **Very Good** – Most bugs identified and fixed correctly with good solutions. Documentation is thorough for most bugs. |
| 3 | **Good** – Many bugs identified and fixed, but some solutions may be suboptimal. Documentation is adequate. |
| 2 | **Satisfactory** – Several bugs identified and fixed, but significant issues remain. Documentation is incomplete. |
| 1 | **Needs Improvement** – Only the most obvious bugs identified and fixed. Solutions may introduce new problems. Documentation is minimal. |
| 0 | **Not Attempted** – No bug fixes attempted or documented. |

### Feature Implementation [3 marks]
| Mark | Description |
| ---- | ----------- |
| 3 | **Excellent** – All missing features implemented correctly and fully integrated with the app. Solutions are elegant and follow best practices. |
| 2.5 | **Very Good** – All features implemented with minor issues in implementation or integration. |
| 2 | **Good** – Most features implemented but with some functionality issues. |
| 1.5 | **Satisfactory** – Core features implemented but with significant issues or missing components. |
| 1 | **Needs Improvement** – Features partially implemented with major functionality issues. |
| 0 | **Not Attempted** – Features not implemented. |

### Code Quality & Documentation [2 marks]
| Mark | Description |
| ---- | ----------- |
| 2 | **Excellent** – Code is well-organized, commented, and follows Dart conventions. Documentation is thorough and clear. Project summary shows deep understanding. |
| 1.5 | **Good** – Code is mostly well-organized with adequate comments. Documentation covers most aspects but may lack some detail. |
| 1 | **Satisfactory** – Code organization and comments are adequate. Documentation covers basic requirements. |
| 0.5 | **Needs Improvement** – Code is poorly organized with few comments. Documentation is minimal. |
| 0 | **Not Attempted** – No effort made to maintain code quality or provide documentation. |


**Acknowledgment:**  
This assignment was developed with assistance from Claude AI (Claude 3.7 Sonnet, Anthropic, accessed May 12-16, 2025). The assignment structure, requirements, technical specifications, and starter code were in part refined through collaborative prompting to create an educational exercise that meets the course learning objectives.
