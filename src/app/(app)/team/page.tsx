import Link from "next/link";
import { TeamBadge } from "@/components/posts/Badges";
import { createClient } from "@/lib/supabase/server";
import { getViewer } from "@/server/auth";

export const metadata = { title: "VYBR8 Team" };

export default async function TeamPage() {
  const supabase = await createClient();
  const [viewer, { data }] = await Promise.all([
    getViewer(),
    supabase.from("team_members").select("title, bio, position, profile:profiles!team_members_user_id_fkey ( username, display_name )").order("position"),
  ]);
  const members = (data ?? []).map((m) => ({ ...m, profile: (Array.isArray(m.profile) ? m.profile[0] : m.profile) as { username: string; display_name: string | null } | null }));

  return (
    <div className="flex flex-col gap-8">
      <header>
        <h1 className="text-3xl font-bold">The VYBR8 Team</h1>
        <p className="mt-1 text-muted">The people who verify creators and keep the timeline tasty and honest.</p>
      </header>
      {viewer?.platformRoles.length ? (
        <Link href="/team/creators" className="vybe-ring self-start rounded-full px-5 py-2.5 text-sm font-bold">Open creator verification →</Link>
      ) : null}
      <ul className="grid gap-3 sm:grid-cols-2">
        {members.map((m) => m.profile && (
          <li key={m.profile.username}>
            <Link href={`/profile/${m.profile.username}`} className="flex gap-4 rounded-[var(--radius-card)] border border-line bg-surface p-5 hover:bg-surface-2">
              <span aria-hidden className="vybe-gradient grid size-14 shrink-0 place-items-center rounded-full font-display text-2xl font-extrabold text-ink">
                {(m.profile.display_name ?? m.profile.username).slice(0, 1).toUpperCase()}
              </span>
              <span className="flex min-w-0 flex-col gap-1">
                <span className="font-bold">{m.profile.display_name ?? m.profile.username}</span>
                <TeamBadge title={m.title as string} />
                {m.bio && <span className="text-sm text-muted">{m.bio as string}</span>}
              </span>
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
}
