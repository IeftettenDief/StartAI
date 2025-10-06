import NextAuth from "next-auth";
import type { NextAuthConfig } from "next-auth";
import { PrismaAdapter } from "@auth/prisma-adapter";
import prisma  from "@/lib/prisma";
import EmailProvider from "next-auth/providers/email";
import { OnboardingStep } from "../enums/onboarding";
import "next-auth";

declare module "next-auth" {
    interface User {
    onboardingStep: OnboardingStep;
  }
}


export const authOptions: NextAuthConfig = {
  adapter: PrismaAdapter(prisma),
 providers: [
    EmailProvider({
      server: process.env.EMAIL_SERVER,
      from: process.env.EMAIL_FROM,
    }),
  ],
  session: {
    strategy: "jwt",
  },
  callbacks: {
    session({ session, user }) {
    if (user && session.user) {
        session.user.id = user.id;
        session.user.onboardingStep = user.onboardingStep;
      }
    return session;
    },
  },
};

export const { handlers, auth, signIn, signOut } = NextAuth(authOptions);