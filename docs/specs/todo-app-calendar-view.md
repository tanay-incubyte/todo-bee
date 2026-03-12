# Spec: Todo App — Calendar View

## Overview
Add a calendar view to visualize tasks by their due dates. Users can switch between month, week, and day views to see their tasks laid out chronologically. This is a read-only view — clicking a task navigates to its detail page.

## Acceptance Criteria

### Navigation
- [x] "Calendar" link appears in the main navigation bar
- [x] Clicking "Calendar" navigates to the calendar view page

### Month View (Default)
- [x] Calendar displays a month grid with days
- [x] Tasks with due dates appear on their respective day cells
- [x] Current day is visually highlighted
- [x] User can navigate to previous/next month
- [x] Month and year are displayed in the header

### Week View
- [x] Calendar displays 7 days in a row (Sun-Sat or Mon-Sun)
- [x] Tasks appear on their due date column
- [x] User can navigate to previous/next week
- [x] Week date range is displayed in the header

### Day View
- [x] Shows all tasks due on a single day
- [x] User can navigate to previous/next day
- [x] Date is displayed in the header

### View Switching
- [x] Buttons/tabs to switch between Month, Week, Day views
- [x] Current view is visually indicated
- [x] View preference persists during navigation (clicking next/prev stays in same view)

### Task Display
- [x] Tasks show title (truncated if long)
- [x] Tasks show priority badge if set
- [x] Tasks show completion status (strikethrough if completed)
- [x] Clicking a task navigates to its detail page
- [x] Tasks without due dates are NOT shown on calendar (list view only)

### UI/UX
- [x] Calendar has clean, modern styling consistent with existing app
- [x] Responsive layout for desktop and tablet
- [x] Empty days show no placeholder (clean grid)

### Filtering (Added)
- [x] Same filter bar as task list (Status, Priority, Category)
- [x] Multi-select filters (e.g., High AND Medium priority)
- [x] Filters persist when navigating between dates
- [x] Filters persist when switching views (Month/Week/Day)

## Out of Scope
- Drag-and-drop to change due dates
- Creating tasks directly from calendar
- Recurring tasks
- Time-of-day scheduling (just dates)
- iCal export/import

## Technical Context
- **Stack**: Ruby on Rails 8, Tailwind CSS, Hotwire (Stimulus for view switching)
- **Patterns**: MVC, new CalendarController, existing Task model
- **Risk level**: LOW — read-only view feature
- **Key integration**: Uses existing Task model and due_date field
