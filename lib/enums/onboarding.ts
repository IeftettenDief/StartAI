export const OnboardingStep = {
  USER_PROFILE: 'USER_PROFILE',
  STARTUP_INFO: 'STARTUP_INFO',
  FIRST_PROMPT: 'FIRST_PROMPT',
  COMPLETED: 'COMPLETED',
} as const;

export type OnboardingStep = typeof OnboardingStep[keyof typeof OnboardingStep];

export const ONBOARDING_STEP_ORDER = [
  OnboardingStep.USER_PROFILE,
  OnboardingStep.STARTUP_INFO,
  OnboardingStep.FIRST_PROMPT,
  OnboardingStep.COMPLETED,
] as const;

export const ONBOARDING_ROUTES: Record<OnboardingStep, string> = {
  [OnboardingStep.USER_PROFILE]: '/onboarding/profile',
  [OnboardingStep.STARTUP_INFO]: '/onboarding/startup',
  [OnboardingStep.FIRST_PROMPT]: '/onboarding/first-prompt',
  [OnboardingStep.COMPLETED]: '/dashboard',
};