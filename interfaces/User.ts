export interface User {
  id: number;
  name: string;
}

export interface NewUser {
  name: string;
}

export interface UserWithBooks extends User {
  books: {
    past: PastBook[];
    present: PresentBook[];
  };
}

export interface PastBook {
  name: string;
  userScore: number | null;
}

export interface PresentBook {
  name: string;
}
