# TDD Plan: Todo App Phase 2 — Slice 2: Categories

## Execution Instructions
Read this plan. Work on every item in order.
Mark each checkbox done as you complete it ([ ] → [x]).

## Context
- **Source**: docs/specs/todo-app-phase-2.md
- **Slice**: 2 — Categories
- **Risk**: LOW
- **Stack**: Ruby on Rails 8, Tailwind CSS, existing Task model with priority

### Acceptance Criteria (this slice)
- User can create a new category with a name
- User can view a list of all categories
- User can edit a category's name
- User can delete a category (tasks in that category become uncategorized)
- User can assign a task to one category when creating the task
- User can change or remove a task's category when editing
- Task list shows the category name for categorized tasks
- User can filter the task list to show only tasks in a specific category

---

## Step 1: Outer System Test (RED)

- [ ] Write system test: `test "user creates a category and assigns it to a task"`
  - Create a category "Work"
  - Create a task, assign to "Work" category
  - See category name displayed on task list

- [ ] Write system test: `test "user filters tasks by category"`
  - Create categories "Work" and "Personal"
  - Create tasks in each category
  - Filter by "Work", see only Work tasks

- [ ] RUN: confirm RED

---

## Step 2: Category Model

- [ ] Generate model: `bin/rails generate model Category name:string`
- [ ] Run migration

- [ ] Write model test: `test "category is valid with a name"`
- [ ] Write model test: `test "category is invalid without a name"`
- [ ] Implement validation: `validates :name, presence: true`

- [ ] RUN: confirm model tests GREEN

---

## Step 3: Task-Category Association

- [ ] Generate migration: `bin/rails generate migration AddCategoryToTasks category:references`
- [ ] Run migration (with null: true for optional association)

- [ ] Write model test: `test "task can belong to a category"`
- [ ] Write model test: `test "task is valid without a category"`
- [ ] Write model test: `test "deleting category sets task category to nil"`

- [ ] Implement associations:
  - Task: `belongs_to :category, optional: true`
  - Category: `has_many :tasks, dependent: :nullify`

- [ ] Add scope: `scope :by_category, ->(category_id) { where(category_id: category_id) }`

- [ ] RUN: confirm model tests GREEN

---

## Step 4: Categories Controller (CRUD)

- [ ] Generate controller: `bin/rails generate controller Categories`
- [ ] Add resourceful routes: `resources :categories`

- [ ] Write request tests for CRUD:
  - `test "GET /categories returns success"`
  - `test "GET /categories/new returns success"`
  - `test "POST /categories creates a category"`
  - `test "POST /categories with blank name renders error"`
  - `test "GET /categories/:id/edit returns success"`
  - `test "PATCH /categories/:id updates the category"`
  - `test "DELETE /categories/:id destroys the category"`

- [ ] Implement all CRUD actions
- [ ] RUN: confirm controller tests GREEN

---

## Step 5: Categories Views

- [ ] Create index view — list all categories with edit/delete links
- [ ] Create new/edit views with form partial
- [ ] Add "Manage Categories" link to navigation

---

## Step 6: Task Form — Category Selection

- [ ] Add category select to task form
- [ ] Update task_params to permit :category_id
- [ ] Write request test: `test "POST /tasks creates a task with category"`

- [ ] RUN: confirm GREEN

---

## Step 7: Task List — Category Display + Filter

- [ ] Update index view to show category badge on tasks
- [ ] Add category filter dropdown (alongside priority filter)
- [ ] Update TasksController index to handle category filter

- [ ] Write request test: `test "GET /tasks with category filter returns filtered tasks"`

- [ ] RUN: confirm GREEN

---

## Step 8: Wire Up — Outer Tests GREEN

- [ ] RUN system tests: confirm GREEN
- [ ] RUN all tests: `bin/rails test && bin/rails test:system`

- [ ] COMMIT: "feat: add categories for task organization"

- [ ] Reviewed
