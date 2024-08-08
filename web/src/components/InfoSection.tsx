import { Skeleton } from "@/components/ui/skeleton";

const items = [
  {
    title: "Match the pattern",
    description: "Own the NFT with the pattern of the past 12 days of ETH price movements to win.",
  },
  {
    title: "Trade and Win",
    description: "Predict market movements and buy the right NFTs. Trade strategically to maximize your rewards.",
  },
  {
    title: "Sustainable prize pool",
    description: "All proceeds are invested in DeFi. The generated yield forms the daily prize pool.",
  },
  {
    title: "Provably fair",
    description:
      "Anyone can trigger snapshots, which are stored on-chain, when 24 hours have passed since the previous one.",
  },
  {
    title: "For the community",
    description:
      "UPDWN is built by and for the community. Together we will decide how the treasury is invested and explore ways to grow it.",
  },
];

export function InfoSection() {
  return (
    <section className="container mx-auto max-w-7xl py-12 lg:py-24 px-2">
      <h2 className="text-4xl font-bold xl:text-8xl mb-4">
        One Winner,
        <br />
        Every Day,
        <br /> Forever.
      </h2>
      <p className="text-xl xl:text-4xl mb-12 lg:mb-24">
        UPDWN is an experimental trading game with a daily winner. Pay once, trade smart and stay in the game forever.
      </p>
      {items.map((item, i) => (
        <div className={`mb-12 lg:mb-12 grid grid-cols-1 xl:grid-cols-2`} key={i}>
          <div className={`hidden flex flex-col  p-4 xl:block ${i % 2 === 0 ? "order-1" : "order-0"}`}>
            <Skeleton className="w-full w-[250px] h-[250px] mx-auto" /> {/* Adjust size as needed */}
          </div>

          <div className="flex flex-col justify-center">
            <h2 className="font-bold text-lg">{item.title}</h2>
            <p>{item.description}</p>
          </div>
        </div>
      ))}
    </section>
  );
}
