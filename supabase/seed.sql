-- ─────────────────────────────────────────────────────────────────────
-- VYBR8 DEVELOPMENT SEED DATA
-- Every person and business below is FICTIONAL and flagged is_demo = true.
-- Addresses use fictional street numbers. Do not load into production.
-- Demo password for all accounts: vybr8-demo-only
-- ─────────────────────────────────────────────────────────────────────

-- Fixed UUIDs keep tests and docs stable.
-- 000…a1 admin · a2 jaja · a3 marcus · a4 tia · a5 chris · a6 owner (claims Ember & Oak)

insert into auth.users (id, instance_id, aud, role, email, encrypted_password, email_confirmed_at, raw_app_meta_data, raw_user_meta_data, created_at, updated_at)
select v.id::uuid, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', v.email,
       extensions.crypt('vybr8-demo-only', extensions.gen_salt('bf')), now(),
       '{"provider":"email","providers":["email"]}',
       jsonb_build_object('username', v.username, 'display_name', v.display_name, 'is_demo', true, 'birthdate', v.birthdate),
       now(), now()
from (values
  ('00000000-0000-4000-8000-0000000000a1', 'admin@demo.vybr8.test',  'demo_admin',  'VYBR8 Admin (demo)',  '1988-03-14'),
  ('00000000-0000-4000-8000-0000000000a2', 'jaja@demo.vybr8.test',   'demo_jaja',   'Jaja (demo)',         '1994-10-05'),
  ('00000000-0000-4000-8000-0000000000a3', 'marcus@demo.vybr8.test', 'demo_marcus', 'Marcus (demo)',       '1991-12-20'),
  ('00000000-0000-4000-8000-0000000000a4', 'tia@demo.vybr8.test',    'demo_tia',    'Tia (demo)',          '1996-02-29'),
  ('00000000-0000-4000-8000-0000000000a5', 'chris@demo.vybr8.test',  'demo_chris',  'Chris (demo)',        '1990-07-04'),
  ('00000000-0000-4000-8000-0000000000a6', 'owner@demo.vybr8.test',  'demo_owner',  'Dana Owner (demo)',   '1985-05-22')
) as v(id, email, username, display_name, birthdate);

update public.profiles set home_city = 'Charlotte', home_region = 'NC' where is_demo;

-- Chris keeps a friends-only profile to exercise privacy rules.
update public.privacy_settings set profile_visibility = 'friends', ratings_visibility = 'friends'
 where user_id = '00000000-0000-4000-8000-0000000000a5';

insert into public.user_roles (user_id, role) values
  ('00000000-0000-4000-8000-0000000000a1', 'admin');

-- Friend graph: Jaja ↔ Marcus, Jaja ↔ Tia, Jaja ↔ Chris (accepted); Marcus → Tia (pending)
insert into public.friendships (requester_id, addressee_id, status, responded_at) values
  ('00000000-0000-4000-8000-0000000000a2', '00000000-0000-4000-8000-0000000000a3', 'accepted', now()),
  ('00000000-0000-4000-8000-0000000000a4', '00000000-0000-4000-8000-0000000000a2', 'accepted', now()),
  ('00000000-0000-4000-8000-0000000000a2', '00000000-0000-4000-8000-0000000000a5', 'accepted', now()),
  ('00000000-0000-4000-8000-0000000000a3', '00000000-0000-4000-8000-0000000000a4', 'pending',  null);

