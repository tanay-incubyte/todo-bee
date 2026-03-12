# TDD Plan: Todo App Phase 1 — Slice 2: Completion Toggle + Visual Polish

## Execution Instructions
Read this plan. Work on every item in order.
Mark each checkbox done as you complete it ([ ] → [x]).

## Context
- **Source**: docs/specs/todo-app-phase-1.md
- **Slice**: 2 — Completion Toggle
- **Risk**: LOW

### Acceptance Criteria (this slice)
- User can mark a task as complete from the task list
- User can mark a completed task as incomplete (toggle back)
- Completion state change is reflected immediately with visual feedback
- Editing preserves the task's completion status

---

## Step 1: Outer System Test (RED)

- [x] Write system test: `test "user toggles task completion from the list"`
  - Create a task, visit index, click the toggle circle, assert visual change
  - Click again, assert it toggles back

- [x] RUN: confirm RED

---

## Step 2: Route + Controller Action

- [x] Add `PATCH /tasks/:id/toggle_complete` route
- [x] Write request test for toggle action
- [x] Implement `toggle_complete` action in TasksController
- [x] RUN: confirm request test GREEN

---

## Step 3: Model Method

- [x] Write model test for `toggle_completion!` method
- [x] Implement on Task model
- [x] RUN: confirm GREEN

---

## Step 4: View — Toggle Button on Index

- [x] Add toggle button (form with PATCH) next to each task in the list
- [x] Ensure Turbo handles the form submission (page reloads with updated state)

---

## Step 5: Wire Up — Outer Test GREEN

- [x] RUN system test: confirm GREEN
- [x] RUN all tests

---

## Step 6: Preserve Completion on Edit

- [x] Write request test: editing a completed task preserves its completed status
- [x] Ensure task_params does NOT include :completed (editing shouldn't change it)
- [x] RUN: confirm GREEN

- [x] COMMIT

- [x] Reviewed
