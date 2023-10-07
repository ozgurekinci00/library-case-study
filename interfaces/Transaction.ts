export interface Transaction {
  userId: number;
  bookId: number;
  borrowedAt: Date;
  returnedAt: Date | null;
  score: number | null;
}

export interface NewTransaction {
  userId: number;
  bookId: number;
  borrowedAt: Date;
  returnedAt?: Date | null;
  score?: number | null;
}
