import ConnectButton from "@/components/ConnectButton";
import { InfoSection } from "@/components/InfoSection";
import { MintSection } from "@/components/MintSection";

export default function Home() {
  return (
    <main className="flex flex-col items-center container mx-auto max-w-7xl justify-between py-12 px-0">
      <MintSection />
      <InfoSection />
    </main>
  );
}
