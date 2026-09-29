import Link from "next/link";

export const metadata = { title: "21+ only" };

export default function SorryPage() {
  return (
    <div className="flex flex-col gap-4 text-center">
      <h1 className="text-3xl font-bold">VYBR8 is 21+</h1>
      <p className="text-muted">You need to be 21 or older to use VYBR8. We didn&rsquo;t save your details.</p>
      <Link href="/" className="font-semibold text-sky">Back to the home page</Link>
    </div>
  );
}
