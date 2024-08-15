import { getRandomPrice } from "@/lib/utils";
import { Skeleton } from "@/components/ui/skeleton";

import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { DataTable } from "./data-table";
import { columns } from "./columns";
interface NFT {
  token_id: number;
  wins: number;
  claimed: number;
  current_matches: number;
  price?: number;
  isListed: boolean;
}

const NFTS: NFT[] = [
  { token_id: 124, wins: 43, claimed: 567.89, current_matches: 5, isListed: true, price: getRandomPrice() },
  { token_id: 125, wins: 67, claimed: 2345.67, current_matches: 9, isListed: false },
  { token_id: 126, wins: 23, claimed: 678.12, current_matches: 3, isListed: true, price: getRandomPrice() },
  { token_id: 127, wins: 89, claimed: 9876.54, current_matches: 10, isListed: true, price: getRandomPrice() },
];

type Action = {
  date: string;
  action: string;
  detail: string;
};

const history: Action[] = [
  {
    date: "2023-08-15",
    action: "Mint",
    detail: "Minted NFT #1234",
  },
  {
    date: "2023-08-14",
    action: "Buy",
    detail: "Bought NFT #5678",
  },
  {
    date: "2023-08-13",
    action: "Sell",
    detail: "Sold NFT #91011",
  },
  {
    date: "2023-08-12",
    action: "Win",
    detail: "NFT #4068 Won",
  },
  {
    date: "2023-08-11",
    action: "Claim",
    detail: "Claimed $645.12",
  },
  {
    date: "2023-08-10",
    action: "Vote",
    detail: "Voted on Proposal #2",
  },
  {
    date: "2023-08-09",
    action: "Mint",
    detail: "Minted NFT #1415",
  },
  {
    date: "2023-08-08",
    action: "Buy",
    detail: "Bought NFT #1617",
  },
  {
    date: "2023-08-07",
    action: "Sell",
    detail: "Sold NFT #1819",
  },
  {
    date: "2023-08-06",
    action: "Win",
    detail: "NFT #425 Won",
  },
  {
    date: "2023-08-05",
    action: "Claim",
    detail: "Claimed $528.45",
  },
  {
    date: "2023-08-04",
    action: "Vote",
    detail: "Voted on Proposal #3",
  },
  {
    date: "2023-08-03",
    action: "Mint",
    detail: "Minted NFT #2021",
  },
  {
    date: "2023-08-02",
    action: "Buy",
    detail: "Bought NFT #2223",
  },
  {
    date: "2023-08-01",
    action: "Sell",
    detail: "Sold NFT #2425",
  },
  {
    date: "2023-07-31",
    action: "Win",
    detail: "NFT #1874 Won",
  },
  {
    date: "2023-07-30",
    action: "Claim",
    detail: "Claimed $486.65",
  },
  {
    date: "2023-07-29",
    action: "Vote",
    detail: "Voted on Proposal #4",
  },
  {
    date: "2023-07-28",
    action: "Mint",
    detail: "Minted NFT #2627",
  },
  {
    date: "2023-07-27",
    action: "Buy",
    detail: "Bought NFT #2829",
  },
];

const stats = {
  "Total claimed": "$1578.10",
};

export default function Profile() {
  return (
    <main className="flex flex-col  container mx-auto max-w-7xl justify-between py-12 px-2">
      <h2 className="text-4xl font-bold xl:text-8xl mb-4">
        You can win
        <br /> in 3 days
      </h2>
      <p className="text-xl xl:text-4xl mb-12">Browse your collection, analyze Your Stats and Maximize Your odds.</p>
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 w-full mb-12">
        {Object.entries(stats).map(([key, value]) => (
          <Card key={key} className="flex flex-col">
            <CardHeader className="text-muted-foreground">{key}</CardHeader>
            <CardContent className="mt-auto">
              <h1 className="text-4xl mt-auto font-bold">{value}</h1>
            </CardContent>
          </Card>
        ))}
      </div>
      <h2 className="text-4xl font-bold xl:text-2xl mb-4">My NFTs (4)</h2>

      <div className="grid grid-cols-1 mb-12 gap-4 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4  w-full">
        {NFTS.map((nft) => (
          <div
            key={nft.token_id}
            className="overflow-hidden rounded-lg shadow-lg transition-all duration-300 hover:shadow-xl border  w-full"
          >
            <Skeleton className="w-full min-w-[300px] h-[300px] mx-auto" /> {/* Adjust size as needed */}
            <div className="bg-background p-4 w-full">
              <div className="flex items-center justify-between w-full">
                <div className="w-full">
                  <div className="flex justify-between">
                    <h3 className="text-lg font-bold">{`UP/DWN ${nft.token_id}`}</h3>
                    <h3 className="text-lg font-bold">{nft.isListed ? `${nft.price} ETH` : `-`}</h3>
                  </div>
                  <h3 className="text-muted-foreground text-xs">{`Wins: ${nft.wins}`}</h3>
                  <p className="text-muted-foreground text-xs">{`Total Claimed: $${nft.claimed}`}</p>
                  <p className="text-muted-foreground text-xs">{`# of matches: ${nft.current_matches}`}</p>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>

      <h2 className="text-4xl font-bold xl:text-2xl mb-4">History</h2>
      <DataTable columns={columns} data={history} />
    </main>
  );
}