-- Fictional venues in Charlotte, NC
insert into public.businesses (id, slug, name, kind, description, price_level, status, is_claimed, is_demo) values
  ('00000000-0000-4000-9000-0000000000b1', 'ember-and-oak',        'Ember & Oak (demo)',        'restaurant',      'Wood-fired Southern plates and a serious wing program.', 2, 'active', false, true),
  ('00000000-0000-4000-9000-0000000000b2', 'velvet-hour',          'Velvet Hour (demo)',        'cocktail_lounge', 'Low-lit cocktail lounge with a rotating seasonal menu.',  3, 'active', false, true),
  ('00000000-0000-4000-9000-0000000000b3', 'noni-pasta-bar',       'Noni Pasta Bar (demo)',     'restaurant',      'Fresh pasta, Sunday gravy spaghetti, late-night kitchen.', 2, 'active', false, true),
  ('00000000-0000-4000-9000-0000000000b4', 'cloud-nine-hookah',    'Cloud Nine Hookah (demo)',  'hookah_lounge',   'Hookah, small plates, and DJs Thursday to Saturday.',     2, 'active', false, true),
  ('00000000-0000-4000-9000-0000000000b5', 'the-humidor-room',     'The Humidor Room (demo)',   'cigar_lounge',    'Walk-in humidor, bourbon flights, leather chairs.',       3, 'active', false, true),
  ('00000000-0000-4000-9000-0000000000b6', 'saltline-seafood',     'Saltline Seafood (demo)',   'restaurant',      'Fried fish baskets, low-country boils, raw bar.',         2, 'active', false, true),
  ('00000000-0000-4000-9000-0000000000b7', 'rooftop-at-the-crest', 'Rooftop at The Crest (demo)','bar',            'Skyline rooftop with margaritas and a happy hour.',       3, 'pending', false, true);

insert into public.business_locations (business_id, label, address_line1, city, region, postal_code, latitude, longitude, is_primary, is_demo) values
  ('00000000-0000-4000-9000-0000000000b1', 'South End',  '0101 Demo Blvd',   'Charlotte', 'NC', '28203', 35.2120, -80.8590, true, true),
  ('00000000-0000-4000-9000-0000000000b2', 'Uptown',     '0202 Demo St',     'Charlotte', 'NC', '28202', 35.2270, -80.8430, true, true),
  ('00000000-0000-4000-9000-0000000000b3', 'NoDa',       '0303 Demo Ave',    'Charlotte', 'NC', '28205', 35.2460, -80.8120, true, true),
  ('00000000-0000-4000-9000-0000000000b4', 'Plaza Midwood','0404 Demo Rd',   'Charlotte', 'NC', '28205', 35.2210, -80.8100, true, true),
  ('00000000-0000-4000-9000-0000000000b5', 'Ballantyne', '0505 Demo Pkwy',   'Charlotte', 'NC', '28277', 35.0530, -80.8500, true, true),
  ('00000000-0000-4000-9000-0000000000b6', 'Dilworth',   '0606 Demo Ln',     'Charlotte', 'NC', '28203', 35.2050, -80.8490, true, true),
  ('00000000-0000-4000-9000-0000000000b7', 'Uptown',     '0707 Demo Tower',  'Charlotte', 'NC', '28202', 35.2280, -80.8420, true, true);

-- A pending claim from the demo owner, for exercising the admin approval flow.
insert into public.business_claims (id, business_id, claimant_id, claimant_role, evidence) values
  ('00000000-0000-4000-9100-0000000000c1', '00000000-0000-4000-9000-0000000000b1',
   '00000000-0000-4000-8000-0000000000a6', 'Owner', '{"note":"demo claim"}');

-- ─────────────────────────────────────────────────────────────────────
-- VYBR8 Team, creators, Plates & Pours (all demo)
-- ─────────────────────────────────────────────────────────────────────

-- Demo Jaja is the founder and an admin, so the team tools can be tried locally.
insert into public.user_roles (user_id, role) values ('00000000-0000-4000-8000-0000000000a2', 'admin');
insert into public.team_members (user_id, title, bio, position) values
  ('00000000-0000-4000-8000-0000000000a2', 'Founder', 'Started VYBR8 to find the best actual plate in the city. (demo)', 1),
  ('00000000-0000-4000-8000-0000000000a1', 'Community Team', 'Keeps the timeline tasty and honest. (demo)', 2);

