"use client";

import { useActionState, useState } from "react";
import { Button } from "@/components/ui/Button";
import { applyForCreator } from "./actions";

const TYPES = [
  { value: "big_back", title: "Big Back", line: "Food is your thing: plates, portions, comfort food, desserts.", tone: "text-orange" },
  { value: "liquid_lover", title: "Liquid Lover", line: "Drinks are your thing: cocktails, happy hours, lounges.", tone: "text-sky" },
  { value: "both", title: "Both", line: "You post the plate and the pour.", tone: "text-coral" },
];

export function ApplyForm() {
  const [state, action, pending] = useActionState(applyForCreator, {});
  const [type, setType] = useState("big_back");
  const input = "min-h-11 rounded-xl border border-line bg-surface px-3";

  return (
    <form action={action} className="flex flex-col gap-6">
      <fieldset className="flex flex-col gap-2">
        <legend className="mb-2 text-sm font-semibold">What kind of creator are you?</legend>
        {TYPES.map((t) => (
          <label key={t.value} className={`flex cursor-pointer flex-col gap-1 rounded-2xl border p-4 ${type === t.value ? "vybe-ring" : "border-line hover:bg-surface-2"}`}>
            <span className="flex items-center gap-3">
              <input type="radio" name="creatorType" value={t.value} checked={type === t.value} onChange={() => setType(t.value)} className="size-4 accent-[var(--color-coral)]" />
              <span className={`font-display text-lg font-bold ${t.tone}`}>{t.title}</span>
            </span>
            <span className="pl-7 text-sm text-muted">{t.line}</span>
          </label>
        ))}
      </fieldset>

      <div className="flex flex-col gap-1.5">
        <label htmlFor="pitch" className="text-sm font-semibold">Why should we verify you?</label>
        <textarea id="pitch" name="pitch" required minLength={20} maxLength={1000} rows={4} placeholder="What you post, where you eat and drink, what makes your reviews worth following." className="rounded-xl border border-line bg-surface px-3 py-2" />
      </div>
      <div className="flex flex-col gap-1.5">
        <label htmlFor="city" className="text-sm font-semibold">Your city</label>
        <input id="city" name="city" maxLength={80} className={input} />
      </div>
      <fieldset className="flex flex-col gap-3">
        <legend className="mb-1 text-sm font-semibold">Where else you post <span className="font-normal text-faint">(optional)</span></legend>
        <input aria-label="Instagram link" name="instagram" type="url" placeholder="https://instagram.com/you" className={input} />
        <input aria-label="TikTok link" name="tiktok" type="url" placeholder="https://tiktok.com/@you" className={input} />
        <input aria-label="Other link" name="other" type="url" placeholder="https://…" className={input} />
      </fieldset>

      {type !== "big_back" && (
        <label className="flex items-start gap-3 rounded-2xl border border-line bg-surface p-4 text-sm">
          <input type="checkbox" name="is21" required className="mt-0.5 size-5 accent-[var(--color-coral)]" />
          <span>I confirm I am 21 or older. Liquid Lover posts are about alcohol, so we only verify adults of legal drinking age.</span>
        </label>
      )}

      <div aria-live="polite" className="min-h-5 text-sm">{state.error && <p className="text-danger">{state.error}</p>}</div>
      <Button type="submit" disabled={pending} className="self-start">{pending ? "Sending…" : "Send application"}</Button>
    </form>
  );
}
