import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import Image from "next/image";
import { siteConfig } from "@/lib/siteConfig";
import { Skeleton } from "@/components/ui/skeleton";
import { Button } from "@/components/ui/button";
import { MinusIcon, PlusIcon } from "@radix-ui/react-icons";

const mintData = {
  total_supply: 4096,
  minted: 1589,
  price: 0.08,
  blockchain: "Base",
  smart_contract: "0x45..d7f",
};

export function MintSection() {
  return (
    <Card className="flex flex-col xl:flex-row xl:w-full">
      <CardHeader className="px-0 pt-0 xl:pb-0">
        <Skeleton className="w-[350px] h-[350px] xl:w-[600px] xl:h-[600px]" />
      </CardHeader>
      <CardContent className="py-0 xl:py-8 w-full">
        <div className="flex flex-col">
          <div className="flex mb-8">
            <div className="flex items-center justify-center gap-4 pr-4">
              <Button size="icon" variant="outline">
                <MinusIcon className="h-4 w-4" />
              </Button>
              <span className="text-xl font-semibold">{1}</span>
              <Button size="icon" variant="outline">
                <PlusIcon className="h-4 w-4" />
              </Button>
            </div>
            <Button className="w-full">Mint</Button>
          </div>
          <div className="flex justify-between mb-2">
            <CardTitle>{siteConfig.name}</CardTitle>
            <CardTitle>{mintData.price.toString()} ETH</CardTitle>
          </div>
          <div className="flex justify-between mb-2">
            <CardDescription className="my-2">Minted</CardDescription>
            <CardDescription className="my-2">{`${mintData.minted}/${mintData.total_supply}`}</CardDescription>
          </div>
          <div className="flex justify-between mb-2">
            <CardDescription className="my-2">Smart Contract</CardDescription>
            <CardDescription className="my-2">{mintData.smart_contract}</CardDescription>
          </div>
          <div className="flex justify-between mb-2">
            <CardDescription className="my-2">Blockchain</CardDescription>
            <CardDescription className="my-2">{mintData.blockchain}</CardDescription>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
