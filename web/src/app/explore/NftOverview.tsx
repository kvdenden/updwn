"use client";
import { Button } from "@/components/ui/button";
import { Skeleton } from "@/components/ui/skeleton";
import { Slider } from "@/components/ui/slider";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
  Pagination,
  PaginationContent,
  PaginationEllipsis,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from "@/components/ui/pagination";
import { useState } from "react";
import { cn } from "@/lib/utils";
import { getRandomPrice } from "@/lib/utils";

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
  { token_id: 128, wins: 34, claimed: 1234.56, current_matches: 4, isListed: false },
  { token_id: 129, wins: 56, claimed: 3456.78, current_matches: 7, isListed: true, price: getRandomPrice() },
  { token_id: 130, wins: 12, claimed: 789.01, current_matches: 2, isListed: false },
  { token_id: 131, wins: 98, claimed: 8765.43, current_matches: 11, isListed: true, price: getRandomPrice() },
  { token_id: 132, wins: 45, claimed: 2345.67, current_matches: 6, isListed: true, price: getRandomPrice() },
  { token_id: 133, wins: 76, claimed: 5678.9, current_matches: 8, isListed: false },
  { token_id: 134, wins: 19, claimed: 678.12, current_matches: 3, isListed: true, price: getRandomPrice() },
  { token_id: 135, wins: 88, claimed: 7890.12, current_matches: 10, isListed: true, price: getRandomPrice() },
  { token_id: 136, wins: 54, claimed: 1234.56, current_matches: 5, isListed: false },
  { token_id: 137, wins: 33, claimed: 3456.78, current_matches: 4, isListed: true, price: getRandomPrice() },
  { token_id: 138, wins: 65, claimed: 4567.89, current_matches: 7, isListed: false },
  { token_id: 139, wins: 21, claimed: 789.01, current_matches: 1, isListed: true, price: getRandomPrice() },
  { token_id: 140, wins: 87, claimed: 8765.43, current_matches: 11, isListed: true, price: getRandomPrice() },
  { token_id: 141, wins: 49, claimed: 2345.67, current_matches: 6, isListed: false },
  { token_id: 142, wins: 73, claimed: 5678.9, current_matches: 8, isListed: true, price: getRandomPrice() },
  { token_id: 143, wins: 29, claimed: 678.12, current_matches: 2, isListed: false },
  { token_id: 144, wins: 92, claimed: 7890.12, current_matches: 10, isListed: true, price: getRandomPrice() },
];

