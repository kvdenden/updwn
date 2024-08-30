import ConnectButton from "@/components/ConnectButton";
import { InfoSection } from "@/components/InfoSection";
import { MintSection } from "@/components/MintSection";
import { Leaderboard } from "@/app/leaderboard/Leaderboard";

export default function LeaderBoard() {
  return (
    <main className="flex flex-col items-center container mx-auto max-w-7xl justify-between py-12 px-2">
      <Leaderboard />
    </main>
  );
}
