# TDD Plan: Todo App Phase 1 — Slice 1: Task Model + CRUD

## Execution Instructions
Read this plan. Work on every item in order.
Mark each checkbox done as you complete it ([ ] → [x]).
Continue until all items are done.
If stuck after 3 attempts, mark ⚠️ and move to the next independent step.

## Context
- **Source**: docs/specs/todo-app-phase-1.md
- **Slice**: 1 — Task Model + CRUD (the walking skeleton)
- **Risk**: LOW
- **Stack**: Ruby on Rails 8, Tailwind CSS, Hotwire (Turbo + Stimulus), SQLite (dev default)

### Acceptance Criteria (this slice)
- User can create a task with a title
- User can optionally add a description when creating a task
- User can optionally set a due date when creating a task
- Title is required — shows an error message if submitted empty
- After creating a task, user is returned to the task list
- User sees all tasks on the main page, ordered by creation date (newest first)
- Each task in the list shows its title, due date (if set), and completion status
- User can click a task to see its full details (title, description, due date, status)
- Detail view provides links/buttons to edit or delete the task
- User can edit a task's title, description, and due date
- Shows validation error if title is blanked out during edit
- User can delete a task
- A confirmation prompt appears before deletion ("Are you sure?")
- After deletion, user is returned to the task list with the task removed
- App has a clean, modern layout with consistent spacing and typography (Tailwind CSS)
- Navigation includes a clear app title/header and a way to create a new task from any page

---

## Step 0: Project Setup

- [ ] **Generate Rails app**: `rails new todo --css tailwind` (creates Rails 8 app with Tailwind CSS, Hotwire is included by default)
- [ ] **Verify setup**: Run `bin/rails server` and confirm the Rails welcome page loads
- [ ] **Verify test setup**: Run `bin/rails test` — should pass with 0 tests, 0 failures
- [ ] **COMMIT**: "chore: initialize Rails 8 app with Tailwind CSS"

---

## Step 1: Outer Test — System Test (User creates and views a task)

**Write this test FIRST. It stays RED until model, controller, routes, and views are built.**

The outer test covers the core user journey: create a task, see it in the list, click to see details.

- [ ] **RED**: Write system test
  - Location: `test/system/tasks_test.rb`
  - Test name: `test "user creates a task and sees it in the list"`
  - Flow:
    1. Visit the tasks index page
    2. Click "New Task" (or similar link)
    3. Fill in title: "Buy groceries"
    4. Fill in description: "Milk, eggs, bread"
    5. Select a due date
    6. Submit the form
    7. Assert: redirected to task list, "Buy groceries" visible on the page
    8. Click on "Buy groceries"
    9. Assert: detail page shows title, description, and due date

