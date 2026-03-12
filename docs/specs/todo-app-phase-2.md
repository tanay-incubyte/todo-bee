# Spec: Todo App — Phase 2: Rich Task Organization

## Overview
Extend the task management app with priority levels, categories, and a sidebar-based filtering system. Users can organize tasks by importance and group them into categories, then filter the task list using a persistent sidebar.

## Slice 1: Priority Levels
- [x] User can set a priority (High / Medium / Low) when creating a task
- [x] Priority is optional — defaults to no priority if not selected
- [x] User can change a task's priority when editing
- [x] Task list shows a visual priority indicator (badge or icon) for tasks with priority set
- [x] High priority tasks are visually prominent (e.g., red/orange badge)
- [x] User can filter the task list to show only tasks of a specific priority

## Slice 2: Categories
- [x] User can create a new category with a name
- [x] User can view a list of all categories
- [x] User can edit a category's name
- [x] User can delete a category (tasks in that category become uncategorized)
- [x] User can assign a task to one category when creating the task
- [x] User can change or remove a task's category when editing
- [x] Task list shows the category name for categorized tasks
- [x] User can filter the task list to show only tasks in a specific category

## Slice 3: Sidebar Filtering + Sorting
- [ ] A persistent sidebar appears on the left side of the task list page
- [ ] Sidebar shows filter options: by priority, by category, by completion status
- [ ] User can select multiple filters at once (e.g., High priority + Work category)
- [ ] Active filters are visually indicated in the sidebar
- [ ] User can clear all filters with one click
- [ ] User can sort tasks by: creation date, due date, or priority
- [ ] Sort preference persists during the session
- [ ] Sidebar is collapsible on smaller screens

## Data Model (indicative)

```
Task (existing):
  + priority: string (enum: high, medium, low, null)
  + category_id: integer (foreign key, nullable)

Category (new):
  - id: integer
  - name: string (required)
  - timestamps
```

## Out of Scope
- Tags (deferred — categories cover grouping needs for now)
- Drag-and-drop reordering
- Bulk priority/category assignment
- Category colors or icons
- Saved filter presets

## Technical Context
- **Stack**: Ruby on Rails 8, Tailwind CSS, Hotwire (Turbo + Stimulus)
- **Patterns**: MVC, RESTful routes, existing Task model
- **Risk level**: LOW — building on stable Phase 1 foundation
- **Key integration**: Extends existing TasksController and Task model
