import Link from "next/link";
import { notFound } from "next/navigation";
import { PerkCard } from "@/components/birthday/PerkCard";
import { PostButton } from "@/components/posts/PostButton";
import { PostGrid } from "@/components/posts/PostGrid";
import { DemoBadge } from "@/components/ui/DemoBadge";
import { createClient } from "@/lib/supabase/server";
import { getViewer } from "@/server/auth";
import { getBirthdayPerks } from "@/server/birthday";
import { getFeed } from "@/server/posts";

type Params = { params: Promise<{ slug: string }> };

const KIND_LABEL: Record<string, string> = {
  restaurant: "Restaurant", bar: "Bar", cocktail_lounge: "Cocktail lounge", lounge: "Lounge", cigar_lounge: "Cigar lounge",
  hookah_lounge: "Hookah lounge", cafe: "Café", bakery: "Bakery", food_truck: "Food truck", brewery: "Brewery", nightlife: "Nightlife",
};

async function loadVenue(slug: string) {
  const supabase = await createClient();
  const { data } = await supabase
    .from("businesses")
    .select("id, slug, name, kind, description, price_level, website, is_demo, locations:business_locations ( label, city, region, is_primary )")
    .eq("slug", slug)
    .is("deleted_at", null)
    .maybeSingle();
  return data;
}

export async function generateMetadata({ params }: Params) {
  const venue = await loadVenue((await params).slug);
  return { title: venue?.name ?? "Venue" };
}

export default async function VenuePage({ params }: Params) {
  const { slug } = await params;
  const venue = await loadVenue(slug);
  if (!venue) notFound();
  const [viewer, page, perks] = await Promise.all([
    getViewer(),
    getFeed({ kind: "business", businessId: venue.id as string }),
    getBirthdayPerks({ businessId: venue.id as string }),
  ]);
  const locations = (venue.locations ?? []) as { label: string | null; city: string; region: string; is_primary: boolean }[];
  const primary = locations.find((l) => l.is_primary) ?? locations[0];
  const plates = page.posts.filter((p) => p.kind === "plate").length;
  const pours = page.posts.filter((p) => p.kind === "pour").length;

  return (
    <article className="flex flex-col gap-10">
      <header className="flex flex-col gap-3">
        <div className="flex flex-wrap items-center gap-2 text-xs font-semibold uppercase tracking-[0.18em] text-faint">
          <span>{KIND_LABEL[venue.kind as string] ?? venue.kind}</span>
          {venue.price_level && <span aria-label={`Price level ${venue.price_level} of 4`}>· {"$".repeat(venue.price_level as number)}</span>}
          {primary && <span>· {primary.label ? `${primary.label}, ` : ""}{primary.city}, {primary.region}</span>}
          {venue.is_demo && <DemoBadge label="Demo venue" />}
        </div>
        <h1 className="text-4xl font-extrabold">{venue.name}</h1>
        {venue.description && <p className="max-w-prose text-muted">{venue.description}</p>}
        <div className="flex flex-wrap gap-3 pt-1">
          <PostButton href={viewer ? `/post/new?venue=${venue.slug}` : `/auth/sign-in?next=/post/new?venue=${venue.slug}`} label="Post your plate here" />
          {venue.website && (
            <a href={venue.website as string} target="_blank" rel="noopener noreferrer" className="inline-flex min-h-11 items-center rounded-full border border-line px-5 text-sm font-bold hover:bg-surface-2">
              Website
            </a>
          )}
        </div>
      </header>

      <section aria-labelledby="reviews-h" className="flex flex-col gap-3">
        <h2 id="reviews-h" className="text-xl font-bold">Ratings &amp; reviews</h2>
        <div className="rounded-[var(--radius-card)] vybe-ring p-5 text-sm text-muted">
          Dish-by-dish VYBR8 scores, Service Vybe and Aesthetic ratings arrive with item ratings (Phase 3). Until then, the plates and pours people post below are the best guide.
        </div>
      </section>

      {perks.length > 0 && (
        <section aria-labelledby="perks-h" className="flex flex-col gap-3">
          <div className="flex flex-wrap items-baseline justify-between gap-2">
            <h2 id="perks-h" className="text-xl font-bold">Birthday perks</h2>
            <Link href="/birthday" className="text-sm font-semibold text-sky hover:underline">All birthday perks</Link>
          </div>
          <ul className="grid gap-3 sm:grid-cols-2">
            {perks.map((p) => <li key={p.id}><PerkCard perk={p} showVenue={false} /></li>)}
          </ul>
        </section>
      )}

      <section aria-labelledby="plates-h" className="flex flex-col gap-3">
        <div className="flex flex-wrap items-baseline justify-between gap-2">
          <h2 id="plates-h" className="text-xl font-bold">Plates &amp; Pours</h2>
          <p className="text-sm text-muted tabular-nums">{plates} plates · {pours} pours</p>
        </div>
        <PostGrid
          posts={page.posts}
          empty={<>No one has posted from here yet. <Link href={`/post/new?venue=${venue.slug}`} className="font-semibold text-sky">Be the first</Link></>}
        />
      </section>
    </article>
  );
}
