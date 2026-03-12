# TDD Plan: Todo App — Calendar View

## Execution Instructions
Work through each step in order. Mark checkboxes as complete.

## Context
- **Source**: docs/specs/todo-app-calendar-view.md
- **Size**: FEATURE
- **Risk**: LOW

---

## Step 1: Outer System Test (RED)

- [ ] Write system test: `test "user views tasks on calendar month view"`
  - Create tasks with different due dates
  - Visit calendar, see tasks on correct days

- [ ] Write system test: `test "user switches between calendar views"`
  - Visit calendar, switch to week view, switch to day view

- [ ] RUN: confirm RED

---

## Step 2: Controller + Routes

- [ ] Add route: `get "calendar", to: "calendar#index"`
- [ ] Create CalendarController with index action
- [ ] Write request test for calendar#index

- [ ] RUN: confirm GREEN

---

## Step 3: Month View (Default)

- [ ] Create calendar/index.html.erb with month view layout
- [ ] Build month grid helper (days of month)
- [ ] Display tasks on their due dates
- [ ] Highlight current day
- [ ] Add prev/next month navigation

---

## Step 4: Week + Day Views

- [ ] Add view parameter handling (month/week/day)
- [ ] Create week view layout (7 columns)
- [ ] Create day view layout (single day list)
- [ ] Add view switching buttons
- [ ] Persist view mode during navigation

---

## Step 5: Task Display + Polish

- [ ] Show task title (truncated)
- [ ] Show priority badge
- [ ] Show completion status (strikethrough)
- [ ] Link tasks to detail page
- [ ] Add Calendar link to navigation

---

## Step 6: Wire Up — Outer Tests GREEN

- [ ] RUN system tests: confirm GREEN
- [ ] RUN all tests

- [ ] COMMIT: "feat: add calendar view with month/week/day views"

- [ ] Reviewed
