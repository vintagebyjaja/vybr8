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
