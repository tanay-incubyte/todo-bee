# TDD Plan: Todo App Phase 2 — Slice 3: Sidebar Filtering + Sorting

## Execution Instructions
Read this plan. Work on every item in order.
Mark each checkbox done as you complete it ([ ] → [x]).

## Context
- **Source**: docs/specs/todo-app-phase-2.md
- **Slice**: 3 — Sidebar Filtering + Sorting
- **Risk**: LOW
- **Stack**: Ruby on Rails 8, Tailwind CSS, Hotwire (Stimulus)

### Acceptance Criteria (this slice)
- A persistent sidebar appears on the left side of the task list page
- Sidebar shows filter options: by priority, by category, by completion status
- User can select multiple filters at once (e.g., High priority + Work category)
- Active filters are visually indicated in the sidebar
- User can clear all filters with one click
- User can sort tasks by: creation date, due date, or priority
- Sort preference persists during the session
- Sidebar is collapsible on smaller screens

---

## Step 1: Outer System Test (RED)

- [ ] Write system test: `test "user filters tasks using sidebar"`
  - Create tasks with different properties
  - Use sidebar filters to filter by priority and category
  - Assert only matching tasks visible

- [ ] Write system test: `test "user sorts tasks by due date"`
  - Create tasks with different due dates
  - Select sort by due date
  - Assert tasks appear in correct order

- [ ] RUN: confirm RED

---

## Step 2: Layout — Sidebar Structure

- [ ] Update tasks index to use a two-column layout
  - Left: sidebar (filters + sorting)
  - Right: task list

- [ ] Create sidebar partial `_sidebar.html.erb` with:
  - Priority filter section (checkboxes or links)
  - Category filter section (list of categories)
  - Completion filter (All / Active / Completed)
  - Sort options (Creation date / Due date / Priority)
  - Clear all filters button

---

## Step 3: Controller — Multiple Filters + Sorting

- [ ] Write request test: `test "GET /tasks with multiple filters"`
- [ ] Write request test: `test "GET /tasks with completed filter"`
- [ ] Write request test: `test "GET /tasks sorted by due_date"`
- [ ] Write request test: `test "GET /tasks sorted by priority"`

- [ ] Update index action to handle:
  - `completed` param (all/active/completed)
  - `sort` param (created_at/due_date/priority)
  - Multiple filters applied together

- [ ] RUN: confirm controller tests GREEN

---

## Step 4: Model — Sorting Scopes

- [ ] Write model test: `test "by_due_date scope sorts tasks"`
- [ ] Write model test: `test "by_priority_order scope sorts tasks"`

- [ ] Implement scopes:
  - `scope :by_due_date, -> { order(due_date: :asc) }`
  - `scope :by_priority_order, -> { order(Arel.sql("CASE priority WHEN 'high' THEN 1 WHEN 'medium' THEN 2 WHEN 'low' THEN 3 ELSE 4 END")) }`
  - `scope :active, -> { where(completed: false) }`
  - `scope :completed, -> { where(completed: true) }`

- [ ] RUN: confirm GREEN

---

## Step 5: Sidebar UI + Active States

- [ ] Style sidebar with Tailwind
- [ ] Highlight active filters (selected state)
- [ ] Add "Clear all" link that removes all filter params
- [ ] Make sidebar collapsible on mobile (use Stimulus controller)

---

## Step 6: Wire Up — Outer Tests GREEN

- [ ] RUN system tests: confirm GREEN
- [ ] RUN all tests: `bin/rails test && bin/rails test:system`

- [ ] COMMIT: "feat: add sidebar with filters and sorting"

- [ ] Reviewed
