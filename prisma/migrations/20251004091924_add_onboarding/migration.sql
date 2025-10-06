-- CreateEnum
CREATE TYPE "OnboardingStep" AS ENUM ('NOT_STARTED', 'USER_PROFILE', 'STARTUP_INFO', 'FIRST_PROMPT', 'COMPLETED');

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "onboarding_step" "OnboardingStep" NOT NULL DEFAULT 'NOT_STARTED';
