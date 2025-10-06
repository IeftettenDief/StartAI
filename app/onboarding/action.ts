'use server';

import prisma from "../../lib/prisma";
import { requireAuth } from '@/lib/guard/auth-guard';
import { OnboardingStep } from '@/lib/enums/onboarding';
import { revalidatePath } from 'next/cache';

export async function updateOnboardingStep(nextStep: OnboardingStep) {
  const session = await requireAuth();

  await prisma.user.update({
    where: { id: session.user?.id },
    data: { onboarding_step: nextStep },
  });
  console.log("test3");
  revalidatePath('/onboarding');
}
