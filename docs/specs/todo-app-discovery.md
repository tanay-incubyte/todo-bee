# Discovery: Todo App

## Why
This is a learning exercise to explore Ruby on Rails' latest features hands-on, with the added goal of turning the result into a polished prototype that can be demoed to a client. The motivation is dual: build real skill with modern Rails, and produce something presentable enough to show stakeholders.

## Who
- **Single user** (for now) — someone managing their own tasks day-to-day. No authentication, no multi-tenancy.
- **Future**: Multiple users, each with their own account and task list. This is explicitly out of scope for the first build but should not be made painful to add later.

## Success Criteria
- A clean, modern task management experience that feels professional enough to demo to a client.
- The app uses Rails' latest features and conventions (not legacy patterns).
- Tasks can be created, viewed, edited, completed, and deleted with a polished UI.
- The codebase is structured so adding authentication and multi-user support later is straightforward — not a rewrite.

## Problem Statement
The builder wants to learn modern Rails by building something real and useful — a todo app. The twist: it needs to double as a client-facing prototype. That means it can't look like a tutorial project. It needs clean design, modern UI patterns, and enough structure that it can grow into a multi-user product without starting over.

## Hypotheses
- H1: Rails' built-in tooling (Hotwire, Turbo, Stimulus, import maps) is sufficient for a modern, snappy task management UI without heavy JavaScript frameworks.
- H2: A single-user todo app can be structured with a `User`-aware data model from the start, so adding authentication later is a minor addition rather than a migration headache.
- H3: Traditional page-by-page navigation with modern CSS and subtle interactivity is enough to impress a client — no SPA needed.

## Out of Scope
- User authentication and multi-user support (Phase 1)
- Single-page app behavior or heavy client-side JavaScript
- Real-time collaboration or sharing
- Mobile-native app (web only)
- Deployment and infrastructure concerns
- Reminders / notifications (deferred to later phase)
- Tags, categories, priorities (deferred to Phase 2)
- Due dates moved to Phase 1

## Milestone Map

### Phase 1: Clean Task Management (the walking skeleton)
- Create, view, edit, and delete tasks
- Mark tasks as complete / incomplete
- Modern, polished UI with clean typography, spacing, and layout
- Traditional page navigation with latest Rails conventions
- Responsive design that looks good on desktop and tablet

### Phase 2: Rich Task Organization
- Due dates on tasks
- Priority levels (e.g., high, medium, low)
- Categories or lists to group tasks
- Tags for flexible cross-cutting organization
- Filtering and sorting by date, priority, category

### Phase 3: Multi-User and Beyond
- User authentication (sign up, log in, log out)
- Per-user task lists (data isolation)
- Reminders and notifications (email or in-app)
- Any additional features surfaced by client feedback

## Resolved Questions
- **Scalability path**: Keep Phase 1 clean with no `user_id` column. Add a `User` model and foreign key via migration in Phase 3 when authentication is introduced. For a POC with small data, the backfill is trivial.
- **CSS framework**: Tailwind CSS. Rails 8 has first-class support (`rails new --css tailwind`). Balances speed of polish with real CSS understanding — not too abstract, not too "Bootstrap-y."
- **JS approach**: Hotwire (Turbo + Stimulus) — the Rails default. Sufficient for all interactions across Phase 1 (CRUD, mark complete) and Phase 2 (filtering, sorting, inline updates). No additional JS framework needed.

## Revised Assessment
Size: FEATURE (Phase 1 alone is a focused, well-scoped feature; the full vision across all phases is an EPIC)
Greenfield: yes

- [x] Reviewed
