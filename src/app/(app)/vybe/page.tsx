import { ComingSoon } from "@/components/ui/ComingSoon";
import { requireViewer } from "@/server/auth";
export const metadata = { title: "Link Ups" };
export default async function VybePage() {
  await requireViewer("/vybe");
  return (
    <ComingSoon
      phase="Phase 6 · Link Ups + Group Vybe"
      title="Link Up"
      tagline="Plan the outing, then let Group Vybe find a place everyone can actually order from."
      points={["Set tonight's budget per person, separate from your usual spending", "See why each spot works, and why others were ruled out", "What each person might order, with an estimated total and per-person cost"]}
    />
  );
}
