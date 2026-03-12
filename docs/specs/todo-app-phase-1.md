# Spec: Todo App — Phase 1: Clean Task Management

## Overview
A single-user task management app built with Ruby on Rails 8, Tailwind CSS, and Hotwire. Phase 1 delivers the core CRUD experience — creating, viewing, editing, completing, and deleting tasks — with a polished, modern UI suitable for a client demo.

## Acceptance Criteria

### Task Creation
- [x] User can create a task with a title
- [x] User can optionally add a description when creating a task
- [x] User can optionally set a due date when creating a task
- [x] Title is required — shows an error message if submitted empty
- [x] After creating a task, user is returned to the task list

### Task List
- [x] User sees all tasks on the main page, ordered by creation date (newest first)
- [x] Each task in the list shows its title, due date (if set), and completion status
- [x] Completed tasks are visually distinguished from incomplete tasks (strikethrough, color change, or label)
- [x] Overdue tasks (past due date, not completed) are visually distinguished (e.g., red text or badge)
- [x] Task list is empty-state friendly — shows a helpful message when no tasks exist

### Task Completion
- [x] User can mark a task as complete from the task list
- [x] User can mark a completed task as incomplete (toggle back)
- [x] Completion state change is reflected immediately with visual feedback

### Task Editing
- [x] User can edit a task's title, description, and due date
- [x] Editing preserves the task's completion status
- [x] Shows validation error if title is blanked out during edit

### Task Deletion
- [x] User can delete a task
- [x] A confirmation prompt appears before deletion ("Are you sure?")
- [x] After deletion, user is returned to the task list with the task removed

### Task Detail
- [x] User can click a task to see its full details (title, description, due date, status)
- [x] Detail view provides links/buttons to edit or delete the task

### UI and Layout
- [x] App has a clean, modern layout with consistent spacing and typography (Tailwind CSS)
- [x] Navigation includes a clear app title/header and a way to create a new task from any page
- [x] Layout is responsive — usable on desktop and tablet screen sizes
- [x] Pages use traditional full-page navigation (no SPA behavior)

## Data Model (indicative)

```
Task:
  - title: string (required)
  - description: text (optional)
  - due_date: date (optional)
  - completed: boolean (default: false)
  - timestamps (created_at, updated_at)
```

## Out of Scope
- User authentication or multi-user support
- Priority levels, categories, tags (Phase 2)
- Filtering or sorting controls (Phase 2)
- Reminders or notifications (Phase 3)
- Drag-and-drop reordering
- Bulk actions (complete all, delete all)

## Technical Context
- **Stack**: Ruby on Rails 8, Tailwind CSS, Hotwire (Turbo + Stimulus), Import Maps
- **Greenfield**: Yes — new Rails app, no existing code
- **Patterns to follow**: Rails 8 conventions, RESTful resourceful routes
- **Risk level**: LOW — learning exercise / POC, no production data concerns

- [x] Reviewed
