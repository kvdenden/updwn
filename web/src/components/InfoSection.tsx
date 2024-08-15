import { Skeleton } from "@/components/ui/skeleton";

const items = [
  {
    title: "Get your ticket",
    description:
      "Mint your unique pattern of ETH price movements. Patterns have 12 slots that indicate upwards or downwards price changes.",
  },
  {
    title: "Tracking ETH Together",
    description:
      "Snapshots of ETH's price movement (sourced from Chainlink) are stored onchain daily. Anyone can trigger a snapshot, when 24 hours have passed since the previous one.",
  },
  {
    title: "Match the pattern",
    description:
      "To win, you need to hold the ticket whose pattern perfectly matches the actual ETH price movements for the past 12 days.",
  },
  {
    title: "The daily prize",
    description:
      "100% of the funds are used to provide liquidity to DeFi protocols, generating yield. Daily prizes are based on this yield, creating a sustainable reward system.",
  },
  {
    title: "Growing the prize pool",
    description:
      "All royalties and a part of the generated yield are added to the treasury, creating a compounding effect and growing future prizes.",
  },
  {
    title: "One Ticket, Endless Entries",
    description:
      "Purchase your ticket once, and you're set for all future draws. Your ticket remains active indefinitely, giving you a shot at the daily prize every single day without any additional cost.",
  },
  {
    title: "Strategic Trading",
    description:
      "Buy and sell tickets in the open market to boost your chances. Spot trends, make smart trades and grow your odds of holding a winning pattern.",
  },
  {
    title: "For the community",
    description:
      "UPDWN is built by and for the community. Using onchain governance we will decide how the treasury is invested and explore ways to grow it.",
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
      <p className="text-xl xl:text-4xl text-muted-foreground mb-12 lg:mb-24">
        UPDWN is an experimental trading game with a daily winner. Pay once, trade smart and stay in the game forever.
      </p>
      {items.map((item, i) => (
        <div className={`mb-12 lg:mb-12 grid grid-cols-1 xl:grid-cols-2`} key={i}>
          <div className={`hidden flex flex-col  p-4 xl:block ${i % 2 === 0 ? "order-1" : "order-0"}`}>
            <Skeleton className="w-full w-[250px] h-[250px] mx-auto" /> {/* Adjust size as needed */}
          </div>

          <div className="flex flex-col justify-center">
            <h2 className="font-bold text-lg">{item.title}</h2>
            <p className="text-muted-foreground">{item.description}</p>
          </div>
        </div>
      ))}
    </section>
  );
}
