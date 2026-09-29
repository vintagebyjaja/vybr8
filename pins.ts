/** Serializable pin data the server hands to the Vybe Map. */
export type MapVenue = {
  id: string; // location id
  businessSlug: string;
  name: string;
  kind: string;
  priceLevel: number | null;
  logoUrl: string | null;
  isDemo: boolean;
  x: number;
  y: number;
  openNow: boolean | null; // null = hours unknown
  photo: { src: string; alt: string; rating: number | null; postId: string; isAlcoholic: boolean } | null;
};

export type MapLinkup = {
  id: string;
  title: string;
  occasion: string;
  when: string;
  x: number;
  y: number;
  spotsLeft: number;
  capacity: number;
  isAlcoholic: boolean;
  openToNewFriends: boolean;
  venueName: string | null;
};

export type MapFriend = {
  userId: string;
  username: string;
  name: string;
  intent: "eat" | "drink" | "link_up";
  note: string | null;
  venueName: string | null;
  x: number | null; // null when not at a listed place (shown in the side list only)
  y: number | null;
};

export type MapData = {
  city: { slug: string; name: string; region: string };
  venues: MapVenue[];
  linkups: MapLinkup[];
  friends: MapFriend[];
  myStatus: { intent: "eat" | "drink" | "link_up"; note: string | null; expiresAt: string } | null;
};
