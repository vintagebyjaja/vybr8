# VYBR8 — Implementation checklist

## Starting instructions (spec §60)
- [x] Inspect repository (new, empty)
- [x] ARCHITECTURE.md · DATABASE.md · PRODUCT.md · ROADMAP.md
- [x] .env.example
- [x] Directory structure proposed (ARCHITECTURE.md)
- [x] Initial database schema proposed (DATABASE.md)
- [x] Integrations needing credentials identified (ARCHITECTURE.md, ROADMAP.md)
- [x] Immediately implementable vs mock-required identified

## Phase 0: Foundation
- [x] package.json with scripts: dev, build, start, typecheck, lint, format, test, test:db, test:e2e, verify
- [x] tsconfig (strict), ESLint flat config, Prettier
- [x] Tailwind v4 with brand tokens
- [x] Supabase clients: browser, server (RSC/actions), session-refreshing proxy
- [x] Env validation with public/server split
- [x] App shell: bottom nav (mobile), side nav (desktop), prominent VYBE action
- [x] Home placeholder with brand, auth pages wired to Supabase
- [x] PWA manifest + icons from the logo
- [x] netlify.toml, supabase/config.toml
- [x] Structured logger with redaction, analytics/error abstractions
- [x] Unit test runner (node:test, zero install) + Playwright config
- [ ] **Run `npm install && npm run verify` on a machine with npm access** (blocked in build workspace)

## Phase 1: Database + Auth
- [x] Enums, helper schema, updated_at trigger
- [x] profiles, user_settings, privacy_settings, user_roles, friendships
- [x] businesses, business_locations, business_members, business_claims, audit_logs
- [x] Sign-up trigger creates profile + settings + privacy rows
- [x] RLS on every table
- [x] Guard triggers on privileged columns
- [x] Admin RPCs: approve/reject business claim (audited)
- [x] Seed framework (fictional, `is_demo = true`)
- [x] SQL security tests pass on Postgres 16
- [ ] Apply to a real Supabase project (`supabase db push`)

## Early domain work
- [x] Ranking engine core (Bayesian confidence, recency, credibility, suspicious penalty, eligibility, explanations) + tests

## Social layer: Plates & Pours + creators
- [x] posts, post_media, post_vybes, post_comments, reports, follows, post_stats view
- [x] team_members (Founder), creator_applications, creator_profiles + staff RPCs (audited)
- [x] Private photo bucket with folder-scoped upload and visibility-scoped reads
- [x] Composer: 1–10 photos, client-side resize (1600px, strips location data), venue tag, score, price, visibility
- [x] Timeline (Following / Creators), Explore creators + Plates/Pours/Spots grid, venue page Plates & Pours under reviews, profile grid with follow
- [x] Creator application (21+ attestation for Liquid Lovers), VYBR8 Team verification on team profiles and /team/creators
- [x] Reporting and moderation
- [x] 60 SQL security assertions, 13 unit tests
- [ ] Push notifications for new followers / comments (Phase 6 notifications)
- [x] Age confirmation at sign-up for all users (birthday, 21+)

## Birthdays + Birthday Perks
- [x] Birthday required at sign-up; under-21 refused in the app and in the database
- [x] Social-login users confirm birthday before using the app
- [x] Daily birthday alerts (week before + day of), idempotent, user can turn off
- [x] In-app alerts page and unread badge
- [x] Birthday Perks page: countdown, "ready for you now", filters, suggestions, team review
- [x] Venue page shows its birthday perks
- [ ] Email / push delivery of alerts (needs an email provider, e.g. Resend, and web push setup)
- [ ] Confirm pg_cron schedule exists in the hosted project (Database → Cron in Supabase)
