"use client";
import { useState } from "react";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import Image from "next/image";
import { siteConfig } from "@/lib/siteConfig";
import { Skeleton } from "@/components/ui/skeleton";
import { Button } from "@/components/ui/button";
import { ChevronLeftIcon, ChevronRightIcon } from "@radix-ui/react-icons";

const roundsArray = [
  {
    prize: 0.08,
    owner: "0x45b6..d7f9",
    winner: 1234,
    date: "2024-08-18",
    isClaimed: true,
  },
  {
    prize: 0.07,
    owner: "0x12a3..f8d4",
    winner: 987,
    date: "2024-08-17",
    isClaimed: true,
  },
  {
    prize: 0.1,
    owner: "0xab34..cdef",
    winner: 2567,
    date: "2024-08-16",
    isClaimed: true,
  },
  {
    prize: 0.06,
    owner: "0x789b..d9e1",
    winner: 350,
    date: "2024-08-15",
    isClaimed: true,
  },
  {
    prize: 0.12,
    owner: "0x23de..ab45",
    winner: 4090,
    date: "2024-08-14",
    isClaimed: true,
  },
  {
    prize: 0.09,
    owner: "0x567f..e12c",
    winner: 1023,
    date: "2024-08-13",
    isClaimed: true,
  },
  {
    prize: 0.11,
    owner: "0xacbd..f34e",
    winner: 3072,
    date: "2024-08-12",
    isClaimed: true,
  },
  {
    prize: 0.08,
    owner: "0x789c..d1a2",
    winner: 2001,
    date: "2024-08-11",
    isClaimed: true,
  },
  {
    prize: 0.07,
    owner: "0x234e..bc56",
    winner: 4096,
    date: "2024-08-10",
    isClaimed: true,
  },
  {
    prize: 0.09,
    owner: "not claimed",
    winner: 987,
    date: "2024-08-19",
    isClaimed: false,
  },
];

export function ClaimSection() {
  const [currentIndex, setCurrentIndex] = useState(0);

  const handlePrev = () => {
    setCurrentIndex((prevIndex) => (prevIndex < roundsArray.length - 1 ? prevIndex + 1 : 0));
  };

  const handleNext = () => {
    setCurrentIndex((prevIndex) => (prevIndex > 0 ? prevIndex - 1 : roundsArray.length - 1));
  };

  const currentRound = roundsArray[currentIndex];

  return (
    <Card className="flex flex-col xl:flex-row xl:w-full">
      <CardHeader className="px-0 pt-0 xl:pb-0">
        <Skeleton className="w-[350px] h-[350px] xl:w-[600px] xl:h-[600px]" />
      </CardHeader>
      <CardContent className="py-0 xl:py-8 w-full">
        <div className="flex flex-col justify-center">
          <div className="flex items-center mb-8">
            <div className="flex items-center justify-center gap-4 pr-4">
              <Button size="icon" variant="outline" className="rounded-full" onClick={handlePrev}>
                <ChevronLeftIcon className="h-4 w-4" />
              </Button>
              <Button size="icon" variant="outline" className="rounded-full" onClick={handleNext}>
                <ChevronRightIcon className="h-4 w-4" />
              </Button>
            </div>
            <p className="text-xl font-semibold">{currentRound.date}</p>
          </div>
          {!currentRound.isClaimed && <Button className="w-full mb-8">Claim</Button>}

          <div className="flex flex-co justify-between mb-2">
            <CardTitle className="text-4xl">{`UP/DWN # ${currentRound.winner}`}</CardTitle>
          </div>

          <div className="flex justify-between mb-2">
            <CardDescription className="my-2">Prize</CardDescription>
            <CardDescription className="my-2">{currentRound.prize} ETH</CardDescription>
          </div>
          <div className="flex justify-between mb-2">
            <CardDescription className="my-2">Claimed by</CardDescription>
            <CardDescription className="my-2">{currentRound.owner}</CardDescription>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
