# VYBR8 — Product

**Pronounced:** "vibrate" · **Tagline:** EAT • DRINK • LINK UP
**Voice lines:** Eat Your Vybe. · What's Your Vybe? · Find My Vybe. · How Was the Vybe?

## The one question

> "What should I / we eat, drink, or do tonight?"

Traditional review platforms answer *"Is this restaurant good?"*
VYBR8 answers: **"Who has the best actual thing I want, will I like it, can my friends find something too, and does it fit what we're trying to spend and do tonight?"**

Every feature decision is checked against that sentence (spec §59).

## Differentiators (in priority order)

1. **Item-level ratings.** People rate the Hot Honey Wings, not just the restaurant. Category scores fit the item type (a cocktail gets Strength; wings get Portion).
2. **Group Vybe.** Given a Link Up's attendees, tonight's budgets, restrictions and intent, rank venues and *explain* both matches and exclusions, down to "what each person might order."
3. **VYBR8 Charts.** Credible, confidence-weighted leaderboards (Top Wings in Charlotte) that paid promotion cannot move.
4. **Taste profiles and Taste Match.** Explicit and inferred preferences, always labeled as which.
5. **Venue experience separate from food.** Service Vybe (Vibe Check), Aesthetic, Bartender Vybe, Crowd Vybe.
6. **Health-aware, not health-first.** Nutrition and Active Vybe are opt-in context. Big Back Mode is a first-class toggle.

## Age rules

- VYBR8 is for everyone **13 and older** (birthday required at sign-up).
- **Alcohol is 21+**: posting or seeing drink posts marked "Contains alcohol", drink birthday perks, and becoming a **Liquid Lover** (or Both) creator. Signed-out visitors don't see alcohol content either.
- Non-alcoholic drinks (coffee, smoothies, mocktails, boba) are open to everyone 13+.
- Enforced in the app and again in the database (`supabase/migrations/20260929000400_age_rules.sql`).

## Plates & Pours (the timeline)

Anyone can post a **Plate** (a dish), a **Pour** (a drink) or a **Spot** (the place itself) with up to 10 photos, an optional VYBR8 score and price. Posts appear on the author's profile grid, friends' and followers' timelines, and under the venue's reviews. People can vybe (like), comment and report.

**Verified creators** are VYBR8's featured posters:
- **Big Back**: food creators
- **Liquid Lover**: drink creators (21+ only)

People apply from Explore or their profile. The VYBR8 Team (Founder and team, admins and moderators) verifies them from the queue under their own profile or at `/team/creators`. Verified creators get a badge, a spot on Explore, and their posts in everyone's Creators timeline.

## Roles

| Role | Summary | Hard limits |
|---|---|---|
| Consumer | Discover, rate, save, befriend, plan Link Ups, run Group Vybe, manage health and budgets | Cannot see others' private data |
| Business member (owner / manager / staff) | Manage verified venue profile, menus, prices, hours, specials; view aggregate analytics; respond where allowed | Cannot edit or delete consumer ratings, cannot touch ranking scores, cannot buy organic rank |
| Admin / moderator | Moderation, claim verification, duplicates, suspicious ratings, promotions, ranking eligibility, settings | All admin checks are enforced server-side and in RLS, never by hidden UI |

## Trust rules (non-negotiable)

- Mock or demo data is always labeled as such in the UI (`is_demo` column plus a `DemoBadge` component).
- Provider data (delivery, reservations, prices, nutrition) always shows source and freshness.
- Sponsored placement is labeled and stored apart from organic ranking data.
- Nutrition values carry a provenance: `verified`, `provider`, or `estimated`. Estimates are never presented as medical fact.
- Ownership and identity badges (Black-owned, woman-owned, veteran-owned) come from verified or business-declared structured data. They are never inferred.
- Group Vybe explanations reveal the minimum necessary. A private dietary or health restriction can surface as "limited options for one group member."
- Deterministic code (not an LLM) decides permissions, payments, rankings, budgets, and hard dietary exclusions.

## Plans

| | Free | VYBR8+ ($6.99/mo · $49.99/yr) | VYBR8 MAX ($9.99/mo · $79.99/yr) |
|---|---|---|---|
| Discovery, map, menus, filters | Basic | Advanced filters | Advanced filters |
| Rate dishes, drinks, venues | ✓ (never paywalled) | ✓ | ✓ |
| Saves, Want to Try, friends, Link Ups | ✓ | ✓ | ✓ |
| Group Vybe | Basic | Deeper | Deeper |
| Big Back Mode | ✓ | ✓ | ✓ |
| Nutrition | Basic | Detailed, custom macros | Detailed + adaptive meal planning |
| Ads | Yes | None | None |

Prices are targets, configured in Stripe and the `plans` table, never hard-coded in UI logic. Business plans are not priced yet; only the entitlement architecture exists.

## MVP scope (spec §58)

Accounts → venue discovery → restaurants/bars/lounges → menus → item ratings → service and aesthetic ratings → Charts → saves → friend profiles and preferences → Link Ups → Group Vybe → budget matching → explainable exclusions → basic business dashboard.

Health beyond basic preferences, billing, and external providers follow the MVP.

## Vybe Map and Link Ups

**Vybe Map (Home, signed in).** The VYBR8 frequency drawn as a living contour map of the user's city. Users pick from the 7 launch cities. Pins show each place's logo (green dot = open now), the latest plate or pour photo, Link Ups with spots left, and friends who set a vybe. Filters: All, Open now, Food, Drinks, Link Ups, Friends. Alcohol photos and drinks Link Ups only appear for people 21+.

**What's your vybe?** Eat, Drink (21+) or Link Up, with an optional note, for 1–12 hours. Only friends see it.

**Link Ups.** A host picks the occasion (girls night out, brunch, meet new friends…), place or meeting point, time in city time, and 2–10 spots including themselves. Visibility is public, friends or invite-only; joining is open or host-approved. "Open to new friends" lists it under Meet new friends. Drinks Link Ups are 21+ for everyone, guests included.

**Guest invites.** Hosts make a private link per guest. The guest sees the details, RSVPs with name and birthday (age check only, deleted after the event), takes a spot, and joins the group chat without an account.

**Group chat.** Opens for everyone going. It disappears at the end time; messages are permanently deleted within 10 minutes.

## 21st-birthday early access (Pours)
Starting 5 days before their 21st birthday, members can see, vybe, comment on and review alcohol posts, and see drink birthday perks, so they can plan where to celebrate. Explore shows a countdown and a reminder that places only serve 21+. Liquid Lover verification and drinks Link Ups stay strictly 21+. Bars and lounges themselves are visible to everyone. Enforced in the database by `private.user_has_pour_access` (migration 20260930000400).

## Drinks Link Ups on your 21st
Drinks Link Ups are judged on the day of the event (in the city's time zone), not the day you RSVP. Someone turning 21 can plan their 21st birthday night ahead of time; only people who are 21 by that day can see, join, be invited or RSVP as a guest. A host can't move a drinks Link Up earlier than anyone's 21st birthday. Migration 20260930000500.
