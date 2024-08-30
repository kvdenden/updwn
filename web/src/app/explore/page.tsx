import { NftOverview } from "./NftOverview";

export default function Explore() {
  return (
    <main className="flex flex-col items-center container mx-auto max-w-7xl justify-between py-12 px-2">
      <h2 className="text-4xl font-bold xl:text-8xl mb-4">Find your next winner</h2>
      <p className="text-xl xl:text-4xl mb-12">Browse NFTs with high match rates and trade smart.</p>
      <NftOverview />
    </main>
  );
}
