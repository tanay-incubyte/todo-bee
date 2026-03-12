# TDD Plan: Todo App Phase 2 — Slice 1: Priority Levels

## Execution Instructions
Read this plan. Work on every item in order.
Mark each checkbox done as you complete it ([ ] → [x]).

## Context
- **Source**: docs/specs/todo-app-phase-2.md
- **Slice**: 1 — Priority Levels
- **Risk**: LOW
- **Stack**: Ruby on Rails 8, Tailwind CSS, existing Task model

### Acceptance Criteria (this slice)
- User can set a priority (High / Medium / Low) when creating a task
- Priority is optional — defaults to no priority if not selected
- User can change a task's priority when editing
- Task list shows a visual priority indicator (badge or icon) for tasks with priority set
- High priority tasks are visually prominent (e.g., red/orange badge)
- User can filter the task list to show only tasks of a specific priority

---

## Step 1: Outer System Test (RED)

- [x] Write system test: `test "user creates a task with priority and sees priority badge"`
  - Visit new task page, fill in title, select "High" priority
  - Submit, see task in list with a priority badge
  
- [x] Write system test: `test "user filters tasks by priority"`
  - Create tasks with different priorities
  - Use filter to show only High priority
  - Assert only high priority tasks visible

- [x] RUN: confirm RED

---

## Step 2: Migration — Add priority to tasks

- [x] Generate migration: `bin/rails generate migration AddPriorityToTasks priority:string`
- [x] Run migration: `bin/rails db:migrate`

---

## Step 3: Model — Priority validation and scopes

- [x] Write model test: `test "task is valid with priority high"`
- [x] Write model test: `test "task is valid with priority medium"`
- [x] Write model test: `test "task is valid with priority low"`
- [x] Write model test: `test "task is valid without priority"`
- [x] Write model test: `test "task is invalid with unknown priority"`

- [x] Implement validation in Task model:
  - `validates :priority, inclusion: { in: %w[high medium low], allow_blank: true }`

- [x] Write model test: `test "by_priority scope filters tasks"`
- [x] Implement scope: `scope :by_priority, ->(priority) { where(priority: priority) }`

- [x] RUN: confirm model tests GREEN

---

## Step 4: Controller — Filter by priority

- [x] Write request test: `test "GET /tasks with priority filter returns filtered tasks"`
  - Create tasks with different priorities
  - GET /tasks?priority=high
  - Assert response includes only high priority tasks

- [x] Update index action to handle priority filter param
- [x] RUN: confirm request test GREEN

---

## Step 5: Views — Form + Display

- [x] Add priority select field to `_form.html.erb`
  - Options: (none), High, Medium, Low
  
- [x] Update strong params to permit :priority

- [x] Update `index.html.erb` to show priority badge
  - High: red/orange badge
  - Medium: yellow badge  
  - Low: gray/blue badge
  - No priority: no badge

- [x] Add priority filter dropdown above task list (temporary — will move to sidebar in Slice 3)

---

## Step 6: Wire Up — Outer Tests GREEN

- [x] RUN system tests: confirm GREEN
- [x] RUN all tests: `bin/rails test && bin/rails test:system`

- [x] COMMIT: "feat: add priority levels to tasks with filtering"

- [x] Reviewed