- [ ] **RUN**: Confirm test FAILS (route/page doesn't exist yet)
- [ ] **COMMIT**: "test: add outer system test for task creation and viewing"

---

## Step 2: Model Layer — Task Model + Migration

### 2.1 Model Test: Validations

- [ ] **RED**: Write model test
  - Location: `test/models/task_test.rb`
  - Test: `test "task is valid with a title"`
    - Create a Task with title: "Test task" → assert valid
  - Test: `test "task is invalid without a title"`
    - Create a Task with title: nil → assert not valid, errors on :title
  - Test: `test "task is valid without a description"`
    - Create a Task with title: "Test", description: nil → assert valid
  - Test: `test "task is valid without a due date"`
    - Create a Task with title: "Test", due_date: nil → assert valid
  - Test: `test "completed defaults to false"`
    - Create a Task with title: "Test" → assert completed is false

- [ ] **RUN**: Confirm tests FAIL (Task model doesn't exist)

### 2.2 Generate Model + Migration

- [ ] **GREEN**: Generate the Task model
  - Run: `bin/rails generate model Task title:string description:text due_date:date completed:boolean`
  - Edit migration: set `completed` default to `false`, add `null: false` to `title`
  - Run: `bin/rails db:migrate`
  - Add validation to Task model: `validates :title, presence: true`

- [ ] **RUN**: Confirm model tests PASS

### 2.3 Model Test: Default ordering

- [ ] **RED**: Write test
  - Test: `test "tasks are ordered by creation date, newest first"`
    - Create task A, then task B → Task.newest_first returns [B, A]

- [ ] **GREEN**: Add scope to Task model
  - `scope :newest_first, -> { order(created_at: :desc) }`

- [ ] **RUN**: Confirm test PASSES

- [ ] **COMMIT**: "feat(model): Task model with validations and default ordering"

---

## Step 3: Controller + Routes Layer

### 3.1 Request Test: Index action

- [ ] **RED**: Write request test
  - Location: `test/controllers/tasks_controller_test.rb`
  - Test: `test "GET /tasks returns success"`
    - GET /tasks → assert response :success

- [ ] **GREEN**: Generate controller and routes
  - Add `resources :tasks` to `config/routes.rb`
  - Set root route: `root "tasks#index"`
  - Create `TasksController` with `index` action
  - `index` action: `@tasks = Task.newest_first`
  - Create minimal view: `app/views/tasks/index.html.erb` (list tasks)

- [ ] **RUN**: Confirm test PASSES

### 3.2 Request Test: Show action

- [ ] **RED**: Write test
  - Test: `test "GET /tasks/:id returns success"`
    - Create a task, GET /tasks/:id → assert response :success

- [ ] **GREEN**: Implement
  - `show` action: `@task = Task.find(params[:id])`
  - Create view: `app/views/tasks/show.html.erb` (display task details + edit/delete links)

- [ ] **RUN**: Confirm test PASSES

### 3.3 Request Test: New + Create actions

- [ ] **RED**: Write tests
  - Test: `test "GET /tasks/new returns success"`
    - GET /tasks/new → assert response :success
  - Test: `test "POST /tasks creates a task and redirects"`
    - POST /tasks with valid params → assert task created, redirected to tasks_path
  - Test: `test "POST /tasks with blank title renders errors"`
    - POST /tasks with title: "" → assert response :unprocessable_entity

- [ ] **GREEN**: Implement
  - `new` action: `@task = Task.new`
  - `create` action: build task from params, save, redirect on success, render :new on failure
  - Create view: `app/views/tasks/new.html.erb` (form with title, description, due_date fields)
  - Create shared partial: `app/views/tasks/_form.html.erb`
  - Add strong params: `task_params` method allowing :title, :description, :due_date

- [ ] **RUN**: Confirm tests PASS

### 3.4 Request Test: Edit + Update actions

- [ ] **RED**: Write tests
  - Test: `test "GET /tasks/:id/edit returns success"`
    - Create a task, GET /tasks/:id/edit → assert response :success
  - Test: `test "PATCH /tasks/:id updates the task and redirects"`
    - Create a task, PATCH with new title → assert title changed, redirected
  - Test: `test "PATCH /tasks/:id with blank title renders errors"`
    - PATCH with title: "" → assert response :unprocessable_entity

- [ ] **GREEN**: Implement
  - `edit` action: `@task = Task.find(params[:id])`
  - `update` action: find task, update, redirect on success, render :edit on failure
  - Create view: `app/views/tasks/edit.html.erb` (reuse _form partial)

- [ ] **RUN**: Confirm tests PASS

### 3.5 Request Test: Destroy action

- [ ] **RED**: Write tests
  - Test: `test "DELETE /tasks/:id destroys the task and redirects"`
    - Create a task, DELETE /tasks/:id → assert task count decreased, redirected to tasks_path

- [ ] **GREEN**: Implement
  - `destroy` action: find task, destroy, redirect to tasks_path

- [ ] **RUN**: Confirm tests PASS

- [ ] **COMMIT**: "feat(controller): TasksController with full CRUD actions"

---

## Step 4: Views + Layout with Tailwind

### 4.1 Application Layout

- [ ] **Implement application layout** (`app/views/layouts/application.html.erb`)
  - App header with title ("Todo App" or similar) using Tailwind typography classes
  - "New Task" link/button visible in the header or navigation area
  - Clean container with max-width, centered, consistent padding
  - Use Tailwind utility classes for modern, clean look

### 4.2 Task List View (index)

- [ ] **Implement index view** (`app/views/tasks/index.html.erb`)
  - Display each task as a card or list item
  - Show: title, due date (if set), completion status indicator
  - Each task links to its show page
  - "New Task" button prominently placed

### 4.3 Task Form (shared partial)

- [ ] **Implement form partial** (`app/views/tasks/_form.html.erb`)
  - Title field (text input, required)
  - Description field (textarea, optional)
  - Due date field (date picker, optional)
  - Submit button with Tailwind styling
  - Error messages displayed above form when validation fails (red text, clear message)

### 4.4 Task Detail View (show)

- [ ] **Implement show view** (`app/views/tasks/show.html.erb`)
  - Display: title, description (if present), due date (if set), completion status
  - Edit button/link
  - Delete button/link with `data-turbo-confirm: "Are you sure?"` for confirmation prompt
  - Back to list link

### 4.5 New + Edit Views

- [ ] **Implement new.html.erb**: heading + render form partial
- [ ] **Implement edit.html.erb**: heading + render form partial

- [ ] **COMMIT**: "feat(views): task views with Tailwind styling and layout"

---

## Step 5: Wiring — Run Outer Test

- [ ] **RUN OUTER SYSTEM TEST**: `bin/rails test:system`
  - The system test from Step 1 should now PASS
  - If it fails, debug and fix (likely CSS selector or link text mismatch)

- [ ] **RUN ALL TESTS**: `bin/rails test && bin/rails test:system`
  - All model, controller, and system tests pass

- [ ] **COMMIT**: "feat: wire task CRUD — all tests green"

---

## Step 6: Edge Cases (LOW risk — minimal)

- [ ] **System test: delete confirmation**
  - Test: `test "user sees confirmation before deleting a task"`
    - Visit task show page, click delete, confirm dialog appears
    - Note: Turbo's `data-turbo-confirm` handles this; system test verifies it works

- [ ] **System test: create with missing title shows error**
  - Test: `test "user sees error when creating task without title"`
    - Visit new task page, leave title blank, submit
    - Assert: error message visible on page

- [ ] **System test: edit to blank title shows error**
  - Test: `test "user sees error when editing task to blank title"`
    - Create a task, visit edit page, clear title, submit
    - Assert: error message visible on page

- [ ] **RUN ALL TESTS**: Confirm everything passes

- [ ] **COMMIT**: "test: edge case system tests for validation and delete confirmation"

---

## Final Verification

- [ ] **All tests green**: `bin/rails test && bin/rails test:system`
- [ ] **Manual check**: Start server (`bin/rails server`), walk through:
  - Create a task with title, description, and due date
  - See it in the list
  - Click into detail view
  - Edit it
  - Delete it (confirm dialog appears)
  - Create a task without a title (error message appears)

## Test Summary
| Layer | Type | # Tests | Status |
|-------|------|---------|--------|
| Outer (System) | System | 4 | ✅ |
| Model | Unit | 5 | ✅ |
| Controller | Request | 9 | ✅ |
| **Total** | | **18** | ✅ |

- [x] Reviewed