-- Tia: verified Big Back. Marcus: verified Liquid Lover. Chris: pending application.
insert into public.creator_applications (id, user_id, creator_type, city, pitch, links, is_21_plus_attested, status, reviewed_by, reviewed_at) values
  ('00000000-0000-4000-9200-0000000000d1', '00000000-0000-4000-8000-0000000000a4', 'big_back', 'Charlotte',
   'I eat my way through every wing spot in Charlotte and post honest ratings. (demo)', '[{"platform":"instagram","url":"https://instagram.com/example"}]', false,
   'approved', '00000000-0000-4000-8000-0000000000a2', now()),
  ('00000000-0000-4000-9200-0000000000d2', '00000000-0000-4000-8000-0000000000a3', 'liquid_lover', 'Charlotte',
   'Cocktail nerd. I rate martinis on strength, balance and presentation. (demo)', '[]', true,
   'approved', '00000000-0000-4000-8000-0000000000a2', now()),
  ('00000000-0000-4000-9200-0000000000d3', '00000000-0000-4000-8000-0000000000a5', 'big_back', 'Charlotte',
   'Seafood and soul food every weekend. Want to share the best fried fish spots. (demo)', '[]', false,
   'pending', null, null);

insert into public.creator_profiles (user_id, creator_type, application_id, verified_by) values
  ('00000000-0000-4000-8000-0000000000a4', 'big_back',     '00000000-0000-4000-9200-0000000000d1', '00000000-0000-4000-8000-0000000000a2'),
  ('00000000-0000-4000-8000-0000000000a3', 'liquid_lover', '00000000-0000-4000-9200-0000000000d2', '00000000-0000-4000-8000-0000000000a2');

insert into public.follows (follower_id, followee_id) values
  ('00000000-0000-4000-8000-0000000000a2', '00000000-0000-4000-8000-0000000000a4'),
  ('00000000-0000-4000-8000-0000000000a2', '00000000-0000-4000-8000-0000000000a3'),
  ('00000000-0000-4000-8000-0000000000a6', '00000000-0000-4000-8000-0000000000a4');

insert into public.posts (id, author_id, kind, business_id, item_name, caption, rating, price_cents, visibility, status, is_demo, created_at) values
  ('00000000-0000-4000-9300-0000000000e1', '00000000-0000-4000-8000-0000000000a4', 'plate', '00000000-0000-4000-9000-0000000000b1', 'Hot Honey Wings',
   'Crispy, sticky, a little heat at the end. Big Back approved. (demo)', 9.4, 1699, 'public', 'published', true, now() - interval '2 hours'),
  ('00000000-0000-4000-9300-0000000000e2', '00000000-0000-4000-8000-0000000000a4', 'plate', '00000000-0000-4000-9000-0000000000b3', 'Sunday Gravy Spaghetti',
   'Portion could feed two. I did not share. (demo)', 9.1, 2200, 'public', 'published', true, now() - interval '1 day'),
  ('00000000-0000-4000-9300-0000000000e3', '00000000-0000-4000-8000-0000000000a3', 'pour', '00000000-0000-4000-9000-0000000000b2', 'Velvet Espresso Martini',
   'Strong, smooth, perfect foam. Liquid Lover certified. (demo)', 9.6, 1600, 'public', 'published', true, now() - interval '5 hours'),
  ('00000000-0000-4000-9300-0000000000e4', '00000000-0000-4000-8000-0000000000a3', 'pour', '00000000-0000-4000-9000-0000000000b4', 'Mango Chili Margarita',
   'Sweet heat. Happy hour price is a steal. (demo)', 8.8, 900, 'public', 'published', true, now() - interval '2 days'),
  ('00000000-0000-4000-9300-0000000000e5', '00000000-0000-4000-8000-0000000000a2', 'spot', '00000000-0000-4000-9000-0000000000b5', null,
   'Leather chairs, low lights, great bourbon list. (demo)', 8.9, null, 'public', 'published', true, now() - interval '3 days'),
  ('00000000-0000-4000-9300-0000000000e6', '00000000-0000-4000-8000-0000000000a5', 'plate', '00000000-0000-4000-9000-0000000000b6', 'Fried Whiting Basket',
   'Friends-only post for privacy testing. (demo)', 8.5, 1400, 'friends', 'published', true, now() - interval '6 hours'),
  ('00000000-0000-4000-9300-0000000000e7', '00000000-0000-4000-8000-0000000000a4', 'plate', '00000000-0000-4000-9000-0000000000b1', 'Five-Cheese Mac',
   'Hidden by moderation for testing. (demo)', 7.0, 900, 'public', 'hidden', true, now() - interval '4 days');

