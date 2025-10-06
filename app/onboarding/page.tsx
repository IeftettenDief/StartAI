import { requireAuth } from '@/lib/guard/auth-guard';
import { OnboardingStep } from '@/lib/enums/onboarding';
import UserProfileStep from './components/userProfileStep'
// import StartupInfoStep from './components/startupInfoStep';
// import FirstPromptStep from './components/firstPromptStep';
import { redirect } from 'next/navigation';

export default async function OnboardingPage() {
  const session = await requireAuth();
  const step = OnboardingStep.USER_PROFILE;

  switch (step) {
    case OnboardingStep.USER_PROFILE:
      return <UserProfileStep />;
    // case OnboardingStep.STARTUP_INFO:
    //   return <StartupInfoStep />;
    // case OnboardingStep.FIRST_PROMPT:
    //   return <FirstPromptStep />;
    case OnboardingStep.COMPLETED:
      redirect('/dashboard');
    default:
      redirect('/dashboard');
  }
}
