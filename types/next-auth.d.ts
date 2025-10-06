import "next-auth";

declare module "next-auth" {
  interface Session {
    user: {
      name?: string | null;
      email?: string | null;
      image?: string | null;
      onboardingStep?: "STARTED" | "STARTUP_INFO" | "FIRST_PROMPT" | "COMPLETED";
    };
  }

  interface User {
    onboardingStep?:  "STARTED" | "STARTUP_INFO" | "FIRST_PROMPT" | "COMPLETED";
  }
}
