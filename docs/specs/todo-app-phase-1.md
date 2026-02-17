# Spec: Todo App — Phase 1: Clean Task Management

## Overview
A single-user task management app built with Ruby on Rails 8, Tailwind CSS, and Hotwire. Phase 1 delivers the core CRUD experience — creating, viewing, editing, completing, and deleting tasks — with a polished, modern UI suitable for a client demo.

## Acceptance Criteria

### Task Creation
- [ ] User can create a task with a title
- [ ] User can optionally add a description when creating a task
- [ ] User can optionally set a due date when creating a task
- [ ] Title is required — shows an error message if submitted empty
- [ ] After creating a task, user is returned to the task list

### Task List
- [ ] User sees all tasks on the main page, ordered by creation date (newest first)
- [ ] Each task in the list shows its title, due date (if set), and completion status
- [ ] Completed tasks are visually distinguished from incomplete tasks (strikethrough, color change, or label)
- [ ] Overdue tasks (past due date, not completed) are visually distinguished (e.g., red text or badge)
- [ ] Task list is empty-state friendly — shows a helpful message when no tasks exist

### Task Completion
- [ ] User can mark a task as complete from the task list
- [ ] User can mark a completed task as incomplete (toggle back)
- [ ] Completion state change is reflected immediately with visual feedback

### Task Editing
- [ ] User can edit a task's title, description, and due date
- [ ] Editing preserves the task's completion status
- [ ] Shows validation error if title is blanked out during edit

### Task Deletion
- [ ] User can delete a task
- [ ] A confirmation prompt appears before deletion ("Are you sure?")
- [ ] After deletion, user is returned to the task list with the task removed

### Task Detail
- [ ] User can click a task to see its full details (title, description, due date, status)
- [ ] Detail view provides links/buttons to edit or delete the task

### UI and Layout
- [ ] App has a clean, modern layout with consistent spacing and typography (Tailwind CSS)
- [ ] Navigation includes a clear app title/header and a way to create a new task from any page
- [ ] Layout is responsive — usable on desktop and tablet screen sizes
- [ ] Pages use traditional full-page navigation (no SPA behavior)

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