export function NftOverview() {
  const [sliderRange, setSliderRange] = useState([2, 12]);
  const [sortBy, setSortBy] = useState<"wins" | "claimed" | "current_matches" | "price">("current_matches");
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 4;
  const filteredNFTs = NFTS.filter(
    (nft) => nft.current_matches >= sliderRange[0] && nft.current_matches <= sliderRange[1]
  ).sort((a, b) => {
    switch (sortBy) {
      case "wins":
        return b.wins - a.wins;
      case "claimed":
        return b.claimed - a.claimed;
      case "current_matches":
        return b.current_matches - a.current_matches;
      case "price":
        return (b.price || 0) - (a.price || 0);
      default:
        return 0;
    }
  });
  const totalPages = Math.ceil(filteredNFTs.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;
  const displayedNFTs = filteredNFTs.slice(startIndex, endIndex);
  const handleSliderChange = (newRange: number[]) => {
    setSliderRange(newRange);
    setCurrentPage(1);
  };
  const handleSortChange = (option: "wins" | "claimed" | "current_matches" | "price") => {
    setSortBy(option);
    setCurrentPage(1);
  };
  const handlePageChange = (page: number) => {
    setCurrentPage(page);
  };
  return (
    <section className="px-0 w-full">
      <div className="my-12 flex flex-col xl:flex-row gap-12">
        <div className="flex flex-col w-full py-4">
          <p className="mb-4 text-sm">Number of correct predictions</p>
          <Slider
            defaultValue={[2, 12]}
            max={12}
            step={1}
            minStepsBetweenThumbs={1}
            onValueCommit={handleSliderChange}
          />
          <div className="flex justify-between mt-4">
            <span>Min: {sliderRange[0]}</span>
            <span>Max: {sliderRange[1]}</span>
          </div>
        </div>
        <div className="w-full py-4 ">
          <p className="mb-4 text-sm">Sort by</p>
          <div className="flex gap-4 justify-start items-center">
            <Button
              size={"sm"}
              onClick={() => handleSortChange("price")}
              variant={sortBy === "price" ? "ghost" : "default"}
            >
              Price
            </Button>
            <Button
              size={"sm"}
              onClick={() => handleSortChange("wins")}
              variant={sortBy === "wins" ? "ghost" : "default"}
            >
              Wins
            </Button>

            <Button
              size={"sm"}
              onClick={() => handleSortChange("current_matches")}
              variant={sortBy === "current_matches" ? "ghost" : "default"}
            >
              Matches
            </Button>
          </div>
        </div>
      </div>
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4  w-full">
        {displayedNFTs.map((nft) => (
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

                  <DropdownMenu>
                    <DropdownMenuTrigger className="w-full mt-6 mb-4">
                      <Button className="w-full my-2" size="sm">
                        Go to Marketplace
                      </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent className="w-full">
                      <DropdownMenuItem>
                        {" "}
                        <a className="w-full h-full" href="https://opensea.io/" target="_blank" rel="noreferrer">
                          Opensea
                        </a>
                      </DropdownMenuItem>
                      <DropdownMenuItem>
                        <a className="w-full h-full" href="https://blur.io/" target="_blank" rel="noreferrer">
                          Blur
                        </a>
                      </DropdownMenuItem>
                      <DropdownMenuItem>
                        <a className="w-full h-full" href="https://magiceden.io" target="_blank" rel="noreferrer">
                          Magic Eden
                        </a>
                      </DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
      <div className="flex justify-center mt-8">
        <Pagination>
          <PaginationContent>
            <PaginationItem className="hidden xl:block">
              <PaginationPrevious
                href="#"
                onClick={(e) => {
                  e.preventDefault();
                  if (currentPage > 1) handlePageChange(currentPage - 1);
                }}
                className={cn("text-xs xl:text-md", currentPage <= 1 ? "pointer-events-none opacity-50" : "")}
              />
            </PaginationItem>
            {[...Array(totalPages)].map((_, index) => {
              const pageNumber = index + 1;
              if (
                pageNumber === 1 ||
                pageNumber === totalPages ||
                (pageNumber >= currentPage - 1 && pageNumber <= currentPage + 1)
              ) {
                return (
                  <PaginationItem key={pageNumber}>
                    <PaginationLink
                      href="#"
                      onClick={(e) => {
                        e.preventDefault();
                        handlePageChange(pageNumber);
                      }}
                      isActive={pageNumber === currentPage}
                      className={"text-xs xl:text-md"}
                    >
                      {pageNumber}
                    </PaginationLink>
                  </PaginationItem>
                );
              } else if (
                (pageNumber === currentPage - 2 && currentPage > 3) ||
                (pageNumber === currentPage + 2 && currentPage < totalPages - 2)
              ) {
                return <PaginationEllipsis className="text-xs xl:text-md" key={pageNumber} />;
              }
              return null;
            })}
            <PaginationItem className="hidden xl:block">
              <PaginationNext
                href="#"
                onClick={(e) => {
                  e.preventDefault();
                  if (currentPage < totalPages) handlePageChange(currentPage + 1);
                }}
                className={cn("text-xs xl:text-md", currentPage >= totalPages ? "pointer-events-none opacity-50" : "")}
              />
            </PaginationItem>
          </PaginationContent>
        </Pagination>
      </div>
    </section>
  );
}
