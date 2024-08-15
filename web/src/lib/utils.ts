import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export function getRandomPrice(): number {
  return parseFloat((0.08 + Math.random() * (0.17 - 0.08)).toFixed(2));
}