insert into public.post_media (post_id, storage_path, position, width, height, alt_text) values
  ('00000000-0000-4000-9300-0000000000e1', 'demo/plate-wings.webp',      0, 1080, 1080, 'Illustration of glazed wings on a plate (demo)'),
  ('00000000-0000-4000-9300-0000000000e2', 'demo/plate-spaghetti.webp',  0, 1080, 1080, 'Illustration of spaghetti with red sauce (demo)'),
  ('00000000-0000-4000-9300-0000000000e3', 'demo/pour-martini.webp',     0, 1080, 1080, 'Illustration of an espresso martini (demo)'),
  ('00000000-0000-4000-9300-0000000000e4', 'demo/pour-margarita.webp',   0, 1080, 1080, 'Illustration of a mango margarita (demo)'),
  ('00000000-0000-4000-9300-0000000000e5', 'demo/spot-lounge.webp',      0, 1080, 1080, 'Illustration of a dim lounge interior (demo)'),
  ('00000000-0000-4000-9300-0000000000e6', 'demo/plate-fish.webp',       0, 1080, 1080, 'Illustration of a fried fish basket (demo)'),
  ('00000000-0000-4000-9300-0000000000e7', 'demo/plate-mac.webp',        0, 1080, 1080, 'Illustration of mac and cheese (demo)');

insert into public.post_vybes (post_id, user_id) values
  ('00000000-0000-4000-9300-0000000000e1', '00000000-0000-4000-8000-0000000000a2'),
  ('00000000-0000-4000-9300-0000000000e1', '00000000-0000-4000-8000-0000000000a3'),
  ('00000000-0000-4000-9300-0000000000e3', '00000000-0000-4000-8000-0000000000a2');

insert into public.post_comments (post_id, author_id, body) values
  ('00000000-0000-4000-9300-0000000000e1', '00000000-0000-4000-8000-0000000000a2', 'Adding this to Want to Try. (demo)'),
  ('00000000-0000-4000-9300-0000000000e3', '00000000-0000-4000-8000-0000000000a4', 'Saving this for Friday. (demo)');

-- ─────────────────────────────────────────────────────────────────────
-- Birthday Perks (demo venues only; real perks come from businesses and reviewed community tips)
-- ─────────────────────────────────────────────────────────────────────
insert into public.birthday_perks (business_id, title, details, perk_type, redeem_window, requirements, is_alcoholic, source, status, last_confirmed_at, is_demo) values
  ('00000000-0000-4000-9000-0000000000b1', 'Free Hot Honey Wings (6 pc)', 'Six wings on the house with any entrée. (demo)', 'free_food', 'week', 'Show ID · dine-in only', false, 'business', 'active', now() - interval '3 days', true),
  ('00000000-0000-4000-9000-0000000000b3', 'Free tiramisu + candle', 'The staff sings, you eat. (demo)', 'free_food', 'day', 'Show ID', false, 'business', 'active', now() - interval '10 days', true),
  ('00000000-0000-4000-9000-0000000000b2', 'Birthday martini on us', 'Any signature martini, one per guest of honor. (demo)', 'free_drink', 'day', '21+ · show ID', true, 'business', 'active', now() - interval '5 days', true),
  ('00000000-0000-4000-9000-0000000000b4', '50% off a hookah', 'Half off one hookah for the birthday table. (demo)', 'discount', 'week', 'Party of 4+ · show ID', false, 'community', 'active', now() - interval '20 days', true),
  ('00000000-0000-4000-9000-0000000000b5', 'Complimentary bourbon pour', 'A 1 oz pour from the house list. (demo)', 'free_drink', 'month', '21+ · members only', true, 'business', 'active', now() - interval '40 days', true),
  ('00000000-0000-4000-9000-0000000000b6', '20% off your bill', 'For the whole table on your birthday. (demo)', 'discount', 'day', 'Show ID · up to 6 guests', false, 'community', 'pending', null, true);
