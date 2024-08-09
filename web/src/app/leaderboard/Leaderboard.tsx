import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import Image from "next/image";
import { siteConfig } from "@/lib/siteConfig";
import { Skeleton } from "@/components/ui/skeleton";
import { Button } from "@/components/ui/button";
import { MinusIcon, PlusIcon } from "@radix-ui/react-icons";
import { DataTable } from "./data-table";
import { columns } from "./columns";

type Users = {
  id: string;
  wallet_address: string;
  wins: number;
  claimed: number;
  nfts: number;
};

export const users: Users[] = [
  { id: "1", wallet_address: "0xEf...36c8", wins: 42, claimed: 802.02, nfts: 4 },
  { id: "2", wallet_address: "0xAc...47d2", wins: 40, claimed: 798.75, nfts: 3 },
  { id: "3", wallet_address: "0xBf...23a9", wins: 43, claimed: 809.5, nfts: 5 },
  { id: "4", wallet_address: "0xCd...18e4", wins: 41, claimed: 790.1, nfts: 4 },
  { id: "5", wallet_address: "0xDb...12f8", wins: 39, claimed: 775.6, nfts: 2 },
  { id: "6", wallet_address: "0xEa...67b3", wins: 45, claimed: 815.3, nfts: 6 },
  { id: "7", wallet_address: "0xFa...93c2", wins: 38, claimed: 768.8, nfts: 3 },
  { id: "8", wallet_address: "0xAb...54e6", wins: 44, claimed: 812.25, nfts: 5 },
  { id: "9", wallet_address: "0xBc...76f4", wins: 37, claimed: 762.5, nfts: 2 },
  { id: "10", wallet_address: "0xCc...89a1", wins: 46, claimed: 825.6, nfts: 6 },
  { id: "11", wallet_address: "0xDd...21b9", wins: 42, claimed: 805.45, nfts: 4 },
  { id: "12", wallet_address: "0xEf...34d7", wins: 40, claimed: 793.2, nfts: 3 },
  { id: "13", wallet_address: "0xFe...58a4", wins: 43, claimed: 810.75, nfts: 5 },
  { id: "14", wallet_address: "0xAa...12c3", wins: 41, claimed: 788.65, nfts: 4 },
  { id: "15", wallet_address: "0xBb...65e2", wins: 39, claimed: 776.9, nfts: 2 },
  { id: "16", wallet_address: "0xCc...98b7", wins: 45, claimed: 818.4, nfts: 6 },
  { id: "17", wallet_address: "0xDd...74f1", wins: 38, claimed: 771.1, nfts: 3 },
  { id: "18", wallet_address: "0xEe...32a5", wins: 44, claimed: 814.35, nfts: 5 },
  { id: "19", wallet_address: "0xFf...87b9", wins: 37, claimed: 765.55, nfts: 2 },
  { id: "20", wallet_address: "0xAa...54e8", wins: 46, claimed: 827.75, nfts: 6 },
];

export function Leaderboard() {
  return (
    <section className="px-0 w-full">
      <h2 className="text-4xl font-bold xl:text-8xl mb-4">Who Holds the Crown?</h2>
      <p className="text-xl xl:text-4xl mb-12 lg:mb-24">Find out who is leading the pack in ETH predictions.</p>
      <DataTable columns={columns} data={users} />
    </section>
  );
}
