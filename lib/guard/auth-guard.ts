import { auth } from "../auth";
import { redirect } from "next/navigation";
import { OnboardingStep } from "../enums/onboarding";

export async function requireAuth() {
  const session = await auth();
  if (!session || !session.user) {
    console.log(session?.user)
    console.log("niga");
    redirect("/login");
  }
  
  return session;
}

export async function requireGuest() {
  const session = await auth();
  if (session) {
    redirect("/dashboard");
  }
}

export async function requireCompleted() {
  const session = await requireAuth();
  console.log(session.user);
  // @ts-ignore
  if (session.user?.onboardingStep !== OnboardingStep.COMPLETED) {
      redirect('/onboarding');
  }

  return session;
}